import 'estado_solicitud.dart';

/// Solicitud de tutoría que un alumno envía a un tutor.
///
/// En la Etapa 1 se guardan también los nombres del alumno y del tutor para
/// poder pintar el panel sin consultar otros repositorios. En la Etapa 2 esos
/// campos se pueden reemplazar por una consulta a Firestore.
class Solicitud {
  const Solicitud({
    required this.id,
    required this.idAlumno,
    required this.idTutor,
    required this.materia,
    required this.horario,
    required this.mensaje,
    required this.estado,
    required this.fecha,
    this.nombreAlumno = '',
    this.nombreTutor = '',
  });

  final String id;
  final String idAlumno;
  final String idTutor;
  final String nombreAlumno;
  final String nombreTutor;
  final String materia;
  final String horario;
  final String mensaje;
  final EstadoSolicitud estado;
  final DateTime fecha;

  Solicitud copyWith({EstadoSolicitud? estado}) {
    return Solicitud(
      id: id,
      idAlumno: idAlumno,
      idTutor: idTutor,
      nombreAlumno: nombreAlumno,
      nombreTutor: nombreTutor,
      materia: materia,
      horario: horario,
      mensaje: mensaje,
      estado: estado ?? this.estado,
      fecha: fecha,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idAlumno': idAlumno,
      'idTutor': idTutor,
      'nombreAlumno': nombreAlumno,
      'nombreTutor': nombreTutor,
      'materia': materia,
      'horario': horario,
      'mensaje': mensaje,
      'estado': estado.valor,
      'fecha': fecha.toIso8601String(),
    };
  }

  factory Solicitud.fromMap(Map<String, dynamic> map) {
    return Solicitud(
      id: map['id'] as String? ?? '',
      idAlumno: map['idAlumno'] as String? ?? '',
      idTutor: map['idTutor'] as String? ?? '',
      nombreAlumno: map['nombreAlumno'] as String? ?? '',
      nombreTutor: map['nombreTutor'] as String? ?? '',
      materia: map['materia'] as String? ?? '',
      horario: map['horario'] as String? ?? '',
      mensaje: map['mensaje'] as String? ?? '',
      estado: EstadoSolicitud.desdeValor(map['estado'] as String?),
      fecha: DateTime.tryParse(map['fecha'] as String? ?? '') ?? DateTime.now(),
    );
  }
}
