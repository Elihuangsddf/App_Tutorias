// Define las operaciones locales de administración sin cambiar el contrato de acceso.
import 'package:app_tutorias/models/modeloUsuario.dart';
// Conserva materias, horarios y puntuación en el perfil del tutor.
import 'package:app_tutorias/models/modeloTutor.dart';

// Se implementa en el repositorio local utilizado por la aplicación.
abstract class GestionCuentas {
  // Devuelve los perfiles completos guardados durante esta ejecución.
  List<Tutor> get perfilesTutores;
  // Guarda una cuenta nueva o modifica una existente conservando su identificador.
  Future<void> guardarCuenta(Usuario usuario, String contrasena, Tutor? perfil);
  // Elimina la cuenta y su perfil relacionado.
  Future<void> borrarCuenta(String id);
  // Completa el perfil después del registro público.
  void guardarPerfil(Tutor perfil);
}
