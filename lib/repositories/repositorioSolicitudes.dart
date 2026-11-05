// Importa datosEjemplo.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/repositories/datosEjemplo.dart';
// Importa modeloSolicitud.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/models/modeloSolicitud.dart';

/// Contrato de las solicitudes de tutoría.
// Define el contrato de acceso a solicitudes.
abstract class SolicitudesRepository {
  /// Crea una solicitud y la devuelve con su id asignado.
  // Declara en el contrato la operación que guarda una solicitud nueva con un identificador generado.
  Future<Solicitud> crear(Solicitud solicitud);

  /// Solicitudes enviadas por el alumno [idAlumno], la más reciente primero.
  // Declara en el contrato la operación que obtiene las solicitudes enviadas por un alumno.
  Future<List<Solicitud>> listarPorAlumno(String idAlumno);

  /// Solicitudes recibidas por el tutor [idTutor], la más reciente primero.
  // Declara en el contrato la operación que obtiene las solicitudes recibidas por un tutor.
  Future<List<Solicitud>> listarPorTutor(String idTutor);

  /// Cambia el estado de la solicitud [idSolicitud].
  // Declara en el contrato la operación que busca la solicitud y reemplaza su estado.
  Future<void> cambiarEstado(String idSolicitud, EstadoSolicitud estado);
  // Cierra la clase SolicitudesRepository.
}

/// Implementación simulada de [SolicitudesRepository].
///
/// Guarda las solicitudes en memoria: se pierden al cerrar la app, lo cual es
/// aceptable en la Etapa 1.
// Define la clase que reúne el almacenamiento temporal de solicitudes en memoria.
class MockSolicitudesRepository implements SolicitudesRepository {
  // Utiliza MockSolicitudesRepository con los argumentos indicados.
  MockSolicitudesRepository({List<Solicitud>? iniciales})
    // Usa esta alternativa cuando la condición anterior es falsa. Si el dato es null, usa la alternativa situada después de ??.
    : _solicitudes = List<Solicitud>.of(iniciales ?? solicitudesDemo);

