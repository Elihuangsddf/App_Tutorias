import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/feedback.dart';
import '../../core/utils/formato.dart';
import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/filter_pill.dart';
import '../../core/widgets/initials_avatar.dart';
import '../../models/tutor.dart';
import '../../providers/solicitudes_provider.dart';
import '../../providers/tutores_provider.dart';

/// Formulario para enviar una solicitud de tutoría.
class SolicitudFormScreen extends StatefulWidget {
  const SolicitudFormScreen({super.key, required this.tutorId});

  final String tutorId;

  @override
  State<SolicitudFormScreen> createState() => _SolicitudFormScreenState();
}

class _SolicitudFormScreenState extends State<SolicitudFormScreen> {
  final TextEditingController _mensajeCtrl = TextEditingController();

  String? _materia;
  String? _horario;
  String? _errorMateria;
  String? _errorHorario;
  String? _errorMensaje;
  bool _enviando = false;
  bool _iniciando = false;
  int _longitud = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _asegurarCarga());
  }

  @override
  void dispose() {
    _mensajeCtrl.dispose();
    super.dispose();
  }

  Future<void> _asegurarCarga() async {
    if (!mounted) return;
    final provider = context.read<TutoresProvider>();
    if (provider.tutores.isNotEmpty || provider.cargando) return;

    setState(() => _iniciando = true);
    await provider.cargarTutores();
    if (mounted) setState(() => _iniciando = false);
  }

  void _actualizarMensaje(String valor) {
    setState(() {
      _longitud = valor.length;
      if (_errorMensaje != null) {
        final texto = valor.trim();
        if (texto.isEmpty) {
          _errorMensaje = 'El mensaje es obligatorio.';
        } else if (texto.length < 10) {
          _errorMensaje = 'El mensaje debe tener al menos 10 caracteres.';
        } else {
          _errorMensaje = null;
        }
      }
    });
  }

  Future<void> _enviar(Tutor tutor) async {
    FocusScope.of(context).unfocus();

    final mensaje = _mensajeCtrl.text.trim();
    setState(() {
      _errorMateria = _materia == null ? 'Selecciona una materia.' : null;
      _errorHorario = _horario == null ? 'Selecciona un horario.' : null;
      if (mensaje.isEmpty) {
        _errorMensaje = 'El mensaje es obligatorio.';
      } else if (mensaje.length < 10) {
        _errorMensaje = 'El mensaje debe tener al menos 10 caracteres.';
      } else {
        _errorMensaje = null;
      }
    });

    if (_errorMateria != null ||
        _errorHorario != null ||
        _errorMensaje != null) {
      return;
    }

    setState(() => _enviando = true);
    final provider = context.read<SolicitudesProvider>();
    final exito = await provider.crearSolicitud(
      idTutor: tutor.id,
      nombreTutor: tutor.nombre,
      materia: _materia!,
      horario: _horario!,
      mensaje: mensaje,
    );

    if (!mounted) return;
    setState(() => _enviando = false);

    if (!exito) {
      mostrarAviso(
        context,
        provider.error ?? 'No se pudo enviar la solicitud. Intenta de nuevo.',
        error: true,
      );
      return;
    }

    mostrarAviso(context, 'Solicitud enviada correctamente.', exito: true);
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.panelSolicitudes,
      (route) => route.settings.name == AppRoutes.seleccionRol || route.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tutoresProvider = context.watch<TutoresProvider>();
    final tutor = tutoresProvider.tutorPorId(widget.tutorId);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 48,
        titleSpacing: 0,
        leading: IconButton(
          tooltip: 'Volver',
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.chevron_left_rounded, size: 30),
        ),
        title: const Text('Solicitar tutoría'),
      ),
      body: _cuerpo(tutoresProvider, tutor),
    );
  }

  Widget _cuerpo(TutoresProvider provider, Tutor? tutor) {
    if (tutor == null) {
      if (provider.cargando || _iniciando) {
        return const Center(child: CircularProgressIndicator());
      }
      if (provider.error != null) {
        return Center(
          child: SingleChildScrollView(
            child: EmptyState(
              icono: Icons.warning_amber_rounded,
              titulo: 'No se pudo cargar el tutor',
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
            subtitulo: 'Vuelve al catálogo y elige otro perfil.',
            accionLabel: 'Volver',
            onAccion: () => Navigator.of(context).pop(),
          ),
        ),
      );
    }

    return SafeArea(
      top: false,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _resumen(tutor),
                  const SizedBox(height: 30),
                  Text('Materia', style: AppTextStyles.etiquetaCampo),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      for (final materia in tutor.materias)
                        FilterPill(
                          label: materia,
                          seleccionado: _materia == materia,
                          onTap: () => setState(() {
                            _materia = _materia == materia ? null : materia;
                            _errorMateria = null;
                          }),
                        ),
                    ],
                  ),
                  if (_errorMateria != null) ...[
                    const SizedBox(height: 8),
                    _textoError(_errorMateria!),
                  ],
                  const SizedBox(height: 28),
                  Text('Horario', style: AppTextStyles.etiquetaCampo),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      for (final horario in tutor.horariosDisponibles)
                        FilterPill(
                          label: Formato.horarioCompacto(horario),
                          seleccionado: _horario == horario,
                          onTap: () => setState(() {
                            _horario = _horario == horario ? null : horario;
                            _errorHorario = null;
                          }),
                        ),
                    ],
                  ),
                  if (_errorHorario != null) ...[
                    const SizedBox(height: 8),
                    _textoError(_errorHorario!),
                  ],
                  const SizedBox(height: 28),
                  AppTextField(
                    etiqueta: 'Mensaje',
                    hint: 'Describe qué necesitas repasar',
                    controller: _mensajeCtrl,
                    minLines: 6,
                    maxLines: 6,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    inputFormatters: [LengthLimitingTextInputFormatter(300)],
                    onChanged: _actualizarMensaje,
                    errorTexto: _errorMensaje,
                    helperTexto: 'Mínimo 10 caracteres',
                    contadorTexto: '$_longitud/300',
                    contadorAlLimite: _longitud >= 300,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: PrimaryButton(
              label: 'Enviar solicitud',
              cargando: _enviando,
              onPressed: () => _enviar(tutor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _resumen(Tutor tutor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.resumenTinte,
        borderRadius: BorderRadius.circular(AppRadii.tarjeta),
      ),
      child: Row(
        children: [
          InitialsAvatar(
            nombre: tutor.nombre,
            size: 44,
            backgroundColor: Colors.transparent,
          ),
          const SizedBox(width: 12),
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
                  style: AppTextStyles.cuerpo.copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _textoError(String texto) {
    return Text(
      texto,
      style: AppTextStyles.etiqueta.copyWith(color: AppColors.rechazada),
    );
  }
}
