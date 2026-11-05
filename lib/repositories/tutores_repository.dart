import '../models/tutor.dart';

/// Contrato del catálogo de tutores.
abstract class TutoresRepository {
  /// Devuelve todos los tutores disponibles.
  Future<List<Tutor>> obtenerTutores();

  /// Devuelve el tutor con [id], o `null` si no existe.
  Future<Tutor?> obtenerTutorPorId(String id);
}
