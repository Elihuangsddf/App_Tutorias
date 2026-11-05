import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/formato.dart';

/// Avatar circular con las iniciales del usuario sobre un tinte morado.
///
/// Los diseños de Figma no usan fotografías: todos los avatares son iniciales.
class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar({
    super.key,
    required this.nombre,
    this.size = 56,
    this.backgroundColor = AppColors.moradoTinte,
    this.textColor = AppColors.morado,
  });

  final String nombre;
  final double size;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Text(
        Formato.iniciales(nombre),
        style: TextStyle(
          fontFamily: AppTextStyles.poppins,
          fontSize: size * 0.34,
          height: 1,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
          color: textColor,
        ),
      ),
    );
  }
}
