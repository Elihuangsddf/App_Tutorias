import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formato.dart';
import '../../core/widgets/app_bottom_nav.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/filter_pill.dart';
import '../../core/widgets/initials_avatar.dart';
import '../../core/widgets/salir_button.dart';
import '../../core/widgets/skeletons.dart';
import '../../core/widgets/tutor_card.dart';
import '../../models/tutor.dart';
import '../../providers/sesion_provider.dart';
import '../../providers/tutores_provider.dart';

/// Catálogo de tutores con búsqueda, filtros y estados de carga.
class CatalogoTutoresScreen extends StatefulWidget {
  const CatalogoTutoresScreen({super.key});

  @override
  State<CatalogoTutoresScreen> createState() => _CatalogoTutoresScreenState();
}

class _CatalogoTutoresScreenState extends State<CatalogoTutoresScreen> {
  static const List<String> _materiasFiltro = [
    'Matemáticas',
    'Física',
    'Programación',
    'Química',
  ];

  final TextEditingController _busquedaCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = context.read<TutoresProvider>();
    _busquedaCtrl.text = provider.busqueda;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (provider.tutores.isEmpty && !provider.cargando) {
        provider.cargarTutores();
      }
    });
  }

  @override
  void dispose() {
    _busquedaCtrl.dispose();
    super.dispose();
  }

  void _limpiarFiltros(TutoresProvider provider) {
    provider.limpiarFiltros();
    _busquedaCtrl.clear();
  }

  void _abrirDetalle(Tutor tutor) {
    Navigator.of(
      context,
    ).pushNamed(AppRoutes.detalleTutor, arguments: tutor.id);
  }

  void _cambiarDestino(DestinoInferior destino) {
    if (destino == DestinoInferior.solicitudes) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.panelSolicitudes);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TutoresProvider>();
    final sesion = context.watch<SesionProvider>();
    final nombreUsuario = sesion.usuario?.nombre ?? 'Alumno';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutores'),
        automaticallyImplyLeading: false,
        actions: [
          Center(child: InitialsAvatar(nombre: nombreUsuario, size: 42)),
          const SizedBox(width: 2),
          const SalirButton(),
          const SizedBox(width: 8),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        activo: DestinoInferior.tutores,
        onTap: _cambiarDestino,
      ),
      body: _cuerpo(provider),
    );
  }

  Widget _cuerpo(TutoresProvider provider) {
    if (provider.cargando && provider.tutores.isEmpty) {
      return _cargando();
    }

    if (provider.error != null && provider.tutores.isEmpty) {
      return Center(
        child: SingleChildScrollView(
          child: EmptyState(
            icono: Icons.warning_amber_rounded,
            titulo: 'No se pudo cargar el catálogo',
            subtitulo: 'Revisa tu conexión e inténtalo de nuevo.',
            accionLabel: 'Reintentar',
            onAccion: provider.cargarTutores,
          ),
        ),
      );
    }

    if (provider.tutores.isEmpty) {
      return const Center(
        child: SingleChildScrollView(
          child: EmptyState(
            icono: Icons.groups_outlined,
            titulo: 'Aún no hay tutores disponibles',
            subtitulo: 'Vuelve a intentarlo más tarde.',
          ),
        ),
      );
    }

    final resultados = provider.resultados;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      children: [
        TextField(
          controller: _busquedaCtrl,
          onChanged: provider.actualizarBusqueda,
          textInputAction: TextInputAction.search,
          style: const TextStyle(
            fontFamily: AppTextStyles.inter,
            fontSize: 15,
            color: AppColors.moradoOscuro,
          ),
          decoration: const InputDecoration(
            hintText: 'Buscar por nombre o materia',
            prefixIcon: Icon(
              Icons.search_rounded,
              size: 21,
              color: AppColors.textoSecundario,
            ),
            prefixIconConstraints: BoxConstraints(minWidth: 46, minHeight: 24),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilterPill(
              label: 'Todas',
              seleccionado: !provider.hayFiltros,
              onTap: () => _limpiarFiltros(provider),
            ),
            for (final materia in _materiasFiltro)
              FilterPill(
                label: materia,
                seleccionado: provider.materiaFiltro == materia,
                onTap: () => provider.filtrarPorMateria(materia),
              ),
            FilterPill(
              label: '4.8+',
              seleccionado: provider.calificacionMinima == 4.8,
              onTap: () => provider.filtrarPorCalificacion(4.8),
            ),
          ],
        ),
        if (resultados.isNotEmpty) ...[
          const SizedBox(height: 20),
          Text(
            Formato.contadorTutores(resultados.length),
            style: AppTextStyles.etiqueta.copyWith(fontSize: 13.5),
          ),
          const SizedBox(height: 14),
          for (var i = 0; i < resultados.length; i++) ...[
            if (i > 0) const SizedBox(height: 12),
            TutorCard(
              tutor: resultados[i],
              onTap: () => _abrirDetalle(resultados[i]),
            ),
          ],
        ] else ...[
          const SizedBox(height: 16),
          EmptyState(
            icono: Icons.search_rounded,
            titulo: 'No encontramos tutores',
            subtitulo: 'Prueba con otra materia o limpia los filtros.',
            accionLabel: 'Limpiar filtros',
            onAccion: () => _limpiarFiltros(provider),
          ),
        ],
      ],
    );
  }

  Widget _cargando() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 48, 20, 24),
      children: const [
        Text(
          'Cargando tutores...',
          style: TextStyle(
            fontFamily: AppTextStyles.poppins,
            fontSize: 23,
            height: 1.2,
            fontWeight: FontWeight.w700,
            color: AppColors.moradoOscuro,
          ),
        ),
        SizedBox(height: 10),
        Text('Estamos preparando el catálogo.', style: AppTextStyles.cuerpo),
        SizedBox(height: 28),
        SkeletonCard(),
        SizedBox(height: 12),
        SkeletonCard(),
        SizedBox(height: 12),
        SkeletonCard(),
      ],
    );
  }
}
