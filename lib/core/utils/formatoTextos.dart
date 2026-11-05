/// Utilidades de formato compartidas por las pantallas.
///
/// Los horarios del modelo se guardan como `"Lunes 08:00 - 10:00"`; aquí se
/// convierten a las tres variantes que usan los diseños de Figma.
// Define la clase que reúne las funciones de formato de nombres, fechas y horarios.
class Formato {
  // Define cómo se crea Formato y qué datos recibe.
  const Formato._();

  // Evalúa static const Map<String, String> _dias = { como parte del resultado actual.
  static const Map<String, String> _dias = {
    // Relaciona esta clave del mapa con el valor de la derecha.
    'Lunes': 'Lun',
    // Relaciona esta clave del mapa con el valor de la derecha.
    'Martes': 'Mar',
    // Relaciona esta clave del mapa con el valor de la derecha.
    'Miércoles': 'Mié',
    // Relaciona esta clave del mapa con el valor de la derecha.
    'Jueves': 'Jue',
    // Relaciona esta clave del mapa con el valor de la derecha.
    'Viernes': 'Vie',
    // Relaciona esta clave del mapa con el valor de la derecha.
    'Sábado': 'Sáb',
    // Relaciona esta clave del mapa con el valor de la derecha.
    'Domingo': 'Dom',
    // Cierra el bloque de instrucciones y termina la instrucción.
  };

  // Prepara nombres femeninos.
  static const Set<String> _nombresFemeninos = {
    // Proporciona este texto al el bloque de instrucciones.
    'Ana',
    // Proporciona este texto al el bloque de instrucciones.
    'Sofía',
    // Proporciona este texto al el bloque de instrucciones.
    'Valeria',
    // Proporciona este texto al el bloque de instrucciones.
    'María',
    // Proporciona este texto al el bloque de instrucciones.
    'Lucía',
    // Proporciona este texto al el bloque de instrucciones.
    'Camila',
    // Cierra el bloque de instrucciones y termina la instrucción.
  };

  /// "Ana López" -> "Ana".
  // Obtiene la primera palabra del nombre completo.
  static String primerNombre(String nombreCompleto) {
    // Prepara partes sin permitir reasignarlo.
    final partes = nombreCompleto.trim().split(RegExp(r'\s+'));
    // Devuelve partes.isEmpty ? nombreCompleto : partes.first como resultado de esta función. La expresión ? : elige un valor según la condición.
    return partes.isEmpty ? nombreCompleto : partes.first;
    // Cierra el bloque de primerNombre.
  }

  /// "Ana Martínez" -> "AM".
  // Obtiene las iniciales del nombre.
  static String iniciales(String nombreCompleto) {
    // Prepara partes sin permitir reasignarlo.
    final List<String> partes = [];
    // Recorre nombreCompleto.trim( y utiliza parte para cada elemento.
    for (final parte in nombreCompleto.trim().split(RegExp(r'\s+'))) {
      // Comprueba (parte.isNotEmpty) para decidir si se ejecuta esta parte.
      if (parte.isNotEmpty) {
        // Agrega un elemento a partes.
        partes.add(parte);
        // Cierra el bloque de if.
      }
      // Cierra el bloque de for.
    }
    // Comprueba (partes.isEmpty) return '?' para decidir si se ejecuta esta parte.
    if (partes.isEmpty) return '?';
    // Comprueba (partes.length == 1) para decidir si se ejecuta esta parte.
    if (partes.length == 1) {
      // Devuelve partes.first.substring(0, 1).toUpperCase() como resultado de esta función.
      return partes.first.substring(0, 1).toUpperCase();
      // Cierra el bloque de if.
    }
    // Devuelve (partes.first.substring(0, 1) + partes[1].substring(0, 1)) como resultado de esta función.
    return (partes.first.substring(0, 1) + partes[1].substring(0, 1))
        // Continúa la operación con toUpperCase.
        .toUpperCase();
    // Cierra el bloque de iniciales.
  }

