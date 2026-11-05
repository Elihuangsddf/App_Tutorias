import '../../models/estado_solicitud.dart';
import '../../models/solicitud.dart';
import '../solicitudes_repository.dart';
import 'mock_data.dart';

/// Implementación simulada de [SolicitudesRepository].
///
/// Guarda las solicitudes en memoria: se pierden al cerrar la app, lo cual es
/// aceptable en la Etapa 1.
class MockSolicitudesRepository implements SolicitudesRepository {
  MockSolicitudesRepository({List<Solicitud>? iniciales})
    : _solicitudes = List<Solicitud>.of(iniciales ?? solicitudesDemo);

  final List<Solicitud> _solicitudes;

  @override
  Future<Solicitud> crear(Solicitud solicitud) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));

    final nueva = Solicitud(
      id: 'sol-${DateTime.now().millisecondsSinceEpoch}',
      idAlumno: solicitud.idAlumno,
      idTutor: solicitud.idTutor,
      materia: solicitud.materia,
      horario: solicitud.horario,
      mensaje: solicitud.mensaje,
      estado: solicitud.estado,
      fecha: solicitud.fecha,
    );

    _solicitudes.add(nueva);
    return nueva;
  }

  @override
  Future<List<Solicitud>> listarPorAlumno(String idAlumno) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return _filtrar((solicitud) => solicitud.idAlumno == idAlumno);
  }

  @override
  Future<List<Solicitud>> listarPorTutor(String idTutor) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return _filtrar((solicitud) => solicitud.idTutor == idTutor);
  }

  @override
  Future<void> cambiarEstado(String idSolicitud, EstadoSolicitud estado) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));

    final indice = _solicitudes.indexWhere(
      (solicitud) => solicitud.id == idSolicitud,
    );
    if (indice == -1) {
      throw StateError('No existe la solicitud $idSolicitud.');
    }

    _solicitudes[indice] = _solicitudes[indice].copyWith(estado: estado);
  }

  List<Solicitud> _filtrar(bool Function(Solicitud) condicion) {
    final resultado = _solicitudes.where(condicion).toList()
      ..sort((a, b) => b.fecha.compareTo(a.fecha));
    return List<Solicitud>.unmodifiable(resultado);
  }
}
