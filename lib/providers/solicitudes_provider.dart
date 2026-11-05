import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/estado_solicitud.dart';
import '../models/rol.dart';
import '../models/solicitud.dart';
import '../models/usuario.dart';
import '../repositories/solicitudes_repository.dart';
import 'sesion_provider.dart';

/// Estado de las solicitudes según el rol de la sesión.
///
/// Se conecta con [SesionProvider] desde `main.dart` mediante un
/// `ChangeNotifierProxyProvider`: cuando cambia el usuario, este Provider se
/// actualiza y recarga las solicitudes que le corresponden.
class SolicitudesProvider extends ChangeNotifier {
  SolicitudesProvider(this._repository);

  final SolicitudesRepository _repository;

  Usuario? _usuario;
  List<Solicitud> _solicitudes = [];
  bool _cargando = false;
  String? _error;

  List<Solicitud> get solicitudes => List<Solicitud>.unmodifiable(_solicitudes);
  bool get cargando => _cargando;
  String? get error => _error;
  Rol? get rol => _usuario?.rol;
  Usuario? get usuario => _usuario;

  /// Llamado por el `ChangeNotifierProxyProvider` cada vez que cambia la
  /// sesión. Si el usuario es el mismo, no hace nada.
  void actualizarSesion(SesionProvider sesion) {
    if (_usuario?.id == sesion.usuario?.id &&
        _usuario?.rol == sesion.usuario?.rol) {
      return;
    }

    _usuario = sesion.usuario;
    _solicitudes = [];
    _error = null;

    if (_usuario != null) {
      unawaited(cargar());
    } else {
      notifyListeners();
    }
  }

  Future<void> cargar() async {
    final usuario = _usuario;
    if (usuario == null) {
      _solicitudes = [];
      notifyListeners();
      return;
    }

    _cargando = true;
    _error = null;
    notifyListeners();

    try {
      _solicitudes = usuario.rol == Rol.alumno
          ? await _repository.listarPorAlumno(usuario.id)
          : await _repository.listarPorTutor(usuario.id);
    } catch (_) {
      _error = 'No se pudieron cargar las solicitudes. Intenta de nuevo.';
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  /// Crea una solicitud a nombre del alumno de la sesión.
  Future<bool> crearSolicitud({
    required String idTutor,
    required String materia,
    required String horario,
    required String mensaje,
  }) async {
    final usuario = _usuario;
    if (usuario == null || usuario.rol != Rol.alumno) {
      _error = 'Solo un alumno puede crear solicitudes.';
      notifyListeners();
      return false;
    }

    _cargando = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.crear(
        Solicitud(
          id: '',
          idAlumno: usuario.id,
          idTutor: idTutor,
          materia: materia,
          horario: horario,
          mensaje: mensaje,
          estado: EstadoSolicitud.pendiente,
          fecha: DateTime.now(),
        ),
      );
      _solicitudes = await _repository.listarPorAlumno(usuario.id);
      return true;
    } catch (_) {
      _error = 'No se pudo enviar la solicitud. Intenta de nuevo.';
      return false;
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  Future<void> aceptar(String idSolicitud) {
    return _cambiarEstado(idSolicitud, EstadoSolicitud.aceptada);
  }

  Future<void> rechazar(String idSolicitud) {
    return _cambiarEstado(idSolicitud, EstadoSolicitud.rechazada);
  }

  Future<void> _cambiarEstado(
    String idSolicitud,
    EstadoSolicitud estado,
  ) async {
    _cargando = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.cambiarEstado(idSolicitud, estado);
      await cargar();
    } catch (_) {
      _error = 'No se pudo actualizar la solicitud. Intenta de nuevo.';
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }
}
