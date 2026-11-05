// Importa package:flutter/foundation.dart para utilizar sus componentes y clases.
import 'package:flutter/foundation.dart';
// Comparte las operaciones locales y los perfiles completos.
import 'package:app_tutorias/repositories/gestionCuentas.dart';
import 'package:app_tutorias/models/modeloTutor.dart';

// Importa modeloUsuario.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/models/modeloUsuario.dart';
// Importa repositorioAutenticacion.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/repositories/repositorioAutenticacion.dart';

// Comparte el usuario, la carga y los errores de la sesión con las pantallas.
class SesionProvider extends ChangeNotifier {
  // Crea el objeto o la llamada SesionProvider.
  SesionProvider(this._repositorio);

  // Guarda el repositorio de autenticación o solicitudes.
  final AuthRepository _repositorio;
  // Consulta el perfil actual para precargar el formulario de edición.
  Tutor? perfilTutor(String id) => _repositorio is GestionCuentas
      ? (_repositorio as GestionCuentas).perfilesTutores
            .where((perfil) => perfil.id == id)
            .firstOrNull
      : null;
  // Comprueba el permiso tanto al crear como al editar o borrar.
  GestionCuentas _gestionAdministrativa() {
    if (rol != Rol.administrador || _repositorio is! GestionCuentas) {
      throw const ErrorAutenticacion(
        'Se requiere una sesión administrativa local.',
      );
    }
    return _repositorio as GestionCuentas;
  }

  // Conserva el identificador durante una edición.
  Future<void> guardarCuenta(
    Usuario usuario,
    String contrasena,
    Tutor? perfil,
  ) async {
    // Entrega también los errores de permisos como resultado asíncrono.
    await _gestionAdministrativa().guardarCuenta(usuario, contrasena, perfil);
  }
  // Impide que alumnos y tutores eliminen cuentas.
  Future<void> borrarCuenta(String id) async {
    // Comprueba el permiso antes de eliminar los datos relacionados.
    await _gestionAdministrativa().borrarCuenta(id);
  }

  // Permite consultar las cuentas únicamente desde una sesión administrativa.
  Future<List<Usuario>> obtenerUsuariosAdministracion() async {
    // Comprueba el rol antes de consultar el repositorio de cuentas.
    if (_usuario?.rol != Rol.administrador) {
      // Impide acceder al directorio completo desde una sesión de alumno o tutor.
      throw const ErrorAutenticacion(
        'Solo el administrador puede consultar las cuentas.',
      );
    }
    // Recuerda la sesión para descartar una lectura que termine después de salir.
    final administrador = _usuario;
    // Recupera únicamente los modelos públicos, sin contraseñas.
    final usuarios = await _repositorio.obtenerUsuarios();
    // Comprueba que sigue activa la misma sesión que autorizó la consulta.
    if (!identical(_usuario, administrador)) {
      // Evita entregar resultados administrativos a una sesión diferente.
      throw const ErrorAutenticacion('La sesión administrativa ha cambiado.');
    }
    // Entrega una copia de solo lectura al panel administrativo.
    return List<Usuario>.unmodifiable(usuarios);
  }

  // Guarda el usuario de la sesión.
  Usuario? _usuario;
  // Prepara el indicador de operación en curso.
  bool _cargando = false;
  // Guarda el mensaje de error que mostrará la pantalla.
  String? _error;

  // Permite consultar el usuario autenticado sin modificarlo directamente.
  Usuario? get usuario {
    // Devuelve la cuenta que está autenticada actualmente.
    return _usuario;
    // Cierra el bloque de instrucciones o la definición.
  }

  // Permite consultar el rol guardado en la cuenta sin modificarlo directamente.
  Rol? get rol {
    // Devuelve el rol de la cuenta; si no hay sesión devuelve null.
    return _usuario?.rol;
    // Cierra el bloque de instrucciones o la definición.
  }

  // Permite consultar si se muestra la carga sin modificarlo directamente.
  bool get cargando {
    // Devuelve _cargando como resultado de la función.
    return _cargando;
    // Cierra el bloque de instrucciones o la definición.
  }

