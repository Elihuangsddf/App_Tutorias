import '../models/estado_solicitud.dart';
import '../models/solicitud.dart';

/// Contrato de las solicitudes de tutoría.
abstract class SolicitudesRepository {
  /// Crea una solicitud y la devuelve con su id asignado.
  Future<Solicitud> crear(Solicitud solicitud);

  /// Solicitudes enviadas por el alumno [idAlumno], la más reciente primero.
  Future<List<Solicitud>> listarPorAlumno(String idAlumno);

  /// Solicitudes recibidas por el tutor [idTutor], la más reciente primero.
  Future<List<Solicitud>> listarPorTutor(String idTutor);

  /// Cambia el estado de la solicitud [idSolicitud].
  Future<void> cambiarEstado(String idSolicitud, EstadoSolicitud estado);
}
