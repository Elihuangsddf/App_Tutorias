/// Solicitud de tutoría que un alumno envía a un tutor.
///
/// En la Etapa 1 se guardan también los nombres del alumno y del tutor para
/// poder pintar el panel sin consultar otros repositorios. En la Etapa 2 esos
/// campos se pueden reemplazar por una consulta a Firestore.
// Define la clase que reúne los datos de una solicitud.
class Solicitud {
  // Define cómo se crea Solicitud y qué datos recibe.
  const Solicitud({
    // Solicita el identificador.
    required this.id,
    // Solicita el identificador del alumno.
    required this.idAlumno,
    // Solicita el identificador del tutor.
    required this.idTutor,
    // Solicita la materia elegida.
    required this.materia,
    // Solicita el horario elegido.
    required this.horario,
    // Solicita el mensaje del alumno.
    required this.mensaje,
    // Solicita el estado de la solicitud.
    required this.estado,
    // Solicita la fecha de la solicitud.
    required this.fecha,
    // Recibe como opción el nombre del alumno.
    this.nombreAlumno = '',
    // Recibe como opción el nombre del tutor.
    this.nombreTutor = '',
    // Cierra el bloque de Solicitud y termina la instrucción.
  });

  // Declara el identificador sin permitir reasignarlo.
  final String id;
  // Declara el identificador del alumno sin permitir reasignarlo.
  final String idAlumno;
  // Declara el identificador del tutor sin permitir reasignarlo.
  final String idTutor;
  // Declara el nombre del alumno sin permitir reasignarlo.
  final String nombreAlumno;
  // Declara el nombre del tutor sin permitir reasignarlo.
  final String nombreTutor;
  // Declara la materia elegida sin permitir reasignarlo.
  final String materia;
  // Declara el horario elegido sin permitir reasignarlo.
  final String horario;
  // Declara el mensaje del alumno sin permitir reasignarlo.
  final String mensaje;
  // Declara el estado de la solicitud sin permitir reasignarlo.
  final EstadoSolicitud estado;
  // Declara la fecha de la solicitud sin permitir reasignarlo.
  final DateTime fecha;

  // Crea una copia de la solicitud permitiendo cambiar su estado. El signo ? del tipo permite que este dato sea null.
  Solicitud copyWith({EstadoSolicitud? estado}) {
    // Devuelve Solicitud( como resultado de esta función.
    return Solicitud(
      // Establece el identificador al valor indicado.
      id: id,
      // Establece el identificador del alumno al valor indicado.
      idAlumno: idAlumno,
      // Establece el identificador del tutor al valor indicado.
      idTutor: idTutor,
      // Establece el nombre del alumno al valor indicado.
      nombreAlumno: nombreAlumno,
      // Establece el nombre del tutor al valor indicado.
      nombreTutor: nombreTutor,
      // Establece la materia elegida al valor indicado.
      materia: materia,
      // Establece el horario elegido al valor indicado.
      horario: horario,
      // Establece el mensaje del alumno al valor indicado.
      mensaje: mensaje,
      // Establece el estado de la solicitud al valor indicado. Si el dato es null, usa la alternativa situada después de ??.
      estado: estado ?? this.estado,
      // Establece la fecha de la solicitud al valor indicado.
      fecha: fecha,
      // Cierra la configuración de Solicitud y termina la instrucción.
    );
    // Cierra el bloque de copyWith.
  }

  // Convierte los datos del objeto en un mapa de claves y valores.
  Map<String, dynamic> toMap() {
    // Devuelve el mapa que relaciona cada nombre de campo con su valor.
    return {
      // Relaciona esta clave del mapa con el valor de la derecha.
      'id': id,
      // Relaciona esta clave del mapa con el valor de la derecha.
      'idAlumno': idAlumno,
      // Relaciona esta clave del mapa con el valor de la derecha.
      'idTutor': idTutor,
      // Relaciona esta clave del mapa con el valor de la derecha.
      'nombreAlumno': nombreAlumno,
      // Relaciona esta clave del mapa con el valor de la derecha.
      'nombreTutor': nombreTutor,
      // Relaciona esta clave del mapa con el valor de la derecha.
      'materia': materia,
      // Relaciona esta clave del mapa con el valor de la derecha.
      'horario': horario,
      // Relaciona esta clave del mapa con el valor de la derecha.
      'mensaje': mensaje,
      // Relaciona esta clave del mapa con el valor de la derecha.
      'estado': estado.valor,
      // Relaciona esta clave del mapa con el valor de la derecha.
      'fecha': fecha.toIso8601String(),
      // Cierra el bloque de instrucciones y termina la instrucción.
    };
    // Cierra el bloque de toMap.
  }

