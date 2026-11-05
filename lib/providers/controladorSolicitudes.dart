// Importa dart:async para utilizar sus componentes y clases.
import 'dart:async';

// Importa package:flutter/foundation.dart para utilizar sus componentes y clases.
import 'package:flutter/foundation.dart';

// Importa modeloSolicitud.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/models/modeloSolicitud.dart';
// Importa modeloUsuario.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/models/modeloUsuario.dart';
// Importa repositorioSolicitudes.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/repositories/repositorioSolicitudes.dart';
// Importa controladorSesion.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/providers/controladorSesion.dart';

// Gestiona las solicitudes y comprueba qué cuenta puede modificarlas.
class SolicitudesProvider extends ChangeNotifier {
  // Crea el objeto o la llamada SolicitudesProvider.
  SolicitudesProvider(this._repositorio);

  // Guarda el repositorio de autenticación o solicitudes.
  final SolicitudesRepository _repositorio;

  // Guarda el usuario de la sesión.
  Usuario? _usuario;
  // Prepara solicitudes.
  List<Solicitud> _solicitudes = [];
  // Prepara el indicador de operación en curso.
  bool _cargando = false;
  // Guarda el mensaje de error que mostrará la pantalla.
  String? _error;

  // Permite consultar solicitudes sin modificarlo directamente.
  List<Solicitud> get solicitudes {
    // Devuelve List<Solicitud>.unmodifiable(_solicitudes) como resultado de la función.
    return List<Solicitud>.unmodifiable(_solicitudes);
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

  // Permite consultar el rol guardado en la cuenta sin modificarlo directamente.
  Rol? get rol {
    // Devuelve el rol de la cuenta; si no hay sesión devuelve null.
    return _usuario?.rol;
    // Cierra el bloque de instrucciones o la definición.
  }

  // Permite consultar el usuario autenticado sin modificarlo directamente.
  Usuario? get usuario {
    // Devuelve la cuenta que está autenticada actualmente.
    return _usuario;
    // Cierra el bloque de instrucciones o la definición.
  }

  // Limpia las solicitudes anteriores y carga las que corresponden a la cuenta actual.
  void actualizarSesion(SesionProvider sesion) {
    // Comprueba (_usuario?.id == sesion.usuario?.id && antes de ejecutar el bloque.
    if (_usuario?.id == sesion.usuario?.id &&
        // Completa la operación utilizando _usuario?.rol == sesion.usuario?.rol) {.
        _usuario?.rol == sesion.usuario?.rol) {
      // Termina la función sin ejecutar las instrucciones siguientes.
      return;
      // Cierra el bloque de instrucciones o la definición.
    }

    // Actualiza el usuario de la sesión con el valor indicado.
    _usuario = sesion.usuario;
    // Actualiza solicitudes con el valor indicado.
    _solicitudes = [];
    // Actualiza el mensaje de error que mostrará la pantalla con el valor indicado.
    _error = null;
    // Actualiza el indicador de operación en curso con el valor indicado.
    _cargando = false;

    // Comprueba (_usuario != null && antes de ejecutar el bloque.
    if (_usuario != null &&
        // Define la función que se ejecuta con los argumentos indicados.
        (_usuario!.rol == Rol.alumno || _usuario!.rol == Rol.tutor)) {
      // Crea el objeto o la llamada unawaited.
      unawaited(cargar());
      // Ejecuta esta alternativa cuando la condición anterior no se cumplió.
    } else {
      // Avisa a las pantallas que el estado compartido cambió.
      notifyListeners();
      // Cierra el bloque de instrucciones o la definición.
    }
    // Cierra el bloque de instrucciones o la definición.
  }

  // Carga únicamente las solicitudes del alumno o tutor de la sesión.
  Future<void> cargar() async {
    // Prepara el usuario autenticado.
    final usuario = _usuario;
    // Comprueba (usuario == null || antes de ejecutar el bloque.
    if (usuario == null ||
        // Define la función que se ejecuta con los argumentos indicados.
        (usuario.rol != Rol.alumno && usuario.rol != Rol.tutor)) {
      // Actualiza solicitudes con el valor indicado.
      _solicitudes = [];
      // Avisa a las pantallas que el estado compartido cambió.
      notifyListeners();
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
      // Guarda las solicitudes recibidas del repositorio.
      List<Solicitud> solicitudesCargadas;
      // Comprueba (usuario.rol == Rol.alumno) antes de ejecutar el bloque.
      if (usuario.rol == Rol.alumno) {
        // Actualiza las solicitudes recibidas del repositorio con el valor indicado.
        solicitudesCargadas = await _repositorio.listarPorAlumno(usuario.id);
        // Ejecuta esta alternativa cuando la condición anterior no se cumplió.
      } else {
        // Actualiza las solicitudes recibidas del repositorio con el valor indicado.
        solicitudesCargadas = await _repositorio.listarPorTutor(usuario.id);
        // Cierra el bloque de instrucciones o la definición.
      }
      // Descarta el resultado si la sesión cambió mientras se consultaban los datos.
      if (_usuario?.id != usuario.id) {
        // Termina la función sin ejecutar las instrucciones siguientes.
        return;
        // Cierra el bloque de instrucciones o la definición.
      }
      // Actualiza solicitudes con el valor indicado.
      _solicitudes = solicitudesCargadas;
      // Captura un fallo inesperado y prepara un mensaje controlado.
    } catch (_) {
      // Descarta el resultado si la sesión cambió mientras se consultaban los datos.
      if (_usuario?.id != usuario.id) {
        // Termina la función sin ejecutar las instrucciones siguientes.
        return;
        // Cierra el bloque de instrucciones o la definición.
      }
      // Actualiza el mensaje de error que mostrará la pantalla con el valor indicado.
      _error = 'No se pudieron cargar las solicitudes. Intenta de nuevo.';
      // Finaliza el estado de carga tanto si la operación funcionó como si falló.
    } finally {
      // Actualiza la carga únicamente si esta operación todavía pertenece a la sesión actual.
      if (_usuario?.id == usuario.id) {
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

  // Crea una solicitud a nombre del alumno autenticado.
  Future<bool> crearSolicitud({
    // Recibe id tutor con tipo String.
    required String idTutor,
    // Recibe nombre tutor con tipo String.
    required String nombreTutor,
    // Recibe materia con tipo String.
    required String materia,
    // Recibe horario con tipo String.
    required String horario,
    // Recibe el mensaje de error con tipo String.
    required String mensaje,
    // Termina los parámetros y abre una función asíncrona.
  }) async {
    // Prepara el usuario autenticado.
    final usuario = _usuario;
    // Comprueba (usuario == null || usuario.rol != Rol.alumno) antes de ejecutar el bloque.
    if (usuario == null || usuario.rol != Rol.alumno) {
      // Actualiza el mensaje de error que mostrará la pantalla con el valor indicado.
      _error = 'Solo un alumno puede crear solicitudes.';
      // Avisa a las pantallas que el estado compartido cambió.
      notifyListeners();
      // Devuelve false para indicar el resultado de la operación.
      return false;
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
      await _repositorio.crear(
        // Crea el objeto o la llamada Solicitud.
        Solicitud(
          // Configura el identificador de la cuenta.
          id: '',
          // Configura id alumno.
          idAlumno: usuario.id,
          // Configura id tutor.
          idTutor: idTutor,
          // Configura nombre alumno.
          nombreAlumno: usuario.nombre,
          // Configura nombre tutor.
          nombreTutor: nombreTutor,
          // Configura materia.
          materia: materia,
          // Configura horario.
          horario: horario,
          // Configura el mensaje de error.
          mensaje: mensaje,
          // Configura estado.
          estado: EstadoSolicitud.pendiente,
          // Configura fecha.
          fecha: DateTime.now(),
          // Cierra los argumentos de la operación actual.
        ),
        // Cierra los argumentos de la operación actual.
      );
      // Prepara las solicitudes recibidas del repositorio.
      final solicitudesCargadas = await _repositorio.listarPorAlumno(
        // Consulta únicamente las solicitudes del alumno que inició esta operación.
        usuario.id,
        // Termina la consulta al repositorio de solicitudes.
      );
      // Descarta el resultado si la sesión cambió mientras se consultaban los datos.
      if (_usuario?.id != usuario.id) {
        // Devuelve false para indicar el resultado de la operación.
        return false;
        // Cierra el bloque de instrucciones o la definición.
      }
      // Actualiza solicitudes con el valor indicado.
      _solicitudes = solicitudesCargadas;
      // Devuelve true para indicar el resultado de la operación.
      return true;
      // Captura un fallo inesperado y prepara un mensaje controlado.
    } catch (_) {
      // Descarta el resultado si la sesión cambió mientras se consultaban los datos.
      if (_usuario?.id != usuario.id) {
        // Devuelve false para indicar el resultado de la operación.
        return false;
        // Cierra el bloque de instrucciones o la definición.
      }
      // Actualiza el mensaje de error que mostrará la pantalla con el valor indicado.
      _error = 'No se pudo enviar la solicitud. Intenta de nuevo.';
      // Devuelve false para indicar el resultado de la operación.
      return false;
      // Finaliza el estado de carga tanto si la operación funcionó como si falló.
    } finally {
      // Actualiza la carga únicamente si esta operación todavía pertenece a la sesión actual.
      if (_usuario?.id == usuario.id) {
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

  // Solicita cambiar el estado a aceptada.
  Future<void> aceptar(String idSolicitud) {
    // Devuelve _cambiarEstado(idSolicitud, EstadoSolicitud.aceptada) como resultado de la función.
    return _cambiarEstado(idSolicitud, EstadoSolicitud.aceptada);
    // Cierra el bloque de instrucciones o la definición.
  }

  // Solicita cambiar el estado a rechazada.
  Future<void> rechazar(String idSolicitud) {
    // Devuelve _cambiarEstado(idSolicitud, EstadoSolicitud.rechazada) como resultado de la función.
    return _cambiarEstado(idSolicitud, EstadoSolicitud.rechazada);
    // Cierra el bloque de instrucciones o la definición.
  }

  // Comprueba que el tutor sea propietario antes de responder una solicitud.
  Future<void> _cambiarEstado(
    // Recibe id solicitud con tipo String.
    String idSolicitud,
    // Recibe estado con tipo EstadoSolicitud.
    EstadoSolicitud estado,
    // Termina los parámetros y abre una función asíncrona.
  ) async {
    // Prepara el usuario autenticado.
    final usuario = _usuario;
    // Comprueba (usuario == null || usuario.rol != Rol.tutor) antes de ejecutar el bloque.
    if (usuario == null || usuario.rol != Rol.tutor) {
      // Actualiza el mensaje de error que mostrará la pantalla con el valor indicado.
      _error = 'Solo un tutor puede responder solicitudes.';
      // Avisa a las pantallas que el estado compartido cambió.
      notifyListeners();
      // Termina la función sin ejecutar las instrucciones siguientes.
      return;
      // Cierra el bloque de instrucciones o la definición.
    }
    // Prepara si la solicitud pertenece al tutor de la sesión.
    bool perteneceAlTutor = false;
    // Recorre los elementos de la lista indicada para comprobar o preparar cada uno.
    for (final solicitud in _solicitudes) {
      // Comprueba (solicitud.id == idSolicitud && solicitud.idTutor == usuario.id) antes de ejecutar el bloque.
      if (solicitud.id == idSolicitud && solicitud.idTutor == usuario.id) {
        // Actualiza si la solicitud pertenece al tutor de la sesión con el valor indicado.
        perteneceAlTutor = true;
        // Termina este caso o recorrido y continúa después de él.
        break;
        // Cierra el bloque de instrucciones o la definición.
      }
      // Cierra el bloque de instrucciones o la definición.
    }
    // Comprueba (!perteneceAlTutor) antes de ejecutar el bloque.
    if (!perteneceAlTutor) {
      // Actualiza el mensaje de error que mostrará la pantalla con el valor indicado.
      _error = 'No puedes modificar una solicitud de otro tutor.';
      // Avisa a las pantallas que el estado compartido cambió.
      notifyListeners();
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
      await _repositorio.cambiarEstado(idSolicitud, estado);
      // Descarta el resultado si la sesión cambió mientras se consultaban los datos.
      if (_usuario?.id != usuario.id) {
        // Termina la función sin ejecutar las instrucciones siguientes.
        return;
        // Cierra el bloque de instrucciones o la definición.
      }
      // Espera a que termine la operación indicada antes de continuar.
      await cargar();
      // Captura un fallo inesperado y prepara un mensaje controlado.
    } catch (_) {
      // Descarta el resultado si la sesión cambió mientras se consultaban los datos.
      if (_usuario?.id != usuario.id) {
        // Termina la función sin ejecutar las instrucciones siguientes.
        return;
        // Cierra el bloque de instrucciones o la definición.
      }
      // Actualiza el mensaje de error que mostrará la pantalla con el valor indicado.
      _error = 'No se pudo actualizar la solicitud. Intenta de nuevo.';
      // Finaliza el estado de carga tanto si la operación funcionó como si falló.
    } finally {
      // Actualiza la carga únicamente si esta operación todavía pertenece a la sesión actual.
      if (_usuario?.id == usuario.id) {
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

  // Cierra el bloque de instrucciones o la definición.
}
