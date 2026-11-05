import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routes/app_routes.dart';
import '../../models/rol.dart';
import '../../providers/sesion_provider.dart';

/// Selección de rol con login simulado.
///
/// Es la entrada mínima al resto de la app: elige el usuario de ejemplo según
/// el rol y navega a la pantalla correspondiente.
///
/// TODO(rol-1): aplicar el diseño de Figma (tarjetas de rol, marca, estados).
class SeleccionRolScreen extends StatelessWidget {
  const SeleccionRolScreen({super.key});

  Future<void> _entrar(BuildContext context, Rol rol) async {
    final sesion = context.read<SesionProvider>();
    final exito = await sesion.iniciarSesion(rol);

    if (!context.mounted) return;

    if (!exito) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(sesion.error ?? 'No se pudo iniciar sesión.')),
      );
      return;
    }

    final destino = rol == Rol.alumno
        ? AppRoutes.catalogo
        : AppRoutes.panelSolicitudes;

    Navigator.of(context).pushReplacementNamed(destino);
  }

  @override
  Widget build(BuildContext context) {
    final sesion = context.watch<SesionProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Selección de rol')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '¿Cómo quieres entrar?',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text('El inicio de sesión es simulado en esta etapa.'),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: sesion.cargando
                  ? null
                  : () => _entrar(context, Rol.alumno),
              child: const Text('Entrar como alumno'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: sesion.cargando
                  ? null
                  : () => _entrar(context, Rol.tutor),
              child: const Text('Entrar como tutor'),
            ),
            if (sesion.cargando) ...[
              const SizedBox(height: 24),
              const Center(child: CircularProgressIndicator()),
            ],
          ],
        ),
      ),
    );
  }
}
