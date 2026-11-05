import 'package:flutter/material.dart';

import '../../models/estado_solicitud.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Chip de estado con fondo tintado y texto oscuro (contraste AA).
class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.estado});

  final EstadoSolicitud estado;

  @override
  Widget build(BuildContext context) {
    final (fondo, texto, punto) = switch (estado) {
      EstadoSolicitud.pendiente => (
        AppColors.pendienteTinte,
        AppColors.pendienteTexto,
        AppColors.ambar,
      ),
      EstadoSolicitud.aceptada => (
        AppColors.aceptadaTinte,
        AppColors.aceptadaTexto,
        AppColors.aceptada,
      ),
      EstadoSolicitud.rechazada => (
        AppColors.rechazadaTinte,
        AppColors.rechazadaTexto,
        AppColors.rechazada,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: fondo,
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: punto, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            estado.etiqueta,
            style: AppTextStyles.chipEstado.copyWith(
              color: texto,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
