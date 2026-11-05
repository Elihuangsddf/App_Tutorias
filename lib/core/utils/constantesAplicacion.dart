/// Constantes compartidas de la aplicación.
// Define la clase que reúne los textos y tiempos compartidos.
class AppConstants {
  // Define cómo se crea AppConstants y qué datos recibe.
  const AppConstants._();

  // Prepara nombre app.
  static const String nombreApp = 'TutoPar';
  // Prepara descripcion app.
  static const String descripcionApp = 'Tutorías entre estudiantes';
  // Prepara version mvp.
  static const String versionMvp = 'Etapa 1 · MVP local';

  /// Duración del splash antes de ir a la selección de rol.
  // Prepara duracion splash.
  static const Duration duracionSplash = Duration(milliseconds: 1500);
  // Cierra la clase AppConstants.
}
