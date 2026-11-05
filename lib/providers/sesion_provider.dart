import 'package:flutter/foundation.dart';

import '../models/rol.dart';
import '../models/usuario.dart';
import '../repositories/auth_repository.dart';

/// Estado de la sesión: usuario actual, rol y operaciones de entrada/salida.
class SesionProvider extends ChangeNotifier {
  SesionProvider(this._repository);

  final AuthRepository _repository;

  Usuario? _usuario;
  bool _cargando = false;
  String? _error;

  Usuario? get usuario => _usuario;
  Rol? get rol => _usuario?.rol;
  bool get cargando => _cargando;
  String? get error => _error;
  bool get autenticado => _usuario != null;

  /// Inicia sesión con un usuario de ejemplo del [rol] indicado.
  ///
  /// Devuelve `true` si la operación terminó correctamente.
  Future<bool> iniciarSesion(Rol rol) async {
    _cargando = true;
    _error = null;
    notifyListeners();

    try {
      _usuario = await _repository.iniciarSesionPorRol(rol);
      return true;
    } catch (_) {
      _error = 'No se pudo iniciar sesión. Intenta de nuevo.';
      return false;
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  /// Cierra la sesión actual y limpia el estado.
  Future<void> cerrarSesion() async {
    _cargando = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.cerrarSesion();
      _usuario = null;
    } catch (_) {
      _error = 'No se pudo cerrar la sesión.';
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }
}