  /// "Ana Martínez" -> "Tutora"; "Luis Hernández" -> "Tutor".
  // Elige la etiqueta Tutor o Tutora a partir del nombre de ejemplo.
  static String etiquetaTutor(String nombreCompleto) {
    // Devuelve _nombresFemeninos.contains(primerNombre(nombreCompleto)) como resultado de esta función.
    return _nombresFemeninos.contains(primerNombre(nombreCompleto))
        // Usa esta alternativa cuando la condición anterior es verdadera.
        ? 'Tutora'
        // Usa esta alternativa cuando la condición anterior es falsa.
        : 'Tutor';
    // Cierra el bloque de etiquetaTutor.
  }

  /// "Lunes 08:00 - 10:00" -> "Lun 08:00 - 10:00".
  // Abrevia el día del horario.
  static String horarioCompacto(String horario) {
    // Prepara partes sin permitir reasignarlo.
    final partes = horario.trim().split(RegExp(r'\s+'));
    // Comprueba (partes.isEmpty) return horario para decidir si se ejecuta esta parte.
    if (partes.isEmpty) return horario;
    // Prepara dia sin permitir reasignarlo. Si el dato es null, usa la alternativa situada después de ??.
    final dia = _dias[partes.first] ?? partes.first;
    // Actualiza partes[0] con dia.
    partes[0] = dia;
    // Devuelve partes.join(' ') como resultado de esta función.
    return partes.join(' ');
    // Cierra el bloque de horarioCompacto.
  }

  /// "Lunes 08:00 - 10:00" -> "Lun 08:00".
  // Muestra el día abreviado y la hora de inicio.
  static String horarioCorto(String horario) {
    // Prepara si se utiliza una presentación reducida sin permitir reasignarlo.
    final compacto = horarioCompacto(horario);
    // Prepara la posición del elemento en la lista sin permitir reasignarlo.
    final indice = compacto.indexOf(RegExp(r'\s-\s'));
    // Devuelve indice == -1 ? compacto : compacto.substring(0, indice) como resultado de esta función. La expresión ? : elige un valor según la condición.
    return indice == -1 ? compacto : compacto.substring(0, indice);
    // Cierra el bloque de horarioCorto.
  }

  /// "Lunes 08:00 - 10:00" -> "Lunes · 08:00 - 10:00".
  // Separa el día y las horas para mostrarlos en el perfil.
  static String horarioDetalle(String horario) {
    // Prepara partes sin permitir reasignarlo.
    final partes = horario.trim().split(RegExp(r'\s+'));
    // Comprueba (partes.isEmpty) return horario para decidir si se ejecuta esta parte.
    if (partes.isEmpty) return horario;
    // Devuelve '${partes.first} · ${partes.skip(1).join(' ')}' como resultado de esta función.
    return '${partes.first} · ${partes.skip(1).join(' ')}';
    // Cierra el bloque de horarioDetalle.
  }

  /// Fecha en formato `dd/MM/yyyy`.
  // Convierte una fecha al formato día/mes/año.
  static String fechaCorta(DateTime fecha) {
    // Prepara dia sin permitir reasignarlo.
    final dia = fecha.day.toString().padLeft(2, '0');
    // Prepara mes sin permitir reasignarlo.
    final mes = fecha.month.toString().padLeft(2, '0');
    // Devuelve '$dia/$mes/${fecha.year}' como resultado de esta función.
    return '$dia/$mes/${fecha.year}';
    // Cierra el bloque de fechaCorta.
  }

  /// "6 tutores disponibles" / "1 tutor disponible".
  // Forma el texto de la cantidad de tutores disponibles.
  static String contadorTutores(int cantidad) {
    // Devuelve cantidad == 1 como resultado de esta función.
    return cantidad == 1
        // Usa esta alternativa cuando la condición anterior es verdadera.
        ? '1 tutor disponible'
        // Usa esta alternativa cuando la condición anterior es falsa.
        : '$cantidad tutores disponibles';
    // Cierra el bloque de contadorTutores.
  }

  // Cierra la clase Formato.
}
