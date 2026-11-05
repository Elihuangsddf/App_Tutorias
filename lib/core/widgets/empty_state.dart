import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'app_buttons.dart';

/// Estado vacío, sin resultados o de error.
///
/// El icono y la acción son opcionales para respetar las variantes de Figma.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.titulo,
    required this.subtitulo,
    this.icono,
    this.accionLabel,
    this.onAccion,
    this.compacto = false,
  });

  final String titulo;
  final String subtitulo;
  final IconData? icono;
  final String? accionLabel;
  final VoidCallback? onAccion;
  final bool compacto;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.margen,
          vertical: compacto ? 24 : 40,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icono != null) ...[
              Icon(icono, size: 46, color: AppColors.textoSecundario),
              const SizedBox(height: 20),
            ],
            Text(
              titulo,
              textAlign: TextAlign.center,
              style: AppTextStyles.display.copyWith(
                fontSize: compacto ? 20 : 23,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              subtitulo,
              textAlign: TextAlign.center,
              style: AppTextStyles.cuerpo,
            ),
            if (accionLabel != null && onAccion != null) ...[
              const SizedBox(height: 28),
              PrimaryButton(label: accionLabel!, onPressed: onAccion),
            ],
          ],
        ),
      ),
    );
  }
}
