import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/constants.dart';

/// Pantalla de bienvenida.
///
/// Solo simula una verificación de sesión y navega a la selección de rol.
///
/// TODO(rol-1): aplicar el diseño de Figma y los assets definitivos.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _irASeleccionDeRol();
  }

  Future<void> _irASeleccionDeRol() async {
    await Future<void>.delayed(AppConstants.duracionSplash);
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(AppRoutes.seleccionRol);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.school_outlined, size: 72),
            const SizedBox(height: 16),
            Text(
              AppConstants.nombreApp,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text(AppConstants.descripcionApp),
            const SizedBox(height: 32),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
