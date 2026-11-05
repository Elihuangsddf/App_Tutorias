import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routes/app_routes.dart';
import '../../models/rol.dart';
import '../../providers/sesion_provider.dart';

/// Panel de solicitudes.
///
/// La misma pantalla debe cambiar según el rol de la sesión.
///
/// TODO(rol-2): listar las solicitudes con `SolicitudesProvider`, permitir que
/// el alumno cree y consulte las suyas y que el tutor acepte o rechace.
class PanelSolicitudesScreen extends StatelessWidget {
  const PanelSolicitudesScreen({super.key});

  Future<void> _cerrarSesion(BuildContext context) async {
    await context.read<SesionProvider>().cerrarSesion();
    if (!context.mounted) return;
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(AppRoutes.seleccionRol, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final sesion = context.watch<SesionProvider>();
    final esTutor = sesion.rol == Rol.tutor;

    return Scaffold(
      appBar: AppBar(
        title: Text(esTutor ? 'Solicitudes recibidas' : 'Mis solicitudes'),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            icon: const Icon(Icons.logout),
            onPressed: () => _cerrarSesion(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Pantalla pendiente',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Responsable: Rol 2. Debe listar las solicitudes según el rol y '
              'permitir aceptarlas o rechazarlas con SolicitudesProvider.',
            ),
            const SizedBox(height: 16),
            Text(
              'Sesión actual: ${sesion.usuario?.nombre ?? 'sin usuario'} '
              '(${sesion.rol?.etiqueta ?? 'sin rol'})',
            ),
            const Spacer(),
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.catalogo),
              child: const Text('Volver al catálogo'),
            ),
          ],
        ),
      ),
    );
  }
}
