// El modelo conserva los datos de la cuenta, pero nunca su contraseña.
class Usuario {
  // Crea un modelo de usuario sin contraseña con los valores indicados.
  const Usuario({
    // Recibe el identificador de la cuenta al crear el objeto.
    required this.id,
    // Recibe el nombre del usuario al crear el objeto.
    required this.nombre,
    // Recibe el correo electrónico al crear el objeto.
    required this.correo,
    // Recibe el rol guardado en la cuenta al crear el objeto.
    required this.rol,
    // Cierra el bloque de instrucciones o la definición.
  });

  // Guarda el identificador de la cuenta.
  final String id;
  // Guarda el nombre del usuario.
  final String nombre;
  // Guarda el correo electrónico.
  final String correo;
  // Guarda el rol guardado en la cuenta.
  final Rol rol;

  // Completa la operación utilizando Map<String, dynamic> toMap() {.
  Map<String, dynamic> toMap() {
    // Devuelve {'id': id, 'nombre': nombre, 'correo': correo, 'rol': rol.valor} como resultado de la función.
    return {'id': id, 'nombre': nombre, 'correo': correo, 'rol': rol.valor};
    // Cierra el bloque de instrucciones o la definición.
  }

  // Construye los datos del usuario recibidos como mapa desde un repositorio.
  factory Usuario.fromMap(Map<String, dynamic> mapa) {
    // Devuelve un modelo de usuario sin contraseña con la configuración siguiente.
    return Usuario(
      // Configura el identificador de la cuenta.
      id: mapa['id'] as String? ?? '',
      // Configura el nombre del usuario.
      nombre: mapa['nombre'] as String? ?? '',
      // Configura el correo electrónico.
      correo: mapa['correo'] as String? ?? '',
      // Configura el rol guardado en la cuenta.
      rol: Rol.desdeValor(mapa['rol'] as String?),
      // Cierra los argumentos de la operación actual.
    );
    // Cierra el bloque de instrucciones o la definición.
  }
  // Cierra el bloque de instrucciones o la definición.
}

// Docente y tutor son un único rol dentro de esta aplicación.
enum Rol {
  // Crea el objeto o la llamada alumno.
  alumno('alumno', 'Alumno'),
  // Crea el objeto o la llamada tutor.
  tutor('tutor', 'Tutor'),
  // Crea el objeto o la llamada administrador.
  administrador('administrador', 'Administrador');

  // Crea un objeto Rol con los valores indicados.
  const Rol(this.valor, this.etiqueta);

  // Guarda valor.
  final String valor;
  // Guarda la etiqueta del campo.
  final String etiqueta;

  // Convierte el rol recibido y rechaza los valores desconocidos.
  static Rol desdeValor(String? valor) {
    // Recorre los elementos de la lista indicada para comprobar o preparar cada uno.
    for (final rol in Rol.values) {
      // Comprueba (rol.valor == valor) antes de ejecutar el bloque.
      if (rol.valor == valor) {
        // Devuelve rol como resultado de la función.
        return rol;
        // Cierra el bloque de instrucciones o la definición.
      }
      // Cierra el bloque de instrucciones o la definición.
    }
    // Un valor desconocido no debe recibir permisos por defecto.
    throw const FormatException('El rol de la cuenta no es válido.');
    // Cierra el bloque de instrucciones o la definición.
  }

  // Cierra el bloque de instrucciones o la definición.
}
