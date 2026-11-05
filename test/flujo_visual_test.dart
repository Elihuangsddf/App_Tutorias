import 'package:app_tutorias/main.dart';
import 'package:app_tutorias/repositories/repositorioAutenticacion.dart';
import 'package:app_tutorias/repositories/repositorioSolicitudes.dart';
import 'package:app_tutorias/repositories/repositorioTutores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

AppTutorias _crearAplicacion() {
  return AppTutorias(
    repositorioAutenticacion: MockAuthRepository(),
    repositorioTutores: MockTutoresRepository(),
    repositorioSolicitudes: MockSolicitudesRepository(),
  );
}

Future<void> _irAlLogin(WidgetTester probador, {required String rol}) async {
  await probador.pumpWidget(_crearAplicacion());
  await probador.pump(const Duration(milliseconds: 1600));
  await probador.pumpAndSettle();
  String correo = 'ana.alumno@tutopar.local';
  if (rol == 'Tutor') {
    correo = 'ana.tutor@tutopar.local';
  }
  await probador.enterText(find.byType(TextField).at(0), correo);
  await probador.enterText(find.byType(TextField).at(1), 'Tutorias123!');
}

/// Frame de iPhone 13/14: el mismo de los diseños de Figma.
void _tamanoTelefono(WidgetTester probador) {
  probador.view.physicalSize = const Size(390, 844);
  probador.view.devicePixelRatio = 1;
  addTearDown(probador.view.resetPhysicalSize);
  addTearDown(probador.view.resetDevicePixelRatio);
}

Future<void> _entrar(WidgetTester probador, {required String rol}) async {
  await _irAlLogin(probador, rol: rol);
  await probador.tap(find.text('Iniciar sesión'));
  await probador.pumpAndSettle();
}

void main() {
  testWidgets('el flujo de solicitud funciona a 390x844', (probador) async {
    _tamanoTelefono(probador);

    await _entrar(probador, rol: 'Alumno');

    await probador.tap(find.text('Ana Martínez'));
    await probador.pumpAndSettle();
    expect(find.text('Perfil del tutor'), findsOneWidget);
    expect(find.text('Sobre el tutor'), findsOneWidget);

    await probador.tap(find.text('Solicitar tutoría'));
    await probador.pumpAndSettle();
    expect(find.text('Enviar solicitud'), findsOneWidget);

    // Validación con el formulario vacío.
    await probador.tap(find.text('Enviar solicitud'));
    await probador.pumpAndSettle();
    expect(find.text('Selecciona una materia.'), findsOneWidget);
    expect(find.text('Selecciona un horario.'), findsOneWidget);
    expect(find.text('El mensaje es obligatorio.'), findsOneWidget);

    await probador.tap(find.text('Matemáticas').first);
    await probador.tap(find.text('Lun 08:00 - 10:00'));

    // Al escribir y al enviar se valida el mensaje sin contar espacios externos.
    await probador.enterText(find.byType(TextField).last, ' 123456789 ');
    await probador.pump();
    expect(
      find.text('El mensaje debe tener al menos 10 caracteres.'),
      findsOneWidget,
    );
    await probador.tap(find.text('Enviar solicitud'));
    await probador.pumpAndSettle();
    expect(
      find.text('El mensaje debe tener al menos 10 caracteres.'),
      findsOneWidget,
    );

    // Diez caracteres válidos eliminan el error mientras se edita.
    await probador.enterText(find.byType(TextField).last, ' 1234567890 ');
    await probador.pump();
    expect(
      find.text('El mensaje debe tener al menos 10 caracteres.'),
      findsNothing,
    );
    await probador.enterText(
      find.byType(TextField).last,
      'Necesito repasar derivadas antes del examen parcial.',
    );
    await probador.pump();

    await probador.tap(find.text('Enviar solicitud'));
    await probador.pumpAndSettle();

    expect(find.text('Mis solicitudes'), findsOneWidget);
    expect(find.text('Hola, Ana'), findsOneWidget);
    expect(find.text('Pendiente'), findsWidgets);
  });

  testWidgets('el tutor puede aceptar una solicitud a 390x844', (
    probador,
  ) async {
    _tamanoTelefono(probador);

    await _entrar(probador, rol: 'Tutor');

    expect(find.text('Solicitudes recibidas'), findsOneWidget);
    expect(find.text('Aceptar'), findsNWidgets(2));

    await probador.tap(find.text('Aceptar').first);
    await probador.pumpAndSettle();

    expect(find.text('Solicitud aceptada.'), findsOneWidget);
    expect(find.text('Aceptada'), findsOneWidget);

    await probador.tap(find.text('Aceptadas'));
    await probador.pumpAndSettle();
    expect(find.text('Física'), findsOneWidget);
  });

  testWidgets('el alumno puede salir desde el catálogo y desde su panel', (
    probador,
  ) async {
    _tamanoTelefono(probador);

    await _entrar(probador, rol: 'Alumno');

    // Salida desde la barra del catálogo.
    await probador.tap(find.text('Salir'));
    await probador.pumpAndSettle();
    expect(find.text('Bienvenido de nuevo'), findsOneWidget);

    // Salida desde la barra del panel de solicitudes.
    await _entrar(probador, rol: 'Alumno');
    await probador.tap(find.text('Solicitudes'));
    await probador.pumpAndSettle();
    expect(find.text('Mis solicitudes'), findsOneWidget);

    await probador.tap(
      find.descendant(of: find.byType(AppBar), matching: find.text('Salir')),
    );
    await probador.pumpAndSettle();
    expect(find.text('Bienvenido de nuevo'), findsOneWidget);
  });

  testWidgets('el tutor puede salir desde su panel', (probador) async {
    _tamanoTelefono(probador);

    await _entrar(probador, rol: 'Tutor');
    expect(find.text('Solicitudes recibidas'), findsOneWidget);

    await probador.tap(find.text('Salir').first);
    await probador.pumpAndSettle();

    expect(find.text('Bienvenido de nuevo'), findsOneWidget);
  });
}
