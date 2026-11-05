import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Placeholder de carga con la forma de una tarjeta de tutor.
class SkeletonCard extends StatelessWidget {
  const SkeletonCard({super.key, this.altura = 104});

  final double altura;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: altura,
      padding: const EdgeInsets.all(AppSpacing.tarjeta),
      decoration: BoxDecoration(
        color: AppColors.superficie,
        borderRadius: BorderRadius.circular(AppRadii.tarjeta),
        border: Border.all(color: AppColors.borde),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: AppColors.skeleton,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Line(widthFactor: 0.68),
                const SizedBox(height: 12),
                _Line(widthFactor: 0.45),
              ],
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.widthFactor});

  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: Container(
        height: 12,
        decoration: BoxDecoration(
          color: AppColors.skeleton,
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }
}

/// Placeholder genérico de bloques para el detalle del tutor.
class SkeletonBloque extends StatelessWidget {
  const SkeletonBloque({
    super.key,
    this.width,
    required this.height,
    this.radio = 12,
  });

  final double? width;
  final double height;
  final double radio;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.skeleton,
        borderRadius: BorderRadius.circular(radio),
      ),
    );
  }
}
