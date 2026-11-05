import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';

/// Formulario de solicitud de tutoría.
///
/// Recibe el `id` del tutor como argumento de ruta.
///
/// TODO(rol-2): implementar el formulario con materia, horario y mensaje,
/// validaciones, y el envío mediante `SolicitudesProvider`.
class SolicitudFormScreen extends StatelessWidget {
  const SolicitudFormScreen({super.key, required this.tutorId});

  final String tutorId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Solicitar tutoría')),
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
              'Responsable: Rol 2. Debe incluir los campos, las validaciones y '
              'el envío con SolicitudesProvider.',
            ),
            const SizedBox(height: 16),
            Text('Tutor: $tutorId'),
            const Spacer(),
            OutlinedButton(
              onPressed: () => Navigator.pushReplacementNamed(
                context,
                AppRoutes.panelSolicitudes,
              ),
              child: const Text('Ir al panel de solicitudes'),
            ),
          ],
        ),
      ),
    );
  }
}
