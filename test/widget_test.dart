import 'package:app_tutorias/main.dart';
import 'package:app_tutorias/repositories/mock/mock_auth_repository.dart';
import 'package:app_tutorias/repositories/mock/mock_solicitudes_repository.dart';
import 'package:app_tutorias/repositories/mock/mock_tutores_repository.dart';
import 'package:flutter_test/flutter_test.dart';

AppTutorias _app() {
  return AppTutorias(
    authRepository: MockAuthRepository(),
    tutoresRepository: MockTutoresRepository(),
    solicitudesRepository: MockSolicitudesRepository(),
  );
}

void main() {
  testWidgets('flujo alumno: splash, rol, login y catálogo', (tester) async {
    await tester.pumpWidget(_app());

    expect(find.text('TutoPar'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1600));
    await tester.pumpAndSettle();

    expect(find.text('¿Cómo quieres entrar?'), findsOneWidget);
    expect(find.text('Alumno'), findsOneWidget);
    expect(find.text('Tutor'), findsOneWidget);

    await tester.tap(find.text('Alumno'));
    await tester.pumpAndSettle();

    expect(find.text('Bienvenido de nuevo'), findsOneWidget);
    expect(find.text('Acceso como Alumno'), findsOneWidget);

    await tester.tap(find.text('Iniciar sesión'));
    await tester.pumpAndSettle();

    expect(find.text('Tutores'), findsNWidgets(2));
    expect(find.text('6 tutores disponibles'), findsOneWidget);
    expect(find.text('Ana Martínez'), findsOneWidget);
    expect(find.text('Luis Hernández'), findsOneWidget);
  });

  testWidgets('flujo tutor: login y panel de solicitudes recibidas', (
    tester,
  ) async {
    await tester.pumpWidget(_app());
    await tester.pump(const Duration(milliseconds: 1600));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Tutor'));
    await tester.pumpAndSettle();

    expect(find.text('Acceso como Tutor'), findsOneWidget);

    await tester.tap(find.text('Iniciar sesión'));
    await tester.pumpAndSettle();

    expect(find.text('Solicitudes recibidas'), findsOneWidget);
    expect(find.text('Hola, Ana'), findsOneWidget);
    expect(find.text('Física'), findsOneWidget);
    expect(find.text('Matemáticas'), findsOneWidget);
  });
}
