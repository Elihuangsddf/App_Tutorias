import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/sesion_provider.dart';
import '../routes/app_routes.dart';

/// Cierra la sesión simulada y vuelve a la selección de rol, limpiando el
/// historial para que no se pueda regresar con el botón "atrás".
Future<void> cerrarSesionYVolverAlInicio(BuildContext context) async {
  final sesion = context.read<SesionProvider>();
  await sesion.cerrarSesion();
  if (!context.mounted) return;

  Navigator.of(
    context,
  ).pushNamedAndRemoveUntil(AppRoutes.seleccionRol, (route) => false);
}
