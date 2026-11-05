import 'package:flutter/material.dart';

import '../../features/auth/seleccion_rol_screen.dart';
import '../../features/auth/splash_screen.dart';
import '../../features/solicitudes/panel_solicitudes_screen.dart';
import '../../features/solicitudes/solicitud_form_screen.dart';
import '../../features/tutores/catalogo_tutores_screen.dart';
import '../../features/tutores/detalle_tutor_screen.dart';

/// Nombres de todas las rutas de la aplicación.
class AppRoutes {
  const AppRoutes._();

  static const String splash = '/';
  static const String seleccionRol = '/seleccion-rol';
  static const String catalogo = '/catalogo';
  static const String detalleTutor = '/detalle-tutor';
  static const String solicitud = '/solicitud';
  static const String panelSolicitudes = '/panel-solicitudes';

  /// Tabla de navegación.
  ///
  /// El detalle del tutor y el formulario reciben el `id` del tutor como
  /// argumento, nunca el objeto completo.
  static Route<dynamic> generarRuta(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
      case seleccionRol:
        return MaterialPageRoute(
          builder: (_) => const SeleccionRolScreen(),
          settings: settings,
        );
      case catalogo:
        return MaterialPageRoute(
          builder: (_) => const CatalogoTutoresScreen(),
          settings: settings,
        );
      case panelSolicitudes:
        return MaterialPageRoute(
          builder: (_) => const PanelSolicitudesScreen(),
          settings: settings,
        );
      case detalleTutor:
        final id = settings.arguments;
        if (id is! String || id.isEmpty) {
          return _rutaInvalida(settings, 'Falta el id del tutor.');
        }
        return MaterialPageRoute(
          builder: (_) => DetalleTutorScreen(tutorId: id),
          settings: settings,
        );
      case solicitud:
        final id = settings.arguments;
        if (id is! String || id.isEmpty) {
          return _rutaInvalida(settings, 'Falta el id del tutor.');
        }
        return MaterialPageRoute(
          builder: (_) => SolicitudFormScreen(tutorId: id),
          settings: settings,
        );
      default:
        return _rutaInvalida(settings, 'La ruta "${settings.name}" no existe.');
    }
  }

  static Route<dynamic> _rutaInvalida(RouteSettings settings, String mensaje) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error de navegación')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Text(mensaje, textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
