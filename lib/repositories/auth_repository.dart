import '../models/rol.dart';
import '../models/usuario.dart';

/// Contrato de autenticación.
///
/// En la Etapa 1 se usa una implementación simulada. En la Etapa 2 se agrega
/// una implementación con Firebase Auth sin tocar los Providers.
abstract class AuthRepository {
  /// Inicia sesión con un usuario de ejemplo para el [rol] indicado.
  Future<Usuario> iniciarSesionPorRol(Rol rol);

  /// Cierra la sesión actual.
  Future<void> cerrarSesion();
}
