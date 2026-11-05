import 'package:app_tutorias/main.dart';
import 'package:app_tutorias/repositories/mock/mock_auth_repository.dart';
import 'package:app_tutorias/repositories/mock/mock_solicitudes_repository.dart';
import 'package:app_tutorias/repositories/mock/mock_tutores_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

AppTutorias _app() {
  return AppTutorias(
    authRepository: MockAuthRepository(),
    tutoresRepository: MockTutoresRepository(),
    solicitudesRepository: MockSolicitudesRepository(),
  );
}

Future<void> _irAlLogin(WidgetTester tester, {required String rol}) async {
  await tester.pumpWidget(_app());
  await tester.pump(const Duration(milliseconds: 1600));
  await tester.pumpAndSettle();
  await tester.tap(find.text(rol));
  await tester.pumpAndSettle();
}

/// Frame de iPhone 13/14: el mismo de los diseños de Figma.
void _tamanoTelefono(WidgetTester tester) {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Future<void> _entrar(WidgetTester tester, {required String rol}) async {
  await _irAlLogin(tester, rol: rol);
  await tester.tap(find.text('Iniciar sesión'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('el flujo de solicitud funciona a 390x844', (tester) async {
    _tamanoTelefono(tester);

    await _entrar(tester, rol: 'Alumno');

    await tester.tap(find.text('Ana Martínez'));
    await tester.pumpAndSettle();
    expect(find.text('Perfil del tutor'), findsOneWidget);
    expect(find.text('Sobre el tutor'), findsOneWidget);

    await tester.tap(find.text('Solicitar tutoría'));
    await tester.pumpAndSettle();
    expect(find.text('Enviar solicitud'), findsOneWidget);

    // Validación con el formulario vacío.
    await tester.tap(find.text('Enviar solicitud'));
    await tester.pumpAndSettle();
    expect(find.text('Selecciona una materia.'), findsOneWidget);
    expect(find.text('Selecciona un horario.'), findsOneWidget);
    expect(find.text('El mensaje es obligatorio.'), findsOneWidget);

    await tester.tap(find.text('Matemáticas').first);
    await tester.tap(find.text('Lun 08:00 - 10:00'));
    await tester.enterText(
      find.byType(TextField).last,
      'Necesito repasar derivadas antes del examen parcial.',
    );
    await tester.pump();

    await tester.tap(find.text('Enviar solicitud'));
    await tester.pumpAndSettle();

    expect(find.text('Mis solicitudes'), findsOneWidget);
    expect(find.text('Hola, Ana'), findsOneWidget);
    expect(find.text('Pendiente'), findsWidgets);
  });

  testWidgets('el tutor puede aceptar una solicitud a 390x844', (tester) async {
    _tamanoTelefono(tester);

    await _entrar(tester, rol: 'Tutor');

    expect(find.text('Solicitudes recibidas'), findsOneWidget);
    expect(find.text('Aceptar'), findsNWidgets(2));

    await tester.tap(find.text('Aceptar').first);
    await tester.pumpAndSettle();

    expect(find.text('Solicitud aceptada.'), findsOneWidget);
    expect(find.text('Aceptada'), findsOneWidget);

    await tester.tap(find.text('Aceptadas'));
    await tester.pumpAndSettle();
    expect(find.text('Física'), findsOneWidget);
  });

  testWidgets('el alumno puede salir desde el catálogo y desde su panel', (
    tester,
  ) async {
    _tamanoTelefono(tester);

    await _entrar(tester, rol: 'Alumno');

    // Salida desde la barra del catálogo.
    await tester.tap(find.text('Salir'));
    await tester.pumpAndSettle();
    expect(find.text('¿Cómo quieres entrar?'), findsOneWidget);
    expect(find.text('TutoPar · Etapa 1 (MVP local)'), findsOneWidget);

    // Salida desde la barra del panel de solicitudes.
    await _entrar(tester, rol: 'Alumno');
    await tester.tap(find.text('Solicitudes'));
    await tester.pumpAndSettle();
    expect(find.text('Mis solicitudes'), findsOneWidget);

    await tester.tap(
      find.descendant(of: find.byType(AppBar), matching: find.text('Salir')),
    );
    await tester.pumpAndSettle();
    expect(find.text('¿Cómo quieres entrar?'), findsOneWidget);
  });

  testWidgets('el tutor puede salir desde su panel', (tester) async {
    _tamanoTelefono(tester);

    await _entrar(tester, rol: 'Tutor');
    expect(find.text('Solicitudes recibidas'), findsOneWidget);

    await tester.tap(find.text('Salir').first);
    await tester.pumpAndSettle();

    expect(find.text('¿Cómo quieres entrar?'), findsOneWidget);
  });
}
