import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Tarjeta blanca con título opcional para agrupar contenido.
class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    this.titulo,
    this.icono,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.tarjeta),
  });

  final String? titulo;
  final IconData? icono;
  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.superficie,
        borderRadius: BorderRadius.circular(AppRadii.tarjeta),
        border: Border.all(color: AppColors.borde),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (titulo != null) ...[
            Row(
              children: [
                if (icono != null) ...[
                  Icon(icono, size: 20, color: AppColors.morado),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Text(titulo!, style: AppTextStyles.tituloSeccion),
                ),
              ],
            ),
            const SizedBox(height: 14),
          ],
          child,
        ],
      ),
    );
  }
}

/// Fila de icono + etiqueta + valor, usada en horarios y metadatos.
class LabelValueRow extends StatelessWidget {
  const LabelValueRow({super.key, required this.valor, this.icono, this.extra});

  final String valor;
  final IconData? icono;
  final String? extra;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icono != null) ...[
          Icon(icono, size: 19, color: AppColors.textoSecundario),
          const SizedBox(width: 9),
        ],
        Expanded(
          child: Text(
            valor,
            style: const TextStyle(
              fontFamily: AppTextStyles.inter,
              fontSize: 15,
              height: 1.4,
              color: AppColors.moradoOscuro,
            ),
          ),
        ),
        if (extra != null) ...[
          const SizedBox(width: 8),
          Text(extra!, style: AppTextStyles.etiqueta),
        ],
      ],
    );
  }
}
