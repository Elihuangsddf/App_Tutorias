import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formato.dart';
import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/filter_pill.dart';
import '../../core/widgets/initials_avatar.dart';
import '../../core/widgets/section_card.dart';
import '../../core/widgets/skeletons.dart';
import '../../models/tutor.dart';
import '../../providers/tutores_provider.dart';

/// Perfil completo del tutor con llamada a la acción fija.
class DetalleTutorScreen extends StatefulWidget {
  const DetalleTutorScreen({super.key, required this.tutorId});

  final String tutorId;

  @override
  State<DetalleTutorScreen> createState() => _DetalleTutorScreenState();
}

class _DetalleTutorScreenState extends State<DetalleTutorScreen> {
  bool _iniciando = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _asegurarCarga());
  }

  Future<void> _asegurarCarga() async {
    if (!mounted) return;
    final provider = context.read<TutoresProvider>();
    if (provider.tutores.isNotEmpty || provider.cargando) return;

    setState(() => _iniciando = true);
    await provider.cargarTutores();
    if (mounted) setState(() => _iniciando = false);
  }

  void _abrirFormulario(Tutor tutor) {
    Navigator.of(context).pushNamed(AppRoutes.solicitud, arguments: tutor.id);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TutoresProvider>();
    final tutor = provider.tutorPorId(widget.tutorId);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 48,
        titleSpacing: 0,
        leading: IconButton(
          tooltip: 'Volver',
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.chevron_left_rounded, size: 30),
        ),
        title: const Text('Perfil del tutor'),
      ),
      body: _cuerpo(provider, tutor),
    );
  }

  Widget _cuerpo(TutoresProvider provider, Tutor? tutor) {
    if (tutor == null) {
      if (provider.cargando || _iniciando) {
        return _esqueleto();
      }
      if (provider.error != null) {
        return Center(
          child: SingleChildScrollView(
            child: EmptyState(
              icono: Icons.warning_amber_rounded,
              titulo: 'No se pudo cargar el perfil',
              subtitulo: 'Revisa tu conexión e inténtalo de nuevo.',
              accionLabel: 'Reintentar',
              onAccion: provider.cargarTutores,
            ),
          ),
        );
      }
      return Center(
        child: SingleChildScrollView(
          child: EmptyState(
            icono: Icons.person_off_outlined,
            titulo: 'No encontramos este tutor',
            subtitulo: 'Puede que ya no esté disponible en el catálogo.',
            accionLabel: 'Volver',
            onAccion: () => Navigator.of(context).pop(),
          ),
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(child: InitialsAvatar(nombre: tutor.nombre, size: 72)),
                const SizedBox(height: 18),
                Center(
                  child: Text(
                    tutor.nombre,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.display.copyWith(fontSize: 25),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 20,
                        color: AppColors.ambar,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${tutor.calificacion.toStringAsFixed(1)} de 5',
                        style: const TextStyle(
                          fontFamily: AppTextStyles.inter,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.ambarTexto,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: [
                      for (final materia in tutor.materias)
                        InfoPill(label: materia),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Text('Sobre el tutor', style: AppTextStyles.tituloSeccion),
                const SizedBox(height: 8),
                Text(tutor.descripcion, style: AppTextStyles.cuerpo),
                const SizedBox(height: 24),
                SectionCard(
                  titulo: 'Horarios disponibles',
                  child: Column(
                    children: [
                      for (
                        var i = 0;
                        i < tutor.horariosDisponibles.length;
                        i++
                      ) ...[
                        if (i > 0) const SizedBox(height: 16),
                        LabelValueRow(
                          icono: Icons.schedule_rounded,
                          valor: Formato.horarioDetalle(
                            tutor.horariosDisponibles[i],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text('Materias', style: AppTextStyles.tituloSeccion),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (final materia in tutor.materias)
                      InfoPill(label: materia),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: PrimaryButton(
              label: 'Solicitar tutoría',
              icon: Icons.send_rounded,
              onPressed: () => _abrirFormulario(tutor),
            ),
          ),
        ),
      ],
    );
  }

  Widget _esqueleto() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
      children: const [
        Center(child: SkeletonBloque(width: 72, height: 72, radio: 36)),
        SizedBox(height: 18),
        Center(child: SkeletonBloque(width: 190, height: 22)),
        SizedBox(height: 12),
        Center(child: SkeletonBloque(width: 120, height: 16)),
        SizedBox(height: 26),
        Center(child: SkeletonBloque(width: 220, height: 34, radio: 999)),
        SizedBox(height: 32),
        SkeletonBloque(width: 140, height: 18),
        SizedBox(height: 12),
        SkeletonBloque(width: double.infinity, height: 14),
        SizedBox(height: 8),
        SkeletonBloque(width: double.infinity, height: 14),
        SizedBox(height: 8),
        SkeletonBloque(width: 240, height: 14),
        SizedBox(height: 28),
        SkeletonBloque(width: double.infinity, height: 120, radio: 16),
      ],
    );
  }
}
