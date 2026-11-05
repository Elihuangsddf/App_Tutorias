// Importa datosEjemplo.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/repositories/datosEjemplo.dart';
// Importa modeloTutor.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/models/modeloTutor.dart';

/// Contrato del catálogo de tutores.
// Define el contrato de acceso a tutores.
abstract class TutoresRepository {
  /// Devuelve todos los tutores disponibles.
  // Declara en el contrato la operación que obtiene todos los tutores de ejemplo.
  Future<List<Tutor>> obtenerTutores();

  /// Devuelve el tutor con [id], o `null` si no existe.
  // Declara en el contrato la operación que busca un tutor de ejemplo por su identificador.
  Future<Tutor?> obtenerTutorPorId(String id);
  // Cierra la clase TutoresRepository.
}

/// Implementación simulada de [TutoresRepository] con los datos de ejemplo.
// Define la clase que reúne el acceso a tutores guardados como ejemplos.
class MockTutoresRepository implements TutoresRepository {
  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Obtiene todos los tutores de ejemplo. async permite esperar operaciones sin bloquear la interfaz.
  Future<List<Tutor>> obtenerTutores() async {
    // Espera el intervalo indicado para simular una operación de carga.
    await Future<void>.delayed(const Duration(milliseconds: 350));
    // Devuelve List<Tutor>.unmodifiable(tutoresDemo) como resultado de esta función.
    return List<Tutor>.unmodifiable(tutoresDemo);
    // Cierra el bloque de obtenerTutores.
  }

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Busca un tutor de ejemplo por su identificador. async permite esperar operaciones sin bloquear la interfaz.
  Future<Tutor?> obtenerTutorPorId(String id) async {
    // Espera el intervalo indicado para simular una operación de carga.
    await Future<void>.delayed(const Duration(milliseconds: 200));
    // Recorre tutoresDemo y utiliza tutor para cada elemento.
    for (final tutor in tutoresDemo) {
      // Devuelve este tutor si su identificador coincide con el buscado.
      if (tutor.id == id) return tutor;
      // Cierra el bloque de for.
    }
    // Devuelve null para indicar que no hay un resultado o error que entregar.
    return null;
    // Cierra el bloque de obtenerTutorPorId.
  }

  // Cierra la clase MockTutoresRepository.
}
