// Comparte las operaciones de administración local y los perfiles completos.
import 'package:app_tutorias/repositories/gestionCuentas.dart';
import 'package:app_tutorias/models/modeloTutor.dart';
// Importa datosEjemplo.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/repositories/datosEjemplo.dart';
// Importa modeloUsuario.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/models/modeloUsuario.dart';

// Este contrato permite reemplazar la demostración por una API local más adelante.
abstract class AuthRepository {
  // Consulta los datos públicos de las cuentas, sin incluir sus contraseñas.
  Future<List<Usuario>> obtenerUsuarios();
  // Comprueba el correo y la contraseña, y obtiene el usuario de esa cuenta.
  Future<Usuario> iniciarSesion(String correo, String contrasena);
  // Valida los datos y crea únicamente una cuenta de alumno o tutor.
  Future<Usuario> registrar({
    // Recibe el nombre del usuario con tipo String.
    required String nombre,
    // Recibe el correo electrónico con tipo String.
    required String correo,
    // Recibe la contraseña que se comprobará en la demostración con tipo String.
    required String contrasena,
    // Recibe el rol guardado en la cuenta con tipo Rol.
    required Rol rol,
    // Cierra el bloque de instrucciones o la definición.
  });
  // Cierra la sesión sin eliminar las cuentas de la demostración.
  Future<void> cerrarSesion();
  // Cierra el bloque de instrucciones o la definición.
}

// Distingue los errores de credenciales de un fallo inesperado.
class ErrorAutenticacion implements Exception {
  // Crea un objeto ErrorAutenticacion con los valores indicados.
  const ErrorAutenticacion(this.mensaje);
  // Guarda el mensaje de error.
  final String mensaje;
  // Cierra el bloque de instrucciones o la definición.
}

// Demostración en memoria: las cuentas nuevas duran hasta cerrar la aplicación.
// Estas credenciales de prueba no sustituyen el almacenamiento seguro en un servidor.
// Comparte las operaciones de administración local y los perfiles completos.
class MockAuthRepository implements AuthRepository, GestionCuentas {
  // Crea el objeto o la llamada MockAuthRepository.
  MockAuthRepository() {
    // Agrega cuentas para poder administrar todos los perfiles de demostración.
    for (final tutor in tutoresDemo) {
      if (!usuariosDemo.any((usuario) => usuario.id == tutor.id)) {
        _cuentas.add(
          _CuentaLocal(
            Usuario(
              id: tutor.id,
              nombre: tutor.nombre,
              correo: '${tutor.id}@tutopar.local',
              rol: Rol.tutor,
            ),
            'admin1234',
          ),
        );
      }
    }
    // Recorre los elementos de la lista indicada para comprobar o preparar cada uno.
    for (final usuario in usuariosDemo) {
      // Agrega la cuenta a la lista privada de esta demostración.
      _cuentas.add(_CuentaLocal(usuario, 'admin1234'));
      // Cierra el bloque de instrucciones o la definición.
    }
    // Cierra el bloque de instrucciones o la definición.
  }

  // Prepara las cuentas temporales de esta instancia.
  final List<_CuentaLocal> _cuentas = [];
  // Mantiene los perfiles editables durante la ejecución actual.
  final Map<String, Tutor> _perfiles = {
    for (final tutor in tutoresDemo) tutor.id: tutor,
  };
  @override
  List<Tutor> get perfilesTutores => List.unmodifiable(_perfiles.values);
  // Relaciona cada perfil con el identificador de su cuenta.
  @override
  void guardarPerfil(Tutor perfil) {
    _perfiles[perfil.id] = perfil;
  }

