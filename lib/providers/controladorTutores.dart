// Importa ChangeNotifier para avisar a la interfaz cuando cambian los datos.
import 'package:flutter/foundation.dart';

// Importa modeloTutor.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/models/modeloTutor.dart';
// Importa repositorioTutores.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/repositories/repositorioTutores.dart';

/// Estado del catálogo: lista de tutores, búsqueda, filtros y estados de
/// carga y error.
// Define la clase que reúne el catálogo de tutores y sus filtros.
class TutoresProvider extends ChangeNotifier {
  // Define cómo se crea TutoresProvider y qué datos recibe.
  TutoresProvider(this._repositorio);

  // Guarda el repositorio que se utilizará para consultar o modificar los datos.
  final TutoresRepository _repositorio;

  // Prepara la lista de tutores cargados.
  List<Tutor> _tutores = [];
  // Prepara el indicador de carga de datos.
  bool _cargando = false;
  // Declara el último mensaje de error. El signo ? del tipo permite que este dato sea null.
  String? _error;

  // Prepara el texto de búsqueda.
  String _busqueda = '';
  // Declara la materia seleccionada. El signo ? del tipo permite que este dato sea null.
  String? _materia;
  // Declara la calificación mínima del filtro. El signo ? del tipo permite que este dato sea null.
  double? _calificacionMinima;
  // Declara el día del filtro. El signo ? del tipo permite que este dato sea null.
  String? _dia;

  // Permite consultar tutores mediante una propiedad de lectura.
  List<Tutor> get tutores {
    // Devuelve List<Tutor>.unmodifiable(_tutores) como resultado de esta función.
    return List<Tutor>.unmodifiable(_tutores);
    // Cierra la propiedad tutores.
  }

  // Permite consultar si se muestra el indicador de carga mediante una propiedad de lectura.
  bool get cargando {
    // Devuelve _cargando como resultado de esta función.
    return _cargando;
    // Cierra la propiedad cargando.
  }

  // Permite consultar el error o su presentación mediante una propiedad de lectura. El signo ? del tipo permite que este dato sea null.
  String? get error {
    // Devuelve _error como resultado de esta función.
    return _error;
    // Cierra la propiedad error.
  }

  // Permite consultar busqueda mediante una propiedad de lectura.
  String get busqueda {
    // Devuelve _busqueda como resultado de esta función.
    return _busqueda;
    // Cierra la propiedad busqueda.
  }

  // Permite consultar materia filtro mediante una propiedad de lectura. El signo ? del tipo permite que este dato sea null.
  String? get materiaFiltro {
    // Devuelve _materia como resultado de esta función.
    return _materia;
    // Cierra la propiedad materiaFiltro.
  }

  // Permite consultar calificacion minima mediante una propiedad de lectura. El signo ? del tipo permite que este dato sea null.
  double? get calificacionMinima {
    // Devuelve _calificacionMinima como resultado de esta función.
    return _calificacionMinima;
    // Cierra la propiedad calificacionMinima.
  }

  // Permite consultar dia filtro mediante una propiedad de lectura. El signo ? del tipo permite que este dato sea null.
  String? get diaFiltro {
    // Devuelve _dia como resultado de esta función.
    return _dia;
    // Cierra la propiedad diaFiltro.
  }

  // Permite consultar hay filtros mediante una propiedad de lectura.
  bool get hayFiltros {
    // Devuelve _materia != null || _calificacionMinima != null || _dia != null como resultado de esta función.
    return _materia != null || _calificacionMinima != null || _dia != null;
    // Cierra la propiedad hayFiltros.
  }

  /// Materias disponibles, sin repetir y ordenadas alfabéticamente.
  // Permite consultar las materias del tutor mediante una propiedad de lectura.
  List<String> get materias {
    // Prepara el conjunto que evita valores repetidos sin permitir reasignarlo.
    final conjunto = <String>{};
    // Recorre _tutores y utiliza tutor para cada elemento.
    for (final tutor in _tutores) {
      // Agrega varios elementos a conjunto.
      conjunto.addAll(tutor.materias);
      // Cierra el bloque de for.
    }
    // Prepara la lista de resultados sin permitir reasignarlo.
    final lista = conjunto.toList();
    // Ordena los elementos de lista.
    lista.sort();
    // Devuelve lista como resultado de esta función.
    return lista;
    // Cierra la propiedad materias.
  }