  // Permite consultar error sin modificarlo directamente.
  String? get error {
    // Devuelve _error como resultado de la función.
    return _error;
    // Cierra el bloque de instrucciones o la definición.
  }

  // Permite consultar autenticado sin modificarlo directamente.
  bool get autenticado {
    // Indica si existe una cuenta autenticada.
    return _usuario != null;
    // Cierra el bloque de instrucciones o la definición.
  }

  // Quita el error anterior de autenticación.
  void limpiarError() {
    // Actualiza el mensaje de error que mostrará la pantalla con el valor indicado.
    _error = null;
    // Avisa a las pantallas que el estado compartido cambió.
    notifyListeners();
    // Cierra el bloque de instrucciones o la definición.
  }

  // Comprueba el correo y la contraseña, y obtiene el usuario de esa cuenta.
  Future<bool> iniciarSesion(String correo, String contrasena) async {
    // Evita iniciar otra operación mientras la anterior sigue en curso.
    if (_cargando) {
      // Devuelve false para indicar el resultado de la operación.
      return false;
      // Cierra el bloque de instrucciones o la definición.
    }
    // Actualiza el indicador de operación en curso con el valor indicado.
    _cargando = true;
    // Actualiza el mensaje de error que mostrará la pantalla con el valor indicado.
    _error = null;
    // Actualiza el usuario de la sesión con el valor indicado.
    _usuario = null;
    // Avisa a las pantallas que el estado compartido cambió.
    notifyListeners();
    // Intenta ejecutar la operación y permite controlar sus errores.
    try {
      // Actualiza el usuario de la sesión con el valor indicado.
      _usuario = await _repositorio.iniciarSesion(correo, contrasena);
      // Devuelve true para indicar el resultado de la operación.
      return true;
      // Captura un fallo de credenciales o registro y conserva su mensaje específico.
    } on ErrorAutenticacion catch (error) {
      // Actualiza el mensaje de error que mostrará la pantalla con el valor indicado.
      _error = error.mensaje;
      // Devuelve false para indicar el resultado de la operación.
      return false;
      // Captura un fallo inesperado y prepara un mensaje controlado.
    } catch (_) {
      // Actualiza el mensaje de error que mostrará la pantalla con el valor indicado.
      _error = 'No se pudo iniciar sesión. Intenta de nuevo.';
      // Devuelve false para indicar el resultado de la operación.
      return false;
      // Finaliza el estado de carga tanto si la operación funcionó como si falló.
    } finally {
      // Actualiza el indicador de operación en curso con el valor indicado.
      _cargando = false;
      // Avisa a las pantallas que el estado compartido cambió.
      notifyListeners();
      // Cierra el bloque de instrucciones o la definición.
    }
    // Cierra el bloque de instrucciones o la definición.
  }

