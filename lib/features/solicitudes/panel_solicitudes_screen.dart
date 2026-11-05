import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/feedback.dart';
import '../../core/utils/formato.dart';
import '../../core/widgets/app_bottom_nav.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/filter_pill.dart';
import '../../core/widgets/salir_button.dart';
import '../../core/widgets/skeletons.dart';
import '../../core/widgets/solicitud_card.dart';
import '../../models/estado_solicitud.dart';
import '../../models/rol.dart';
import '../../models/solicitud.dart';
import '../../providers/sesion_provider.dart';
import '../../providers/solicitudes_provider.dart';

enum _FiltroPanel { todas, pendientes, aceptadas, rechazadas }

/// Panel de solicitudes: variante alumno (consulta) y tutor (acepta/rechaza).
class PanelSolicitudesScreen extends StatefulWidget {
  const PanelSolicitudesScreen({super.key});

  @override
  State<PanelSolicitudesScreen> createState() => _PanelSolicitudesScreenState();
}

class _PanelSolicitudesScreenState extends State<PanelSolicitudesScreen> {
  _FiltroPanel _filtro = _FiltroPanel.todas;
  String? _idEnProceso;
  EstadoSolicitud? _accionEnProceso;

  Future<void> _cambiarEstado(
    Solicitud solicitud,
    EstadoSolicitud estado,
  ) async {
    if (_idEnProceso != null) return;

    setState(() {
      _idEnProceso = solicitud.id;
      _accionEnProceso = estado;
    });

    final provider = context.read<SolicitudesProvider>();
    if (estado == EstadoSolicitud.aceptada) {
      await provider.aceptar(solicitud.id);
    } else {
      await provider.rechazar(solicitud.id);
    }

    if (!mounted) return;
    final error = provider.error;
    setState(() {
      _idEnProceso = null;
      _accionEnProceso = null;
    });

    if (error != null) {
      mostrarAviso(context, error, error: true);
      return;
    }

    mostrarAviso(
      context,
      estado == EstadoSolicitud.aceptada
          ? 'Solicitud aceptada.'
          : 'Solicitud rechazada.',
      exito: estado == EstadoSolicitud.aceptada,
      error: estado == EstadoSolicitud.rechazada,
    );
  }

