import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Tarjeta grande de selección de rol (Alumno / Tutor).
class RoleCard extends StatelessWidget {
  const RoleCard({
    super.key,
    required this.titulo,
    required this.descripcion,
    required this.icono,
    required this.colorIcono,
    required this.colorFondoIcono,
    required this.onTap,
    this.cargando = false,
    this.habilitado = true,
  });

  final String titulo;
  final String descripcion;
  final IconData icono;
  final Color colorIcono;
  final Color colorFondoIcono;
  final VoidCallback onTap;
  final bool cargando;
  final bool habilitado;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: habilitado || cargando ? 1 : 0.55,
      child: Material(
        color: AppColors.superficie,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.tarjeta),
          side: BorderSide(
            color: cargando ? AppColors.morado : AppColors.borde,
            width: cargando ? 1.4 : 1,
          ),
        ),
        child: InkWell(
          onTap: habilitado && !cargando ? onTap : null,
          borderRadius: BorderRadius.circular(AppRadii.tarjeta),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colorFondoIcono,
                    shape: BoxShape.circle,
                  ),
                  child: cargando
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Icon(icono, size: 24, color: colorIcono),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(titulo, style: AppTextStyles.tituloSeccion),
                      const SizedBox(height: 6),
                      Text(
                        descripcion,
                        style: AppTextStyles.cuerpo.copyWith(
                          fontSize: 13.5,
                          letterSpacing: -0.1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 24,
                  color: AppColors.morado,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
