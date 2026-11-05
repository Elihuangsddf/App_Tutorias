import 'package:app_tutorias/main.dart';
import 'package:app_tutorias/repositories/repositorioAutenticacion.dart';
import 'package:app_tutorias/repositories/repositorioSolicitudes.dart';
import 'package:app_tutorias/repositories/repositorioTutores.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

AppTutorias _crearAplicacion() {
  return AppTutorias(
    repositorioAutenticacion: MockAuthRepository(),
    repositorioTutores: MockTutoresRepository(),
    repositorioSolicitudes: MockSolicitudesRepository(),
  );
}

void main() {
  testWidgets('flujo alumno: credenciales y catálogo', (probador) async {
    await probador.pumpWidget(_crearAplicacion());

    expect(find.text('TutoPar'), findsOneWidget);

    await probador.pump(const Duration(milliseconds: 1600));
    await probador.pumpAndSettle();

    expect(find.text('Bienvenido de nuevo'), findsOneWidget);
    await probador.enterText(
      find.byType(TextField).at(0),
      'ana.alumno@tutopar.local',
    );
    await probador.enterText(find.byType(TextField).at(1), 'admin1234');

    await probador.tap(find.text('Iniciar sesión'));
    await probador.pumpAndSettle();

    expect(find.text('Tutores'), findsNWidgets(2));
    expect(find.text('6 tutores disponibles'), findsOneWidget);
    expect(find.text('Ana Martínez'), findsOneWidget);
    expect(find.text('Luis Hernández'), findsOneWidget);
  });

  testWidgets('flujo tutor: login y panel de solicitudes recibidas', (
    probador,
  ) async {
    await probador.pumpWidget(_crearAplicacion());
    await probador.pump(const Duration(milliseconds: 1600));
    await probador.pumpAndSettle();

    await probador.enterText(
      find.byType(TextField).at(0),
      'ana.tutor@tutopar.local',
    );
    await probador.enterText(find.byType(TextField).at(1), 'admin1234');

    await probador.tap(find.text('Iniciar sesión'));
    await probador.pumpAndSettle();

    expect(find.text('Solicitudes recibidas'), findsOneWidget);
    expect(find.text('Hola, Ana'), findsOneWidget);
    expect(find.text('Física'), findsOneWidget);
    expect(find.text('Matemáticas'), findsOneWidget);
  });
}