  // Valida antes de modificar para evitar cambios parciales.
  @override
  Future<void> guardarCuenta(
    Usuario usuario,
    String contrasena,
    Tutor? perfil,
  ) async {
    final correo = _normalizarCorreo(usuario.correo);
    _validarCorreo(correo);
    if (usuario.nombre.trim().length < 2) {
      throw const ErrorAutenticacion('Escribe el nombre completo.');
    }
    final indice = _cuentas.indexWhere(
      (cuenta) => cuenta.usuario.id == usuario.id,
    );
    if (usuario.rol == Rol.administrador ||
        (indice >= 0 && _cuentas[indice].usuario.rol == Rol.administrador)) {
      throw const ErrorAutenticacion('Solo se administran alumnos y tutores.');
    }
    if (_cuentas.any(
      (cuenta) =>
          cuenta.usuario.id != usuario.id && cuenta.usuario.correo == correo,
    )) {
      throw const ErrorAutenticacion('Ya existe una cuenta con ese correo.');
    }
    if ((indice < 0 || contrasena.isNotEmpty) && contrasena.trim().length < 8) {
      throw const ErrorAutenticacion(
        'La contraseña debe tener al menos 8 caracteres.',
      );
    }
    if (usuario.rol == Rol.tutor &&
        (perfil == null ||
            perfil.id != usuario.id ||
            perfil.materias.isEmpty ||
            perfil.horariosDisponibles.isEmpty ||
            !perfil.calificacion.isFinite ||
            perfil.calificacion < 0 ||
            perfil.calificacion > 5)) {
      throw const ErrorAutenticacion(
        'Completa materias, horarios y una puntuación entre 0 y 5.',
      );
    }
    // Al editar, una contraseña vacía conserva la anterior.
    final cuenta = _CuentaLocal(
      Usuario(
        id: usuario.id,
        nombre: usuario.nombre.trim(),
        correo: correo,
        rol: usuario.rol,
      ),
      contrasena.isEmpty && indice >= 0
          ? _cuentas[indice].contrasena
          : contrasena,
    );
    if (indice < 0) {
      _cuentas.add(cuenta);
    } else {
      _cuentas[indice] = cuenta;
    }
    _perfiles.remove(usuario.id);
    if (usuario.rol == Rol.tutor) {
      _perfiles[usuario.id] = perfil!;
    }
  }

  // Elimina la cuenta y su perfil para que desaparezca del catálogo.
  @override
  Future<void> borrarCuenta(String id) async {
    if (_cuentas.any(
      (cuenta) =>
          cuenta.usuario.id == id && cuenta.usuario.rol == Rol.administrador,
    )) {
      throw const ErrorAutenticacion('No se puede borrar al administrador.');
    }
    _cuentas.removeWhere((cuenta) => cuenta.usuario.id == id);
    _perfiles.remove(id);
  }

  // Entrega una copia de solo lectura para el catálogo y el panel administrativo.
  @override
  Future<List<Usuario>> obtenerUsuarios() async {
    // Extrae únicamente el modelo público de cada cuenta registrada.
    return List<Usuario>.unmodifiable(_cuentas.map((cuenta) => cuenta.usuario));
  }

  // Prepara el contador para asignar identificadores nuevos.
  int _siguienteCuenta = 1;

  // Quita los espacios exteriores y convierte el correo a minúsculas.
  String _normalizarCorreo(String correo) {
    // Devuelve correo.trim().toLowerCase() como resultado de la función.
    return correo.trim().toLowerCase();
    // Cierra el bloque de instrucciones o la definición.
  }

  // Comprueba la estructura básica del correo antes de utilizarlo.
  void _validarCorreo(String correo) {
    // Prepara las partes del correo separadas por @.
    final partes = correo.split('@');
    // Comprueba (partes.length != 2 || antes de ejecutar el bloque.
    if (partes.length != 2 ||
        // Completa la operación utilizando partes[0].isEmpty ||.
        partes[0].isEmpty ||
        // Completa la operación utilizando !partes[1].contains('.') ||.
        !partes[1].contains('.') ||
        // Completa la operación utilizando correo.contains(' ')) {.
        correo.contains(' ')) {
      // Detiene la operación y entrega el error indicado al controlador de sesión.
      throw const ErrorAutenticacion('Escribe un correo válido.');
      // Cierra el bloque de instrucciones o la definición.
    }
    // Cierra el bloque de instrucciones o la definición.
  }

  // Implementa un método definido por Flutter o por el contrato del repositorio.
  @override
  // Comprueba el correo y la contraseña, y obtiene el usuario de esa cuenta.
  Future<Usuario> iniciarSesion(String correo, String contrasena) async {
    // Prepara el correo sin espacios exteriores y en minúsculas.
    final correoNormalizado = _normalizarCorreo(correo);
    // Comprueba (correoNormalizado.isEmpty || contrasena.isEmpty) antes de ejecutar el bloque.
    if (correoNormalizado.isEmpty || contrasena.isEmpty) {
      // Detiene la operación y entrega el error indicado al controlador de sesión.
      throw const ErrorAutenticacion('Escribe tu correo y contraseña.');
      // Cierra el bloque de instrucciones o la definición.
    }
    // Comprueba la estructura básica del correo antes de utilizarlo.
    _validarCorreo(correoNormalizado);
    // Espera a que termine la operación indicada antes de continuar.
    await Future<void>.delayed(const Duration(milliseconds: 300));
    // Recorre los elementos de la lista indicada para comprobar o preparar cada uno.
    for (final cuenta in _cuentas) {
      // Comprueba (cuenta.usuario.correo == correoNormalizado && antes de ejecutar el bloque.
      if (cuenta.usuario.correo == correoNormalizado &&
          // Actualiza cuenta.contrasena con el valor indicado.
          cuenta.contrasena == contrasena) {
        // Devuelve cuenta.usuario como resultado de la función.
        return cuenta.usuario;
        // Cierra el bloque de instrucciones o la definición.
      }
      // Cierra el bloque de instrucciones o la definición.
    }
    // El mismo mensaje se usa para un correo desconocido o una contraseña incorrecta.
    throw const ErrorAutenticacion('Correo o contraseña incorrectos.');
    // Cierra el bloque de instrucciones o la definición.
  }

