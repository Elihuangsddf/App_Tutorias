import 'package:flutter/material.dart';

import '../../models/tutor.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/formato.dart';
import 'initials_avatar.dart';

/// Tarjeta de tutor del catálogo.
class TutorCard extends StatelessWidget {
  const TutorCard({super.key, required this.tutor, required this.onTap});

  final Tutor tutor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.superficie,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.tarjeta),
        side: const BorderSide(color: AppColors.borde),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.tarjeta),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.tarjeta),
          child: Row(
            children: [
              InitialsAvatar(nombre: tutor.nombre, size: 56),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tutor.nombre,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.tituloTarjeta,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tutor.materias.join(' · '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.cuerpo.copyWith(
                        fontSize: 13.5,
                        letterSpacing: -0.1,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 17,
                          color: AppColors.ambar,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          tutor.calificacion.toStringAsFixed(1),
                          style: const TextStyle(
                            fontFamily: AppTextStyles.inter,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                            color: AppColors.moradoOscuro,
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Icon(
                          Icons.schedule_rounded,
                          size: 16,
                          color: AppColors.textoSecundario,
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            tutor.horariosDisponibles.isEmpty
                                ? 'Sin horario'
                                : Formato.horarioCorto(
                                    tutor.horariosDisponibles.first,
                                  ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.etiqueta.copyWith(
                              fontSize: 13.5,
                              color: AppColors.textoSecundario,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_right_rounded,
                size: 24,
                color: AppColors.morado,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
