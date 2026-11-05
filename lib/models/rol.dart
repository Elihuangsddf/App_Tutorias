/// Rol de un usuario dentro de la aplicación.
enum Rol {
  alumno('alumno', 'Alumno'),
  tutor('tutor', 'Tutor');

  const Rol(this.valor, this.etiqueta);

  /// Valor que se guarda en los mapas (JSON/Firestore).
  final String valor;

  /// Texto que se muestra en la interfaz.
  final String etiqueta;

  static Rol desdeValor(String? valor) {
    return Rol.values.firstWhere(
      (rol) => rol.valor == valor,
      orElse: () => Rol.alumno,
    );
  }
}
