import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';

/// Catálogo de tutores.
///
/// Pantalla pendiente: solo deja el acceso a la ruta de detalle con un `id`
/// de ejemplo para comprobar la navegación con argumentos.
///
/// TODO(rol-3): implementar el listado con búsqueda y filtros usando
/// `TutoresProvider`, con estados de carga, vacío, sin resultados y error.
class CatalogoTutoresScreen extends StatelessWidget {
  const CatalogoTutoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo de tutores')),
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
              'Responsable: Rol 3. Debe incluir búsqueda, filtros y el listado '
              'de tutores con TutoresProvider.',
            ),
            const Spacer(),
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                AppRoutes.detalleTutor,
                arguments: 'tutor-1',
              ),
              child: const Text('Abrir detalle de ejemplo'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.panelSolicitudes),
              child: const Text('Ir al panel de solicitudes'),
            ),
          ],
        ),
      ),
    );
  }
}
