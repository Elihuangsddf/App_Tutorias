import '../../models/rol.dart';
import '../../models/usuario.dart';
import '../auth_repository.dart';
import 'mock_data.dart';

/// Implementación simulada de [AuthRepository].
///
/// Elige un usuario de ejemplo según el rol. El usuario tutor comparte `id`
/// con su entrada del catálogo (`tutor-1`), para que el panel de solicitudes
/// pueda listar las que recibió.
class MockAuthRepository implements AuthRepository {
  @override
  Future<Usuario> iniciarSesionPorRol(Rol rol) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));

    return usuariosDemo.firstWhere(
      (usuario) => usuario.rol == rol,
      orElse: () => throw StateError(
        'No hay usuario de ejemplo para el rol ${rol.etiqueta}.',
      ),
    );
  }

  @override
  Future<void> cerrarSesion() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
  }
}
