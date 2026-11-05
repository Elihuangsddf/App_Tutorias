/// Utilidades de formato compartidas por las pantallas.
///
/// Los horarios del modelo se guardan como `"Lunes 08:00 - 10:00"`; aquí se
/// convierten a las tres variantes que usan los diseños de Figma.
class Formato {
  const Formato._();

  static const Map<String, String> _dias = {
    'Lunes': 'Lun',
    'Martes': 'Mar',
    'Miércoles': 'Mié',
    'Jueves': 'Jue',
    'Viernes': 'Vie',
    'Sábado': 'Sáb',
    'Domingo': 'Dom',
  };

  static const Set<String> _nombresFemeninos = {
    'Ana',
    'Sofía',
    'Valeria',
    'María',
    'Lucía',
    'Camila',
  };

  /// "Ana López" -> "Ana".
  static String primerNombre(String nombreCompleto) {
    final partes = nombreCompleto.trim().split(RegExp(r'\s+'));
    return partes.isEmpty ? nombreCompleto : partes.first;
  }

  /// "Ana Martínez" -> "AM".
  static String iniciales(String nombreCompleto) {
    final partes = nombreCompleto
        .trim()
        .split(RegExp(r'\s+'))
        .where((parte) => parte.isNotEmpty)
        .toList();
    if (partes.isEmpty) return '?';
    if (partes.length == 1) {
      return partes.first.substring(0, 1).toUpperCase();
    }
    return (partes.first.substring(0, 1) + partes[1].substring(0, 1))
        .toUpperCase();
  }

  /// "Ana Martínez" -> "Tutora"; "Luis Hernández" -> "Tutor".
  static String etiquetaTutor(String nombreCompleto) {
    return _nombresFemeninos.contains(primerNombre(nombreCompleto))
        ? 'Tutora'
        : 'Tutor';
  }

  /// "Lunes 08:00 - 10:00" -> "Lun 08:00 - 10:00".
  static String horarioCompacto(String horario) {
    final partes = horario.trim().split(RegExp(r'\s+'));
    if (partes.isEmpty) return horario;
    final dia = _dias[partes.first] ?? partes.first;
    return [dia, ...partes.skip(1)].join(' ');
  }

  /// "Lunes 08:00 - 10:00" -> "Lun 08:00".
  static String horarioCorto(String horario) {
    final compacto = horarioCompacto(horario);
    final indice = compacto.indexOf(RegExp(r'\s-\s'));
    return indice == -1 ? compacto : compacto.substring(0, indice);
  }

  /// "Lunes 08:00 - 10:00" -> "Lunes · 08:00 - 10:00".
  static String horarioDetalle(String horario) {
    final partes = horario.trim().split(RegExp(r'\s+'));
    if (partes.isEmpty) return horario;
    return '${partes.first} · ${partes.skip(1).join(' ')}';
  }

  /// Fecha en formato `dd/MM/yyyy`.
  static String fechaCorta(DateTime fecha) {
    final dia = fecha.day.toString().padLeft(2, '0');
    final mes = fecha.month.toString().padLeft(2, '0');
    return '$dia/$mes/${fecha.year}';
  }

  /// "6 tutores disponibles" / "1 tutor disponible".
  static String contadorTutores(int cantidad) {
    return cantidad == 1
        ? '1 tutor disponible'
        : '$cantidad tutores disponibles';
  }
}
