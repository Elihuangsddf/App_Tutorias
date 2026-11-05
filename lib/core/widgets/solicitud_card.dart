import 'package:flutter/material.dart';

import '../../models/estado_solicitud.dart';
import '../../models/solicitud.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/formato.dart';
import 'app_buttons.dart';
import 'status_chip.dart';

/// Tarjeta de solicitud usada en el panel de alumno y en el de tutor.
class SolicitudCard extends StatelessWidget {
  const SolicitudCard({
    super.key,
    required this.solicitud,
    required this.etiquetaPersona,
    required this.nombrePersona,
    this.lineasMensaje = 2,
    this.mostrarAcciones = false,
    this.mostrarRechazar = false,
    this.enProceso = false,
    this.accionEnProceso,
    this.onAceptar,
    this.onRechazar,
  });

  final Solicitud solicitud;

  /// "Tutora", "Tutor" o "Alumno".
  final String etiquetaPersona;
  final String nombrePersona;
  final int lineasMensaje;

  /// Muestra los botones Rechazar / Aceptar (solo solicitudes pendientes).
  final bool mostrarAcciones;

  /// Muestra el enlace rojo "Rechazar" en solicitudes ya aceptadas.
  final bool mostrarRechazar;

  final bool enProceso;
  final EstadoSolicitud? accionEnProceso;
  final VoidCallback? onAceptar;
  final VoidCallback? onRechazar;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.tarjeta),
      decoration: BoxDecoration(
        color: AppColors.superficie,
        borderRadius: BorderRadius.circular(AppRadii.tarjeta),
        border: Border.all(color: AppColors.borde),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  solicitud.materia,
                  style: AppTextStyles.tituloSeccion.copyWith(fontSize: 18),
                ),
              ),
              const SizedBox(width: 8),
              StatusChip(estado: solicitud.estado),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '$etiquetaPersona: $nombrePersona',
            style: AppTextStyles.cuerpo.copyWith(fontSize: 14.5),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.schedule_rounded,
                size: 16,
                color: AppColors.textoSecundario,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  solicitud.horario,
                  style: AppTextStyles.etiqueta.copyWith(fontSize: 13.5),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                Formato.fechaCorta(solicitud.fecha),
                style: AppTextStyles.etiqueta,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            solicitud.mensaje,
            maxLines: lineasMensaje,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: AppTextStyles.inter,
              fontSize: 14,
              height: 1.45,
              color: AppColors.moradoOscuro,
            ),
          ),
          if (mostrarAcciones) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    label: 'Rechazar',
                    peligro: true,
                    altura: 44,
                    cargando:
                        enProceso &&
                        accionEnProceso == EstadoSolicitud.rechazada,
                    onPressed: enProceso ? null : onRechazar,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PrimaryButton(
                    label: 'Aceptar',
                    altura: 44,
                    cargando:
                        enProceso &&
                        accionEnProceso == EstadoSolicitud.aceptada,
                    onPressed: enProceso ? null : onAceptar,
                  ),
                ),
              ],
            ),
          ] else if (mostrarRechazar) ...[
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: TextButton(
                  onPressed: enProceso ? null : onRechazar,
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.rechazada,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    textStyle: const TextStyle(
                      fontFamily: AppTextStyles.poppins,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text('Rechazar'),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
