/// Tutor que aparece en el catálogo.
///
/// Los horarios se guardan como texto con el formato
/// `"Lunes 08:00 - 10:00"`. Mantener este formato permite filtrar por día
/// sin agregar una clase extra en la Etapa 1.
// Define la clase que reúne los datos de un tutor.
class Tutor {
  // Define cómo se crea Tutor y qué datos recibe.
  const Tutor({
    // Solicita el identificador.
    required this.id,
    // Solicita el nombre.
    required this.nombre,
    // Solicita las materias del tutor.
    required this.materias,
    // Solicita la calificación del tutor.
    required this.calificacion,
    // Solicita los horarios disponibles.
    required this.horariosDisponibles,
    // Solicita la descripción del tutor.
    required this.descripcion,
    // Solicita la ruta de la fotografía.
    required this.foto,
    // Cierra el bloque de Tutor y termina la instrucción.
  });

  // Declara el identificador sin permitir reasignarlo.
  final String id;
  // Declara el nombre sin permitir reasignarlo.
  final String nombre;
  // Declara las materias del tutor sin permitir reasignarlo.
  final List<String> materias;
  // Declara la calificación del tutor sin permitir reasignarlo.
  final double calificacion;
  // Declara los horarios disponibles sin permitir reasignarlo.
  final List<String> horariosDisponibles;
  // Declara la descripción del tutor sin permitir reasignarlo.
  final String descripcion;

  /// Ruta del asset de la foto, por ejemplo `assets/images/tutor_1.png`.
  // Declara la ruta de la fotografía sin permitir reasignarlo.
  final String foto;

  // Convierte los datos del objeto en un mapa de claves y valores.
  Map<String, dynamic> toMap() {
    // Devuelve el mapa que relaciona cada nombre de campo con su valor.
    return {
      // Relaciona esta clave del mapa con el valor de la derecha.
      'id': id,
      // Relaciona esta clave del mapa con el valor de la derecha.
      'nombre': nombre,
      // Relaciona esta clave del mapa con el valor de la derecha.
      'materias': materias,
      // Relaciona esta clave del mapa con el valor de la derecha.
      'calificacion': calificacion,
      // Relaciona esta clave del mapa con el valor de la derecha.
      'horariosDisponibles': horariosDisponibles,
      // Relaciona esta clave del mapa con el valor de la derecha.
      'descripcion': descripcion,
      // Relaciona esta clave del mapa con el valor de la derecha.
      'foto': foto,
      // Cierra el bloque de instrucciones y termina la instrucción.
    };
    // Cierra el bloque de toMap.
  }

  // Construye un objeto Tutor a partir de un mapa de datos.
  factory Tutor.fromMap(Map<String, dynamic> mapa) {
    // Devuelve Tutor( como resultado de esta función.
    return Tutor(
      // Establece el identificador al valor indicado. Si el dato es null, usa la alternativa situada después de ??. as comprueba o convierte la referencia al tipo indicado.
      id: mapa['id'] as String? ?? '',
      // Establece el nombre al valor indicado. Si el dato es null, usa la alternativa situada después de ??. as comprueba o convierte la referencia al tipo indicado.
      nombre: mapa['nombre'] as String? ?? '',
      // Establece las materias del tutor al valor indicado.
      materias: _listaDeTextos(mapa['materias']),
      // Establece la calificación del tutor al valor indicado. Si el dato es null, usa la alternativa situada después de ??. as comprueba o convierte la referencia al tipo indicado.
      calificacion: (mapa['calificacion'] as num?)?.toDouble() ?? 0,
      // Establece los horarios disponibles al valor indicado.
      horariosDisponibles: _listaDeTextos(mapa['horariosDisponibles']),
      // Establece la descripción del tutor al valor indicado. Si el dato es null, usa la alternativa situada después de ??. as comprueba o convierte la referencia al tipo indicado.
      descripcion: mapa['descripcion'] as String? ?? '',
      // Establece la ruta de la fotografía al valor indicado. Si el dato es null, usa la alternativa situada después de ??. as comprueba o convierte la referencia al tipo indicado.
      foto: mapa['foto'] as String? ?? '',
      // Cierra la configuración de Tutor y termina la instrucción.
    );
    // Cierra el bloque de fromMap.
  }

  // Convierte una lista de valores en una lista de textos. El signo ? del tipo permite que este dato sea null.
  static List<String> _listaDeTextos(Object? valor) {
    // Comprueba (valor is! List) return const [] para decidir si se ejecuta esta parte. El signo ! afirma que ese dato no es null en este punto.
    if (valor is! List) return const [];
    // Prepara textos sin permitir reasignarlo.
    final List<String> textos = [];
    // Recorre valor y utiliza elemento para cada elemento.
    for (final elemento in valor) {
      // Agrega un elemento a textos.
      textos.add(elemento.toString());
      // Cierra el bloque de for.
    }
    // Devuelve textos como resultado de esta función.
    return textos;
    // Cierra el bloque de _listaDeTextos.
  }

  // Cierra la clase Tutor.
}
