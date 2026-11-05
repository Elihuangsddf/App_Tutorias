import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';

/// Detalle del tutor.
///
/// Recibe el `id` del tutor como argumento de ruta. La pantalla es un
/// placeholder que solo comprueba que el argumento llega correctamente.
///
/// TODO(rol-3): buscar el tutor en `TutoresProvider` y mostrar su perfil.
class DetalleTutorScreen extends StatelessWidget {
  const DetalleTutorScreen({super.key, required this.tutorId});

  final String tutorId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del tutor')),
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
              'Responsable: Rol 3. Debe mostrar el perfil del tutor obtenido '
              'desde TutoresProvider.',
            ),
            const SizedBox(height: 16),
            Text('Argumento recibido: $tutorId'),
            const Spacer(),
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                AppRoutes.solicitud,
                arguments: tutorId,
              ),
              child: const Text('Ir al formulario de solicitud'),
            ),
          ],
        ),
      ),
    );
  }
}
