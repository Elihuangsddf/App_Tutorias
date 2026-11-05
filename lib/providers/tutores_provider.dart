import 'package:flutter/foundation.dart';

import '../models/tutor.dart';
import '../repositories/tutores_repository.dart';

/// Estado del catálogo: lista de tutores, búsqueda, filtros y estados de
/// carga y error.
class TutoresProvider extends ChangeNotifier {
  TutoresProvider(this._repository);

  final TutoresRepository _repository;

  List<Tutor> _tutores = [];
  bool _cargando = false;
  String? _error;

  String _busqueda = '';
  String? _materia;
  double? _calificacionMinima;
  String? _dia;

  List<Tutor> get tutores => List<Tutor>.unmodifiable(_tutores);
  bool get cargando => _cargando;
  String? get error => _error;

  String get busqueda => _busqueda;
  String? get materiaFiltro => _materia;
  double? get calificacionMinima => _calificacionMinima;
  String? get diaFiltro => _dia;

  bool get hayFiltros =>
      _materia != null || _calificacionMinima != null || _dia != null;

  /// Materias disponibles, sin repetir y ordenadas alfabéticamente.
  List<String> get materias {
    final conjunto = <String>{};
    for (final tutor in _tutores) {
      conjunto.addAll(tutor.materias);
    }
    final lista = conjunto.toList()..sort();
    return lista;
  }

  /// Días disponibles según los horarios del catálogo.
  List<String> get dias {
    final conjunto = <String>{};
    for (final tutor in _tutores) {
      for (final horario in tutor.horariosDisponibles) {
        conjunto.add(horario.split(' ').first);
      }
    }
    final lista = conjunto.toList()..sort();
    return lista;
  }

  /// Lista filtrada que deben dibujar las pantallas.
  List<Tutor> get resultados {
    final texto = _busqueda.trim().toLowerCase();

    return _tutores.where((tutor) {
      final coincideTexto =
          texto.isEmpty ||
          tutor.nombre.toLowerCase().contains(texto) ||
          tutor.materias.any(
            (materia) => materia.toLowerCase().contains(texto),
          );

      final coincideMateria =
          _materia == null || tutor.materias.contains(_materia);

      final coincideCalificacion =
          _calificacionMinima == null ||
          tutor.calificacion >= _calificacionMinima!;

      final coincideDia =
          _dia == null ||
          tutor.horariosDisponibles.any(
            (horario) => horario.toLowerCase().startsWith(_dia!.toLowerCase()),
          );

      return coincideTexto &&
          coincideMateria &&
          coincideCalificacion &&
          coincideDia;
    }).toList();
  }

  Future<void> cargarTutores() async {
    _cargando = true;
    _error = null;
    notifyListeners();

    try {
      _tutores = await _repository.obtenerTutores();
    } catch (_) {
      _error = 'No se pudieron cargar los tutores. Intenta de nuevo.';
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  Tutor? tutorPorId(String id) {
    for (final tutor in _tutores) {
      if (tutor.id == id) return tutor;
    }
    return null;
  }

  void actualizarBusqueda(String texto) {
    if (_busqueda == texto) return;
    _busqueda = texto;
    notifyListeners();
  }

  void filtrarPorMateria(String? materia) {
    _materia = _materia == materia ? null : materia;
    notifyListeners();
  }

  void filtrarPorCalificacion(double? minima) {
    _calificacionMinima = _calificacionMinima == minima ? null : minima;
    notifyListeners();
  }

  void filtrarPorDia(String? dia) {
    _dia = _dia == dia ? null : dia;
    notifyListeners();
  }

  void limpiarFiltros() {
    _busqueda = '';
    _materia = null;
    _calificacionMinima = null;
    _dia = null;
    notifyListeners();
  }
}
