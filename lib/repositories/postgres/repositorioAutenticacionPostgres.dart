// Alternativa experimental de escritorio. No se utiliza en el MVP de la Etapa 1.
// Importa la conversión de texto a bytes.
import 'dart:convert';
// Importa las variables del entorno de la computadora.
import 'dart:io';
// Importa el generador seguro de identificadores.
import 'dart:math';
// Importa la comprobación de contraseñas BCrypt.
import 'package:bcrypt/bcrypt.dart';
// Importa la conexión directa a PostgreSQL.
import 'package:postgres/postgres.dart';
// Importa el modelo de la cuenta.
import 'package:app_tutorias/models/modeloUsuario.dart';
// Importa el contrato y los errores de autenticación.
import 'package:app_tutorias/repositories/repositorioAutenticacion.dart';

// Repositorio para la demostración local con PostgreSQL.
class PostgresAuthRepository implements AuthRepository {
  // Mantiene compatible el directorio con la implementación experimental de PostgreSQL.
  @override
  Future<List<Usuario>> obtenerUsuarios() async {
    // Reutiliza la conexión y la configuración existentes.
    final conexion = await _abrirConexion();
    // Garantiza que la conexión se cierre incluso si falla la consulta.
    try {
      // Lee solo datos públicos de las cuentas activas; nunca consulta contraseñas.
      final resultado = await conexion.execute(
        // Conserva los nombres de columnas esperados por el modelo Usuario.
        'SELECT id, nombre, correo, rol FROM public.usuarios WHERE activo = TRUE ORDER BY nombre',
      );
      // Convierte las filas en una lista que los consumidores no pueden modificar.
      return List<Usuario>.unmodifiable(
        // Reutiliza la conversión del modelo para validar también el rol.
        resultado.map((fila) => Usuario.fromMap(fila.toColumnMap())),
      );
    } finally {
      // Libera la conexión al terminar la lectura.
      await conexion.close();
    }
  }

  // Abre una conexión nueva para cada operación.
  Future<Connection> _abrirConexion() async {
    // Obtiene las credenciales del entorno de Windows.
    final usuarioBase =
        Platform.environment['TUTORIAS_DB_USUARIO'] ?? 'postgres';

    final claveBase = Platform.environment['TUTORIAS_DB_CLAVE'] ?? '';

    // Comprueba que se haya configurado la contraseña.
    if (claveBase.isEmpty) {
      throw const ErrorAutenticacion(
        'Falta configurar la contraseña de PostgreSQL.',
      );
    }

    try {
      // Se conecta a PostgreSQL en esta misma computadora.
      return await Connection.open(
        Endpoint(
          host: '127.0.0.1',
          port: 5432,
          database: 'tutorias',
          username: usuarioBase,
          password: claveBase,
        ),
        settings: const ConnectionSettings(
          // Esta configuración es únicamente para la prueba local.
          sslMode: SslMode.disable,
          connectTimeout: Duration(seconds: 5),
          queryTimeout: Duration(seconds: 10),
        ),
      );
    } catch (_) {
      throw const ErrorAutenticacion(
        'No se pudo conectar con PostgreSQL. '
        'Revisa que esté encendido y verifica las credenciales.',
      );
    }
  }

  // Comprueba la estructura básica del correo.
  void _validarCorreo(String correo) {
    final partes = correo.split('@');

    if (correo.length > 150 ||
        partes.length != 2 ||
        partes[0].isEmpty ||
        !partes[1].contains('.') ||
        partes[1].startsWith('.') ||
        partes[1].endsWith('.')) {
      throw const ErrorAutenticacion('Escribe un correo válido.');
    }

    // Evita espacios y saltos de línea dentro del correo.
    for (final caracter in correo.split('')) {
      if (caracter.trim().isEmpty) {
        throw const ErrorAutenticacion('El correo no debe contener espacios.');
      }
    }
  }

  // Genera un identificador aleatorio de 32 caracteres.
  String _crearIdentificador() {
    final generador = Random.secure();
    String identificador = '';

    for (int posicion = 0; posicion < 16; posicion++) {
      final numero = generador.nextInt(256);
      identificador += numero.toRadixString(16).padLeft(2, '0');
    }

    return identificador;
  }

