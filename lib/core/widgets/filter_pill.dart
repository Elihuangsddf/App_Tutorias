import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Chip de filtro o de selección única.
///
/// Sin seleccionar: blanco con borde. Seleccionado: morado con texto blanco.
class FilterPill extends StatelessWidget {
  const FilterPill({
    super.key,
    required this.label,
    required this.seleccionado,
    this.onTap,
  });

  final String label;
  final bool seleccionado;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: seleccionado ? AppColors.morado : AppColors.superficie,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.pill),
        side: BorderSide(
          color: seleccionado ? AppColors.morado : AppColors.borde,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Text(
            label,
            style: AppTextStyles.chip.copyWith(
              color: seleccionado ? Colors.white : AppColors.moradoOscuro,
            ),
          ),
        ),
      ),
    );
  }
}

/// Etiqueta estática usada en el detalle del tutor.
class InfoPill extends StatelessWidget {
  const InfoPill({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.superficie,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: AppColors.borde),
      ),
      child: Text(label, style: AppTextStyles.chip),
    );
  }
}