  void _cambiarDestino(DestinoInferior destino) {
    if (destino == DestinoInferior.tutores) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.catalogo,
        (route) =>
            route.settings.name == AppRoutes.seleccionRol || route.isFirst,
      );
    }
  }

  List<Solicitud> _filtrar(List<Solicitud> solicitudes) {
    return switch (_filtro) {
      _FiltroPanel.todas => solicitudes,
      _FiltroPanel.pendientes =>
        solicitudes
            .where((s) => s.estado == EstadoSolicitud.pendiente)
            .toList(),
      _FiltroPanel.aceptadas =>
        solicitudes.where((s) => s.estado == EstadoSolicitud.aceptada).toList(),
      _FiltroPanel.rechazadas =>
        solicitudes
            .where((s) => s.estado == EstadoSolicitud.rechazada)
            .toList(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final sesion = context.watch<SesionProvider>();
    final provider = context.watch<SolicitudesProvider>();
    final esTutor = sesion.rol == Rol.tutor;

    return Scaffold(
      appBar: AppBar(
        title: Text(esTutor ? 'Solicitudes recibidas' : 'Mis solicitudes'),
        automaticallyImplyLeading: false,
        actions: const [SalirButton(), SizedBox(width: 8)],
      ),
      bottomNavigationBar: esTutor
          ? null
          : AppBottomNav(
              activo: DestinoInferior.solicitudes,
              onTap: _cambiarDestino,
            ),
      body: _cuerpo(sesion, provider, esTutor),
    );
  }

  Widget _cuerpo(
    SesionProvider sesion,
    SolicitudesProvider provider,
    bool esTutor,
  ) {
    if (provider.cargando && provider.solicitudes.isEmpty) {
      return _cargando(sesion, esTutor);
    }

    if (provider.error != null && provider.solicitudes.isEmpty) {
      return _conSalir(
        Center(
          child: SingleChildScrollView(
            child: EmptyState(
              icono: Icons.warning_amber_rounded,
              titulo: 'No se pudieron cargar las solicitudes',
              subtitulo: 'Revisa tu conexión e inténtalo de nuevo.',
              accionLabel: 'Reintentar',
              onAccion: provider.cargar,
            ),
          ),
        ),
      );
    }

    if (provider.solicitudes.isEmpty) {
      return _conSalir(
        Center(
          child: SingleChildScrollView(
            child: esTutor
                ? const EmptyState(
                    titulo: 'No tienes solicitudes por ahora',
                    subtitulo: 'Cuando recibas solicitudes, aparecerán aquí.',
                  )
                : EmptyState(
                    titulo: 'Todavía no has enviado solicitudes',
                    subtitulo:
                        'Explora el catálogo para encontrar apoyo académico.',
                    accionLabel: 'Explorar tutores',
                    onAccion: () => Navigator.of(
                      context,
                    ).pushReplacementNamed(AppRoutes.catalogo),
                  ),
          ),
        ),
      );
    }

    final filtradas = _filtrar(provider.solicitudes);
    final nombre = sesion.usuario?.nombre ?? '';

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      children: [
        Text(
          nombre.isEmpty ? 'Hola' : 'Hola, ${Formato.primerNombre(nombre)}',
          style: AppTextStyles.display.copyWith(fontSize: 26),
        ),
        const SizedBox(height: 6),
        Text(
          esTutor
              ? 'Revisa las solicitudes que te enviaron.'
              : 'Consulta el estado de tus solicitudes.',
          style: AppTextStyles.cuerpo.copyWith(fontSize: 15.5),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _filtroPill('Todas', _FiltroPanel.todas),
            _filtroPill('Pendientes', _FiltroPanel.pendientes),
            _filtroPill('Aceptadas', _FiltroPanel.aceptadas),
            _filtroPill('Rechazadas', _FiltroPanel.rechazadas),
          ],
        ),
        const SizedBox(height: 24),
        if (filtradas.isEmpty)
          const EmptyState(
            compacto: true,
            titulo: 'No tienes solicitudes en este estado.',
            subtitulo: 'Prueba con otro filtro.',
          )
        else
          for (var i = 0; i < filtradas.length; i++) ...[
            if (i > 0) const SizedBox(height: 12),
            _tarjeta(filtradas[i], esTutor),
          ],
        const SizedBox(height: 10),
        _botonSalir(),
      ],
    );
  }

  Widget _filtroPill(String label, _FiltroPanel filtro) {
    return FilterPill(
      label: label,
      seleccionado: _filtro == filtro,
      onTap: () => setState(() => _filtro = filtro),
    );
  }

  Widget _tarjeta(Solicitud solicitud, bool esTutor) {
    final nombreAlumno = solicitud.nombreAlumno.isEmpty
        ? 'Alumno'
        : solicitud.nombreAlumno;
    final nombreTutor = solicitud.nombreTutor.isEmpty
        ? 'Tutor'
        : solicitud.nombreTutor;
    final pendiente = solicitud.estado == EstadoSolicitud.pendiente;
    final aceptada = solicitud.estado == EstadoSolicitud.aceptada;

    return SolicitudCard(
      solicitud: solicitud,
      etiquetaPersona: esTutor ? 'Alumno' : Formato.etiquetaTutor(nombreTutor),
      nombrePersona: esTutor ? nombreAlumno : nombreTutor,
      lineasMensaje: esTutor ? 3 : 1,
      mostrarAcciones: esTutor && pendiente,
      mostrarRechazar: esTutor && aceptada,
      enProceso: _idEnProceso == solicitud.id,
      accionEnProceso: _accionEnProceso,
      onAceptar: () => _cambiarEstado(solicitud, EstadoSolicitud.aceptada),
      onRechazar: () => _cambiarEstado(solicitud, EstadoSolicitud.rechazada),
    );
  }

  Widget _cargando(SesionProvider sesion, bool esTutor) {
    final nombre = sesion.usuario?.nombre ?? '';
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      children: [
        Text(
          nombre.isEmpty ? 'Hola' : 'Hola, ${Formato.primerNombre(nombre)}',
          style: AppTextStyles.display.copyWith(fontSize: 26),
        ),
        const SizedBox(height: 6),
        Text(
          esTutor
              ? 'Revisa las solicitudes que te enviaron.'
              : 'Consulta el estado de tus solicitudes.',
          style: AppTextStyles.cuerpo.copyWith(fontSize: 15.5),
        ),
        const SizedBox(height: 24),
        const SkeletonCard(altura: 150),
        const SizedBox(height: 12),
        const SkeletonCard(altura: 150),
        const SizedBox(height: 12),
        const SkeletonCard(altura: 150),
      ],
    );
  }

  Widget _conSalir(Widget contenido) {
    return SafeArea(
      top: false,
      child: Column(
        children: [
          Expanded(child: contenido),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 12, 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: _botonSalir(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _botonSalir() {
    return const Align(alignment: Alignment.centerRight, child: SalirButton());
  }
}
