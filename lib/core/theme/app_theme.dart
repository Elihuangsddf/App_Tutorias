import 'package:flutter/material.dart';

/// Tema base de la aplicación.
///
/// Es solo un punto de partida para que la app compile.
///
/// TODO(rol-1): reemplazar por el sistema de diseño de Figma (paleta,
/// tipografía, formas y estilos de botones y campos).
class AppTheme {
  const AppTheme._();

  static ThemeData get light {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      appBarTheme: const AppBarTheme(centerTitle: false),
    );
  }
}