  // Declara la lista de solicitudes cargadas sin permitir reasignarlo.
  final List<Solicitud> _solicitudes;

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Guarda una solicitud nueva con un identificador generado. async permite esperar operaciones sin bloquear la interfaz.
  Future<Solicitud> crear(Solicitud solicitud) async {
    // Espera el intervalo indicado para simular una operación de carga.
    await Future<void>.delayed(const Duration(milliseconds: 350));

    // Prepara la solicitud nueva con su identificador sin permitir reasignarlo.
    final nueva = Solicitud(
      // Establece el identificador al valor indicado.
      id: 'sol-${DateTime.now().millisecondsSinceEpoch}',
      // Establece el identificador del alumno al valor indicado.
      idAlumno: solicitud.idAlumno,
      // Establece el identificador del tutor al valor indicado.
      idTutor: solicitud.idTutor,
      // Establece el nombre del alumno al valor indicado.
      nombreAlumno: solicitud.nombreAlumno,
      // Establece el nombre del tutor al valor indicado.
      nombreTutor: solicitud.nombreTutor,
      // Establece la materia elegida al valor indicado.
      materia: solicitud.materia,
      // Establece el horario elegido al valor indicado.
      horario: solicitud.horario,
      // Establece el mensaje del alumno al valor indicado.
      mensaje: solicitud.mensaje,
      // Establece el estado de la solicitud al valor indicado.
      estado: solicitud.estado,
      // Establece la fecha de la solicitud al valor indicado.
      fecha: solicitud.fecha,
      // Cierra la configuración de Solicitud y termina la instrucción.
    );

    // Agrega un elemento a _solicitudes.
    _solicitudes.add(nueva);
    // Devuelve nueva como resultado de esta función.
    return nueva;
    // Cierra el bloque de crear.
  }

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Obtiene las solicitudes enviadas por un alumno. async permite esperar operaciones sin bloquear la interfaz.
  Future<List<Solicitud>> listarPorAlumno(String idAlumno) async {
    // Espera el intervalo indicado para simular una operación de carga.
    await Future<void>.delayed(const Duration(milliseconds: 300));
    // Declara en el contrato la operación que selecciona las solicitudes que cumplen los filtros indicados.
    return _filtrar(idAlumno: idAlumno);
    // Cierra el bloque de listarPorAlumno.
  }

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Obtiene las solicitudes recibidas por un tutor. async permite esperar operaciones sin bloquear la interfaz.
  Future<List<Solicitud>> listarPorTutor(String idTutor) async {
    // Espera el intervalo indicado para simular una operación de carga.
    await Future<void>.delayed(const Duration(milliseconds: 300));
    // Declara en el contrato la operación que selecciona las solicitudes que cumplen los filtros indicados.
    return _filtrar(idTutor: idTutor);
    // Cierra el bloque de listarPorTutor.
  }

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Busca la solicitud y reemplaza su estado. async permite esperar operaciones sin bloquear la interfaz.
  Future<void> cambiarEstado(String idSolicitud, EstadoSolicitud estado) async {
    // Espera el intervalo indicado para simular una operación de carga.
    await Future<void>.delayed(const Duration(milliseconds: 250));

    // Prepara la posición del elemento en la lista.
    int indice = -1;
    // Inicia un recorrido por posiciones de la lista.
    for (int posicion = 0; posicion < _solicitudes.length; posicion++) {
      // Comprueba (_solicitudes[posicion].id == idSolicitud) para decidir si se ejecuta esta parte.
      if (_solicitudes[posicion].id == idSolicitud) {
        // Actualiza indice con posicion.
        indice = posicion;
        // Termina el recorrido o la alternativa actual.
        break;
        // Cierra el bloque de if.
      }
      // Cierra el bloque de for.
    }
    // Comprueba (indice == -1) para decidir si se ejecuta esta parte.
    if (indice == -1) {
      // Genera un error porque no se encontró el dato solicitado.
      throw StateError('No existe la solicitud $idSolicitud.');
      // Cierra el bloque de if.
    }

    // Actualiza _solicitudes[indice] con _solicitudes[indice].copyWith(estado: estado).
    _solicitudes[indice] = _solicitudes[indice].copyWith(estado: estado);
    // Cierra el bloque de cambiarEstado.
  }

  // Selecciona las solicitudes que cumplen los filtros indicados. El signo ? del tipo permite que este dato sea null.
  List<Solicitud> _filtrar({String? idAlumno, String? idTutor}) {
    // Prepara resultado sin permitir reasignarlo.
    final List<Solicitud> resultado = [];
    // Recorre _solicitudes y utiliza solicitud para cada elemento.
    for (final solicitud in _solicitudes) {
      // Comprueba (idAlumno != null && solicitud.idAlumno != idAlumno) para decidir si se ejecuta esta parte.
      if (idAlumno != null && solicitud.idAlumno != idAlumno) {
        // Omite este elemento y continúa con el siguiente del recorrido.
        continue;
        // Cierra el bloque de if.
      }
      // Comprueba (idTutor != null && solicitud.idTutor != idTutor) para decidir si se ejecuta esta parte.
      if (idTutor != null && solicitud.idTutor != idTutor) {
        // Omite este elemento y continúa con el siguiente del recorrido.
        continue;
        // Cierra el bloque de if.
      }
      // Agrega un elemento a resultado.
      resultado.add(solicitud);
      // Cierra el bloque de for.
    }
    // Ordena los elementos de resultado.
    resultado.sort((primeraSolicitud, segundaSolicitud) {
      // Devuelve segundaSolicitud.fecha.compareTo(primeraSolicitud.fecha) como resultado de esta función.
      return segundaSolicitud.fecha.compareTo(primeraSolicitud.fecha);
      // Cierra el bloque de sort y termina la instrucción.
    });
    // Devuelve List<Solicitud>.unmodifiable(resultado) como resultado de esta función.
    return List<Solicitud>.unmodifiable(resultado);
    // Cierra el bloque de _filtrar.
  }

  // Cierra la clase MockSolicitudesRepository.
}
