import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Botón principal de 48 px (44 px en variantes compactas).
///
/// Cuando [cargando] es verdadero muestra un spinner, conserva el color morado
/// y deshabilita la acción.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.cargando = false,
    this.altura = 48,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool cargando;
  final double altura;

  @override
  Widget build(BuildContext context) {
    final habilitado = !cargando && onPressed != null;

    return SizedBox(
      height: altura,
      width: double.infinity,
      child: FilledButton(
        onPressed: habilitado ? onPressed : null,
        style: FilledButton.styleFrom(
          disabledBackgroundColor: cargando
              ? AppColors.morado
              : AppColors.deshabilitado,
          disabledForegroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (cargando) ...[
              const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
            ] else if (icon != null) ...[
              Icon(icon, size: 20, color: Colors.white),
              const SizedBox(width: 10),
            ],
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.boton,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Botón secundario. Con [peligro] usa el rojo de "rechazada".
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.peligro = false,
    this.cargando = false,
    this.altura = 48,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool peligro;
  final bool cargando;
  final double altura;

  @override
  Widget build(BuildContext context) {
    final color = peligro ? AppColors.rechazada : AppColors.morado;
    final habilitado = !cargando && onPressed != null;

    return SizedBox(
      height: altura,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: habilitado ? onPressed : null,
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          backgroundColor: AppColors.superficie,
          disabledForegroundColor: AppColors.deshabilitado,
          side: BorderSide(
            color: habilitado || cargando ? color : AppColors.deshabilitado,
            width: 1.2,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (cargando) ...[
              SizedBox(
                width: 17,
                height: 17,
                child: CircularProgressIndicator(strokeWidth: 2, color: color),
              ),
              const SizedBox(width: 8),
            ] else if (icon != null) ...[
              Icon(icon, size: 19, color: color),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: AppTextStyles.poppins,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: habilitado || cargando
                      ? color
                      : AppColors.deshabilitado,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