  // Valida los datos y crea únicamente una cuenta de alumno o tutor.
  Future<bool> registrar({
    // Recibe el nombre del usuario con tipo String.
    required String nombre,
    // Recibe el correo electrónico con tipo String.
    required String correo,
    // Recibe la contraseña que se comprobará en la demostración con tipo String.
    required String contrasena,
    // Recibe el rol guardado en la cuenta con tipo Rol.
    required Rol rol,
    // Recibe materias y horarios del registro de tutor.
    List<String> materias = const [],
    List<String> horarios = const [],
    // Termina los parámetros y abre una función asíncrona.
  }) async {
    // Evita iniciar otra operación mientras la anterior sigue en curso.
    if (_cargando) {
      // Devuelve false para indicar el resultado de la operación.
      return false;
      // Cierra el bloque de instrucciones o la definición.
    }
    // Actualiza el indicador de operación en curso con el valor indicado.
    _cargando = true;
    // Actualiza el mensaje de error que mostrará la pantalla con el valor indicado.
    _error = null;
    // Actualiza el usuario de la sesión con el valor indicado.
    _usuario = null;
    // Avisa a las pantallas que el estado compartido cambió.
    notifyListeners();
    // Intenta ejecutar la operación y permite controlar sus errores.
    try {
      // Valida antes del alta para evitar cuentas de tutor incompletas.
      if (rol == Rol.tutor && (materias.isEmpty || horarios.isEmpty)) {
        throw const ErrorAutenticacion(
          'Indica al menos una materia y un horario.',
        );
      }
      // La cuenta que devuelve el repositorio determina el rol de la sesión.
      _usuario = await _repositorio.registrar(
        // Configura el nombre del usuario.
        nombre: nombre,
        // Configura el correo electrónico.
        correo: correo,
        // Configura la contraseña que se comprobará en la demostración.
        contrasena: contrasena,
        // Configura el rol guardado en la cuenta.
        rol: rol,
        // Cierra los argumentos de la operación actual.
      );
      // Publica el perfil académico completo con el mismo identificador de la cuenta.
      if (rol == Rol.tutor && _repositorio is GestionCuentas) {
        (_repositorio as GestionCuentas).guardarPerfil(
          Tutor(
            id: _usuario!.id,
            nombre: _usuario!.nombre,
            materias: materias,
            calificacion: 0,
            horariosDisponibles: horarios,
            descripcion: 'Tutor disponible para apoyo académico.',
            foto: '',
          ),
        );
      }
      // Devuelve true para indicar el resultado de la operación.
      return true;
      // Captura un fallo de credenciales o registro y conserva su mensaje específico.
    } on ErrorAutenticacion catch (error) {
      // Actualiza el mensaje de error que mostrará la pantalla con el valor indicado.
      _error = error.mensaje;
      // Devuelve false para indicar el resultado de la operación.
      return false;
      // Captura un fallo inesperado y prepara un mensaje controlado.
    } catch (_) {
      // Actualiza el mensaje de error que mostrará la pantalla con el valor indicado.
      _error = 'No se pudo crear la cuenta. Intenta de nuevo.';
      // Devuelve false para indicar el resultado de la operación.
      return false;
      // Finaliza el estado de carga tanto si la operación funcionó como si falló.
    } finally {
      // Actualiza el indicador de operación en curso con el valor indicado.
      _cargando = false;
      // Avisa a las pantallas que el estado compartido cambió.
      notifyListeners();
      // Cierra el bloque de instrucciones o la definición.
    }
    // Cierra el bloque de instrucciones o la definición.
  }

  // Cierra la sesión sin eliminar las cuentas de la demostración.
  Future<void> cerrarSesion() async {
    // Evita iniciar otra operación mientras la anterior sigue en curso.
    if (_cargando) {
      // Termina la función sin ejecutar las instrucciones siguientes.
      return;
      // Cierra el bloque de instrucciones o la definición.
    }
    // Actualiza el indicador de operación en curso con el valor indicado.
    _cargando = true;
    // Actualiza el mensaje de error que mostrará la pantalla con el valor indicado.
    _error = null;
    // Avisa a las pantallas que el estado compartido cambió.
    notifyListeners();
    // Intenta ejecutar la operación y permite controlar sus errores.
    try {
      // Espera a que termine la operación indicada antes de continuar.
      await _repositorio.cerrarSesion();
      // Actualiza el usuario de la sesión con el valor indicado.
      _usuario = null;
      // Captura un fallo inesperado y prepara un mensaje controlado.
    } catch (_) {
      // Actualiza el mensaje de error que mostrará la pantalla con el valor indicado.
      _error = 'No se pudo cerrar la sesión. Intenta de nuevo.';
      // Finaliza el estado de carga tanto si la operación funcionó como si falló.
    } finally {
      // Actualiza el indicador de operación en curso con el valor indicado.
      _cargando = false;
      // Avisa a las pantallas que el estado compartido cambió.
      notifyListeners();
      // Cierra el bloque de instrucciones o la definición.
    }
    // Cierra el bloque de instrucciones o la definición.
  }

  // Cierra el bloque de instrucciones o la definición.
}
