import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

enum DestinoInferior { tutores, solicitudes }

/// Barra inferior de dos destinos, solo para el rol alumno.
///
/// Figma usa círculos (lleno = activo, contorno = inactivo) en lugar de iconos.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.activo, required this.onTap});

  final DestinoInferior activo;
  final ValueChanged<DestinoInferior> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.superficie,
        border: Border(top: BorderSide(color: AppColors.borde)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              _Item(
                etiqueta: 'Tutores',
                activo: activo == DestinoInferior.tutores,
                onTap: () => onTap(DestinoInferior.tutores),
              ),
              _Item(
                etiqueta: 'Solicitudes',
                activo: activo == DestinoInferior.solicitudes,
                onTap: () => onTap(DestinoInferior.solicitudes),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.etiqueta,
    required this.activo,
    required this.onTap,
  });

  final String etiqueta;
  final bool activo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: activo ? AppColors.morado : Colors.transparent,
                border: activo
                    ? null
                    : Border.all(color: AppColors.textoSecundario, width: 1.8),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              etiqueta,
              style: TextStyle(
                fontFamily: AppTextStyles.inter,
                fontSize: 13,
                height: 1,
                fontWeight: activo ? FontWeight.w600 : FontWeight.w500,
                color: activo ? AppColors.morado : AppColors.textoSecundario,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
