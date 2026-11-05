import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/sesion_acciones.dart';

/// Botón "Salir ↗" para cerrar la sesión desde cualquier pantalla principal.
///
/// Se usa en la barra superior para que la salida esté siempre visible, incluso
/// cuando el panel tiene muchas solicitudes.
class SalirButton extends StatelessWidget {
  const SalirButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => cerrarSesionYVolverAlInicio(context),
      icon: const Icon(Icons.north_east_rounded, size: 17),
      label: const Text('Salir'),
      style: TextButton.styleFrom(
        foregroundColor: AppColors.morado,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        textStyle: const TextStyle(
          fontFamily: AppTextStyles.poppins,
          fontSize: 14.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