  // Implementa un método definido por Flutter o por el contrato del repositorio.
  @override
  // Valida los datos y crea únicamente una cuenta de alumno o tutor.
  Future<Usuario> registrar({
    // Recibe el nombre del usuario con tipo String.
    required String nombre,
    // Recibe el correo electrónico con tipo String.
    required String correo,
    // Recibe la contraseña que se comprobará en la demostración con tipo String.
    required String contrasena,
    // Recibe el rol guardado en la cuenta con tipo Rol.
    required Rol rol,
    // Termina los parámetros y abre una función asíncrona.
  }) async {
    // Rechaza el registro público de administradores u otros roles no permitidos.
    if (rol != Rol.alumno && rol != Rol.tutor) {
      // Detiene la operación y entrega el error indicado al controlador de sesión.
      throw const ErrorAutenticacion(
        // Aporta el texto indicado a la operación actual.
        'Solo puedes registrarte como alumno o tutor.',
        // Cierra los argumentos de la operación actual.
      );
      // Cierra el bloque de instrucciones o la definición.
    }
    // Prepara el nombre sin espacios exteriores.
    final nombreLimpio = nombre.trim();
    // Prepara el correo sin espacios exteriores y en minúsculas.
    final correoNormalizado = _normalizarCorreo(correo);
    // Comprueba (nombreLimpio.length < 2) antes de ejecutar el bloque.
    if (nombreLimpio.length < 2) {
      // Detiene la operación y entrega el error indicado al controlador de sesión.
      throw const ErrorAutenticacion('Escribe tu nombre completo.');
      // Cierra el bloque de instrucciones o la definición.
    }
    // Comprueba la estructura básica del correo antes de utilizarlo.
    _validarCorreo(correoNormalizado);
    // Comprueba (contrasena.trim().length < 8) antes de ejecutar el bloque.
    if (contrasena.trim().length < 8) {
      // Detiene la operación y entrega el error indicado al controlador de sesión.
      throw const ErrorAutenticacion(
        // Aporta el texto indicado a la operación actual.
        'La contraseña debe tener al menos 8 caracteres.',
        // Cierra los argumentos de la operación actual.
      );
      // Cierra el bloque de instrucciones o la definición.
    }
    // La validación y la inserción se hacen juntas para evitar registros duplicados.
    for (final cuenta in _cuentas) {
      // Comprueba (cuenta.usuario.correo == correoNormalizado) antes de ejecutar el bloque.
      if (cuenta.usuario.correo == correoNormalizado) {
        // Detiene la operación y entrega el error indicado al controlador de sesión.
        throw const ErrorAutenticacion('Ya existe una cuenta con ese correo.');
        // Cierra el bloque de instrucciones o la definición.
      }
      // Cierra el bloque de instrucciones o la definición.
    }
    // Prepara el usuario autenticado.
    final usuario = Usuario(
      // Configura el identificador de la cuenta.
      id: 'cuenta-$_siguienteCuenta',
      // Configura el nombre del usuario.
      nombre: nombreLimpio,
      // Configura el correo electrónico.
      correo: correoNormalizado,
      // Configura el rol guardado en la cuenta.
      rol: rol,
      // Cierra los argumentos de la operación actual.
    );
    // Reserva el siguiente identificador para una cuenta nueva.
    _siguienteCuenta++;
    // Agrega la cuenta a la lista privada de esta demostración.
    _cuentas.add(_CuentaLocal(usuario, contrasena));
    // Devuelve usuario como resultado de la función.
    return usuario;
    // Cierra el bloque de instrucciones o la definición.
  }

  // Implementa un método definido por Flutter o por el contrato del repositorio.
  @override
  // Cierra la sesión sin eliminar las cuentas de la demostración.
  Future<void> cerrarSesion() async {
    // La sesión se elimina del controlador; las cuentas de esta instancia se conservan.
  }
  // Cierra el bloque de instrucciones o la definición.
}

// Esta clase privada solo se usa para probar credenciales en la demostración local.
class _CuentaLocal {
  // Crea un objeto _CuentaLocal con los valores indicados.
  const _CuentaLocal(this.usuario, this.contrasena);
  // Guarda el usuario autenticado.
  final Usuario usuario;
  // Guarda la contraseña que se comprobará en la demostración.
  final String contrasena;
  // Cierra el bloque de instrucciones o la definición.
}