  @override
  Future<Usuario> iniciarSesion(String correo, String contrasena) async {
    // Normaliza únicamente el correo; conserva la contraseña exacta.
    final correoNormalizado = correo.trim().toLowerCase();

    if (correoNormalizado.isEmpty || contrasena.isEmpty) {
      throw const ErrorAutenticacion('Escribe tu correo y contraseña.');
    }

    _validarCorreo(correoNormalizado);

    // BCrypt admite contraseñas de hasta 72 bytes.
    if (utf8.encode(contrasena).length > 72) {
      throw const ErrorAutenticacion('Correo o contraseña incorrectos.');
    }

    final conexion = await _abrirConexion();

    try {
      // Los parámetros se envían separados de la consulta.
      final resultado = await conexion.execute(
        Sql.named('''
          SELECT id, nombre, correo, "contrasenaHash", rol, activo
          FROM public.usuarios
          WHERE lower(trim(correo)) = @correo
          '''),
        parameters: {'correo': correoNormalizado},
      );

      // Rechaza cuentas inexistentes y correos duplicados.
      if (resultado.length != 1) {
        throw const ErrorAutenticacion('Correo o contraseña incorrectos.');
      }

      final cuenta = resultado.first.toColumnMap();

      // Una cuenta deshabilitada no puede ingresar.
      if (cuenta['activo'] != true) {
        throw const ErrorAutenticacion('Correo o contraseña incorrectos.');
      }

      final contrasenaHash = cuenta['contrasenaHash'];

      if (contrasenaHash is! String) {
        throw const ErrorAutenticacion(
          'La cuenta no tiene una contraseña válida.',
        );
      }

      bool contrasenaCorrecta = false;

      try {
        // Compara la contraseña escrita con el hash almacenado.
        contrasenaCorrecta = BCrypt.checkpw(contrasena, contrasenaHash);
      } catch (_) {
        // Un hash dañado tampoco permite ingresar.
        throw const ErrorAutenticacion(
          'No se pudo comprobar la contraseña de esta cuenta.',
        );
      }

      if (!contrasenaCorrecta) {
        throw const ErrorAutenticacion('Correo o contraseña incorrectos.');
      }

      // El modelo obtiene el rol de la cuenta, no del formulario.
      // Usuario.fromMap no conserva el hash de la contraseña.
      return Usuario.fromMap(cuenta);
    } finally {
      // Cierra la conexión aunque ocurra un error.
      await conexion.close();
    }
  }

  @override
  Future<Usuario> registrar({
    required String nombre,
    required String correo,
    required String contrasena,
    required Rol rol,
  }) async {
    final nombreLimpio = nombre.trim();
    final correoNormalizado = correo.trim().toLowerCase();

    // El registro público no permite crear administradores.
    if (rol != Rol.alumno && rol != Rol.tutor) {
      throw const ErrorAutenticacion(
        'Solo puedes registrarte como alumno o tutor.',
      );
    }

    if (nombreLimpio.length < 2 || nombreLimpio.length > 120) {
      throw const ErrorAutenticacion(
        'El nombre debe tener entre 2 y 120 caracteres.',
      );
    }

    _validarCorreo(correoNormalizado);

    if (contrasena.trim().length < 8) {
      throw const ErrorAutenticacion(
        'La contraseña debe tener al menos 8 caracteres.',
      );
    }

    if (utf8.encode(contrasena).length > 72) {
      throw const ErrorAutenticacion(
        'La contraseña supera el máximo de 72 bytes.',
      );
    }

    // Genera el identificador y el hash antes de abrir la transacción.
    final identificador = _crearIdentificador();

    final contrasenaHash = BCrypt.hashpw(contrasena, BCrypt.gensalt());

    final conexion = await _abrirConexion();

    try {
      // Agrupa la comprobación del correo y la inserción.
      return await conexion.runTx<Usuario>((transaccion) async {
        // Ordena los registros simultáneos sin agregar UNIQUE.
        await transaccion.execute(
          'LOCK TABLE public.usuarios IN SHARE ROW EXCLUSIVE MODE',
        );

        final existentes = await transaccion.execute(
          Sql.named('''
            SELECT id
            FROM public.usuarios
            WHERE lower(trim(correo)) = @correo
            '''),
          parameters: {'correo': correoNormalizado},
        );

        // La validación de duplicados está en el software.
        if (existentes.isNotEmpty) {
          throw const ErrorAutenticacion(
            'Ya existe una cuenta con ese correo.',
          );
        }

        final resultado = await transaccion.execute(
          Sql.named('''
            INSERT INTO public.usuarios
              (id, nombre, correo, "contrasenaHash", rol, activo)
            VALUES
              (@id, @nombre, @correo, @contrasenaHash, @rol, TRUE)
            RETURNING id, nombre, correo, rol
            '''),
          parameters: {
            'id': identificador,
            'nombre': nombreLimpio,
            'correo': correoNormalizado,
            'contrasenaHash': contrasenaHash,
            'rol': rol.valor,
          },
        );

        // Devuelve la cuenta creada para iniciar su sesión.
        return Usuario.fromMap(resultado.first.toColumnMap());
      });
    } finally {
      await conexion.close();
    }
  }

  @override
  Future<void> cerrarSesion() async {
    // SesionProvider elimina el usuario de la sesión local.
    // Las conexiones ya se cierran al terminar cada operación.
  }
}
