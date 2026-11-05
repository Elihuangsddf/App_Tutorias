import 'rol.dart';

/// Usuario que inicia sesión en la aplicación.
class Usuario {
  const Usuario({required this.id, required this.nombre, required this.rol});

  final String id;
  final String nombre;
  final Rol rol;

  Map<String, dynamic> toMap() {
    return {'id': id, 'nombre': nombre, 'rol': rol.valor};
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'] as String? ?? '',
      nombre: map['nombre'] as String? ?? '',
      rol: Rol.desdeValor(map['rol'] as String?),
    );
  }
}