  /// Días disponibles según los horarios del catálogo.
  // Permite consultar dias mediante una propiedad de lectura.
  List<String> get dias {
    // Prepara el conjunto que evita valores repetidos sin permitir reasignarlo.
    final conjunto = <String>{};
    // Recorre _tutores y utiliza tutor para cada elemento.
    for (final tutor in _tutores) {
      // Recorre tutor.horariosDisponibles y utiliza horario para cada elemento.
      for (final horario in tutor.horariosDisponibles) {
        // Agrega un elemento a conjunto.
        conjunto.add(horario.split(' ').first);
        // Cierra el bloque de for.
      }
      // Cierra el bloque de for.
    }
    // Prepara la lista de resultados sin permitir reasignarlo.
    final lista = conjunto.toList();
    // Ordena los elementos de lista.
    lista.sort();
    // Devuelve lista como resultado de esta función.
    return lista;
    // Cierra la propiedad dias.
  }

  /// Lista filtrada que deben dibujar las pantallas.
  // Permite consultar los tutores que cumplen los filtros mediante una propiedad de lectura.
  List<Tutor> get resultados {
    // Prepara el texto que se va a utilizar sin permitir reasignarlo.
    final texto = _busqueda.trim().toLowerCase();

    // Prepara la lista de tutores que cumplen las condiciones sin permitir reasignarlo.
    final List<Tutor> tutoresFiltrados = [];
    // Prepara una referencia local a la materia del filtro sin permitir reasignarlo.
    final materiaSeleccionada = _materia;
    // Prepara una referencia local a la calificación mínima sin permitir reasignarlo.
    final calificacionSeleccionada = _calificacionMinima;
    // Prepara una referencia local al día del filtro sin permitir reasignarlo.
    final diaSeleccionado = _dia;

    // Recorre _tutores y utiliza tutor para cada elemento.
    for (final tutor in _tutores) {
      // Prepara si el nombre o una materia coincide con la búsqueda.
      bool coincideTexto =
          // Evalúa texto.isEmpty || tutor.nombre.toLowerCase().contains(texto) como parte del resultado actual.
          texto.isEmpty || tutor.nombre.toLowerCase().contains(texto);
      // Recorre tutor.materias y utiliza materia para cada elemento.
      for (final materia in tutor.materias) {
        // Comprueba (materia.toLowerCase().contains(texto)) para decidir si se ejecuta esta parte.
        if (materia.toLowerCase().contains(texto)) {
          // Actualiza coincideTexto con true.
          coincideTexto = true;
          // Cierra el bloque de if.
        }
        // Cierra el bloque de for.
      }
      // Comprueba (!coincideTexto) para decidir si se ejecuta esta parte.
      if (!coincideTexto) {
        // Omite este elemento y continúa con el siguiente del recorrido.
        continue;
        // Cierra el bloque de if.
      }
      // Comprueba (materiaSeleccionada != null && para decidir si se ejecuta esta parte.
      if (materiaSeleccionada != null &&
          // Comprueba que el tutor no imparta la materia seleccionada para descartarlo.
          !tutor.materias.contains(materiaSeleccionada)) {
        // Omite este elemento y continúa con el siguiente del recorrido.
        continue;
        // Cierra el bloque de contains.
      }
      // Comprueba (calificacionSeleccionada != null && para decidir si se ejecuta esta parte.
      if (calificacionSeleccionada != null &&
          // Evalúa tutor.calificacion < calificacionSeleccionada) { como parte del resultado actual.
          tutor.calificacion < calificacionSeleccionada) {
        // Omite este elemento y continúa con el siguiente del recorrido.
        continue;
        // Cierra el bloque de instrucciones.
      }
      // Comprueba (diaSeleccionado != null) para decidir si se ejecuta esta parte.
      if (diaSeleccionado != null) {
        // Prepara si alguno de los horarios corresponde al día elegido.
        bool coincideDia = false;
        // Recorre tutor.horariosDisponibles y utiliza horario para cada elemento.
        for (final horario in tutor.horariosDisponibles) {
          // Comprueba (horario.toLowerCase().startsWith(diaSeleccionado.toLowerCase())) para decidir si se ejecuta esta parte.
          if (horario.toLowerCase().startsWith(diaSeleccionado.toLowerCase())) {
            // Actualiza coincideDia con true.
            coincideDia = true;
            // Cierra el bloque de if.
          }
          // Cierra el bloque de for.
        }
        // Comprueba (!coincideDia) para decidir si se ejecuta esta parte.
        if (!coincideDia) {
          // Omite este elemento y continúa con el siguiente del recorrido.
          continue;
          // Cierra el bloque de if.
        }
        // Cierra el bloque de if.
      }
      // Agrega un elemento a tutoresFiltrados.
      tutoresFiltrados.add(tutor);
      // Cierra el bloque de for.
    }
    // Devuelve tutoresFiltrados como resultado de esta función.
    return tutoresFiltrados;
    // Cierra la propiedad resultados.
  }