  // Construye un objeto Solicitud a partir de un mapa de datos.
  factory Solicitud.fromMap(Map<String, dynamic> mapa) {
    // Devuelve Solicitud( como resultado de esta función.
    return Solicitud(
      // Establece el identificador al valor indicado. Si el dato es null, usa la alternativa situada después de ??. as comprueba o convierte la referencia al tipo indicado.
      id: mapa['id'] as String? ?? '',
      // Establece el identificador del alumno al valor indicado. Si el dato es null, usa la alternativa situada después de ??. as comprueba o convierte la referencia al tipo indicado.
      idAlumno: mapa['idAlumno'] as String? ?? '',
      // Establece el identificador del tutor al valor indicado. Si el dato es null, usa la alternativa situada después de ??. as comprueba o convierte la referencia al tipo indicado.
      idTutor: mapa['idTutor'] as String? ?? '',
      // Establece el nombre del alumno al valor indicado. Si el dato es null, usa la alternativa situada después de ??. as comprueba o convierte la referencia al tipo indicado.
      nombreAlumno: mapa['nombreAlumno'] as String? ?? '',
      // Establece el nombre del tutor al valor indicado. Si el dato es null, usa la alternativa situada después de ??. as comprueba o convierte la referencia al tipo indicado.
      nombreTutor: mapa['nombreTutor'] as String? ?? '',
      // Establece la materia elegida al valor indicado. Si el dato es null, usa la alternativa situada después de ??. as comprueba o convierte la referencia al tipo indicado.
      materia: mapa['materia'] as String? ?? '',
      // Establece el horario elegido al valor indicado. Si el dato es null, usa la alternativa situada después de ??. as comprueba o convierte la referencia al tipo indicado.
      horario: mapa['horario'] as String? ?? '',
      // Establece el mensaje del alumno al valor indicado. Si el dato es null, usa la alternativa situada después de ??. as comprueba o convierte la referencia al tipo indicado.
      mensaje: mapa['mensaje'] as String? ?? '',
      // Establece el estado de la solicitud al valor indicado. as comprueba o convierte la referencia al tipo indicado.
      estado: EstadoSolicitud.desdeValor(mapa['estado'] as String?),
      // Establece la fecha de la solicitud.
      fecha:
          // Ejecuta tryParse sobre DateTime. Si el dato es null, usa la alternativa situada después de ??. as comprueba o convierte la referencia al tipo indicado.
          DateTime.tryParse(mapa['fecha'] as String? ?? '') ?? DateTime.now(),
      // Cierra la configuración de Solicitud y termina la instrucción.
    );
    // Cierra el bloque de fromMap.
  }
  // Cierra la clase Solicitud.
}

/// Estado por el que pasa una solicitud de tutoría.
// Define las opciones permitidas para el estado de una solicitud.
enum EstadoSolicitud {
  // Utiliza pendiente con los argumentos indicados.
  pendiente('pendiente', 'Pendiente'),
  // Utiliza aceptada con los argumentos indicados.
  aceptada('aceptada', 'Aceptada'),
  // Utiliza rechazada con los argumentos indicados.
  rechazada('rechazada', 'Rechazada');

  // Define cómo se crea EstadoSolicitud y qué datos recibe.
  const EstadoSolicitud(this.valor, this.etiqueta);

  // Declara el valor recibido o almacenado sin permitir reasignarlo.
  final String valor;
  // Declara la etiqueta visible sin permitir reasignarlo.
  final String etiqueta;

  // Busca el valor del catálogo y usa la opción predeterminada si no lo encuentra. El signo ? del tipo permite que este dato sea null.
  static EstadoSolicitud desdeValor(String? valor) {
    // Recorre EstadoSolicitud.values y utiliza estado para cada elemento.
    for (final estado in EstadoSolicitud.values) {
      // Comprueba (estado.valor == valor) para decidir si se ejecuta esta parte.
      if (estado.valor == valor) {
        // Devuelve estado como resultado de esta función.
        return estado;
        // Cierra el bloque de if.
      }
      // Cierra el bloque de for.
    }
    // Devuelve EstadoSolicitud.pendiente como resultado de esta función.
    return EstadoSolicitud.pendiente;
    // Cierra el bloque de desdeValor.
  }

  // Cierra las opciones de EstadoSolicitud.
}
