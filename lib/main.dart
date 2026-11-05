import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/constants.dart';
import 'providers/sesion_provider.dart';
import 'providers/solicitudes_provider.dart';
import 'providers/tutores_provider.dart';
import 'repositories/auth_repository.dart';
import 'repositories/mock/mock_auth_repository.dart';
import 'repositories/mock/mock_solicitudes_repository.dart';
import 'repositories/mock/mock_tutores_repository.dart';
import 'repositories/solicitudes_repository.dart';
import 'repositories/tutores_repository.dart';

void main() {
  // Este es el único lugar donde se decide qué implementación se usa.
  // En la Etapa 2 basta con cambiar estas tres líneas por las de Firebase.
  final AuthRepository authRepository = MockAuthRepository();
  final TutoresRepository tutoresRepository = MockTutoresRepository();
  final SolicitudesRepository solicitudesRepository =
      MockSolicitudesRepository();

  runApp(
    AppTutorias(
      authRepository: authRepository,
      tutoresRepository: tutoresRepository,
      solicitudesRepository: solicitudesRepository,
    ),
  );
}

/// Raíz de la aplicación: registra los Providers y la tabla de rutas.
class AppTutorias extends StatelessWidget {
  const AppTutorias({
    super.key,
    required this.authRepository,
    required this.tutoresRepository,
    required this.solicitudesRepository,
  });

  final AuthRepository authRepository;
  final TutoresRepository tutoresRepository;
  final SolicitudesRepository solicitudesRepository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SesionProvider(authRepository)),
        ChangeNotifierProvider(
          create: (_) => TutoresProvider(tutoresRepository),
        ),
        ChangeNotifierProxyProvider<SesionProvider, SolicitudesProvider>(
          create: (_) => SolicitudesProvider(solicitudesRepository),
          update: (_, sesion, solicitudes) =>
              solicitudes!..actualizarSesion(sesion),
        ),
      ],
      child: MaterialApp(
        title: AppConstants.nombreApp,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRoutes.generarRuta,
      ),
    );
  }
}