  // Carga el catálogo de tutores. async permite esperar operaciones sin bloquear la interfaz.
  Future<void> cargarTutores() async {
    // Actualiza _cargando con true.
    _cargando = true;
    // Actualiza _error con null.
    _error = null;
    // Avisa a las pantallas que consultan este controlador de que sus datos cambiaron.
    notifyListeners();

    // Intenta realizar la operación y permite manejar sus errores.
    try {
      // Actualiza _tutores con await _repositorio.obtenerTutores().
      _tutores = await _repositorio.obtenerTutores();
      // Captura un fallo de la operación para mostrar un error controlado.
    } catch (_) {
      // Actualiza _error con 'No se pudieron cargar los tutores. Intenta de nuevo.'.
      _error = 'No se pudieron cargar los tutores. Intenta de nuevo.';
      // Ejecuta la limpieza del estado tanto si la operación funcionó como si falló.
    } finally {
      // Actualiza _cargando con false.
      _cargando = false;
      // Avisa a las pantallas que consultan este controlador de que sus datos cambiaron.
      notifyListeners();
      // Cierra el bloque de instrucciones.
    }
    // Cierra el bloque de cargarTutores.
  }

  // Busca un tutor por su identificador. El signo ? del tipo permite que este dato sea null.
  Tutor? tutorPorId(String id) {
    // Recorre _tutores y utiliza tutor para cada elemento.
    for (final tutor in _tutores) {
      // Devuelve este tutor si su identificador coincide con el buscado.
      if (tutor.id == id) return tutor;
      // Cierra el bloque de for.
    }
    // Devuelve null para indicar que no hay un resultado o error que entregar.
    return null;
    // Cierra el bloque de tutorPorId.
  }

  // Actualiza el texto utilizado para buscar tutores.
  void actualizarBusqueda(String texto) {
    // Comprueba (_busqueda == texto) return para decidir si se ejecuta esta parte.
    if (_busqueda == texto) return;
    // Actualiza _busqueda con texto.
    _busqueda = texto;
    // Avisa a las pantallas que consultan este controlador de que sus datos cambiaron.
    notifyListeners();
    // Cierra el bloque de actualizarBusqueda.
  }

  // Activa o desactiva el filtro de materia. El signo ? del tipo permite que este dato sea null.
  void filtrarPorMateria(String? materia) {
    // Actualiza _materia con _materia == materia ? null : materia. La expresión ? : elige un valor según la condición.
    _materia = _materia == materia ? null : materia;
    // Avisa a las pantallas que consultan este controlador de que sus datos cambiaron.
    notifyListeners();
    // Cierra el bloque de filtrarPorMateria.
  }

  // Activa o desactiva el filtro de calificación mínima. El signo ? del tipo permite que este dato sea null.
  void filtrarPorCalificacion(double? minima) {
    // Actualiza _calificacionMinima con _calificacionMinima == minima ? null : minima. La expresión ? : elige un valor según la condición.
    _calificacionMinima = _calificacionMinima == minima ? null : minima;
    // Avisa a las pantallas que consultan este controlador de que sus datos cambiaron.
    notifyListeners();
    // Cierra el bloque de filtrarPorCalificacion.
  }

  // Activa o desactiva el filtro de día. El signo ? del tipo permite que este dato sea null.
  void filtrarPorDia(String? dia) {
    // Actualiza _dia con _dia == dia ? null : dia. La expresión ? : elige un valor según la condición.
    _dia = _dia == dia ? null : dia;
    // Avisa a las pantallas que consultan este controlador de que sus datos cambiaron.
    notifyListeners();
    // Cierra el bloque de filtrarPorDia.
  }

  // Borra la búsqueda y los filtros del catálogo.
  void limpiarFiltros() {
    // Actualiza _busqueda con ''.
    _busqueda = '';
    // Actualiza _materia con null.
    _materia = null;
    // Actualiza _calificacionMinima con null.
    _calificacionMinima = null;
    // Actualiza _dia con null.
    _dia = null;
    // Avisa a las pantallas que consultan este controlador de que sus datos cambiaron.
    notifyListeners();
    // Cierra el bloque de limpiarFiltros.
  }

  // Cierra la clase TutoresProvider.
}
