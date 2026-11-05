import 'package:app_tutorias/main.dart';
import 'package:app_tutorias/repositories/mock/mock_auth_repository.dart';
import 'package:app_tutorias/repositories/mock/mock_solicitudes_repository.dart';
import 'package:app_tutorias/repositories/mock/mock_tutores_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('el esqueleto arranca y llega a la selección de rol', (
    tester,
  ) async {
    await tester.pumpWidget(
      AppTutorias(
        authRepository: MockAuthRepository(),
        tutoresRepository: MockTutoresRepository(),
        solicitudesRepository: MockSolicitudesRepository(),
      ),
    );

    expect(find.text('App Tutorías'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1600));
    await tester.pumpAndSettle();

    expect(find.text('Selección de rol'), findsOneWidget);
    expect(find.text('Entrar como alumno'), findsOneWidget);
    expect(find.text('Entrar como tutor'), findsOneWidget);
  });
}
