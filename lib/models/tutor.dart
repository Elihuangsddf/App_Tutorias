/// Tutor que aparece en el catálogo.
///
/// Los horarios se guardan como texto con el formato
/// `"Lunes 08:00 - 10:00"`. Mantener este formato permite filtrar por día
/// sin agregar una clase extra en la Etapa 1.
class Tutor {
  const Tutor({
    required this.id,
    required this.nombre,
    required this.materias,
    required this.calificacion,
    required this.horariosDisponibles,
    required this.descripcion,
    required this.foto,
  });

  final String id;
  final String nombre;
  final List<String> materias;
  final double calificacion;
  final List<String> horariosDisponibles;
  final String descripcion;

  /// Ruta del asset de la foto, por ejemplo `assets/images/tutor_1.png`.
  final String foto;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'materias': materias,
      'calificacion': calificacion,
      'horariosDisponibles': horariosDisponibles,
      'descripcion': descripcion,
      'foto': foto,
    };
  }

  factory Tutor.fromMap(Map<String, dynamic> map) {
    return Tutor(
      id: map['id'] as String? ?? '',
      nombre: map['nombre'] as String? ?? '',
      materias: _listaDeTextos(map['materias']),
      calificacion: (map['calificacion'] as num?)?.toDouble() ?? 0,
      horariosDisponibles: _listaDeTextos(map['horariosDisponibles']),
      descripcion: map['descripcion'] as String? ?? '',
      foto: map['foto'] as String? ?? '',
    );
  }

  static List<String> _listaDeTextos(Object? valor) {
    if (valor is! List) return const [];
    return valor.map((elemento) => elemento.toString()).toList();
  }
}
