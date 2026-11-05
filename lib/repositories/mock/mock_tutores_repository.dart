import '../../models/tutor.dart';
import '../tutores_repository.dart';
import 'mock_data.dart';

/// Implementación simulada de [TutoresRepository] con los datos de ejemplo.
class MockTutoresRepository implements TutoresRepository {
  @override
  Future<List<Tutor>> obtenerTutores() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    return List<Tutor>.unmodifiable(tutoresDemo);
  }

  @override
  Future<Tutor?> obtenerTutorPorId(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    for (final tutor in tutoresDemo) {
      if (tutor.id == id) return tutor;
    }
    return null;
  }
}
