import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Muestra un aviso flotante coherente con el sistema de diseño.
///
/// [exito] usa el verde de "aceptada"; [error], el rojo de "rechazada".
void mostrarAviso(
  BuildContext context,
  String mensaje, {
  bool exito = false,
  bool error = false,
}) {
  final fondo = error
      ? AppColors.rechazadaTinte
      : exito
      ? AppColors.aceptadaTinte
      : AppColors.moradoOscuro;
  final texto = error
      ? AppColors.rechazadaTexto
      : exito
      ? AppColors.aceptadaTexto
      : Colors.white;
  final icono = error
      ? Icons.error_outline_rounded
      : exito
      ? Icons.check_circle_outline_rounded
      : Icons.info_outline_rounded;

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: fondo,
        duration: const Duration(seconds: 2),
        content: Row(
          children: [
            Icon(icono, size: 20, color: texto),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                mensaje,
                style: TextStyle(
                  fontFamily: AppTextStyles.inter,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: texto,
                ),
              ),
            ),
          ],
        ),
      ),
    );
}
