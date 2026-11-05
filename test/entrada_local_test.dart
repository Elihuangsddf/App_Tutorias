import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_tutorias/main.dart' as aplicacion;

void main() {
  testWidgets(
    'la entrada real carga el asset e inicia sesión sin base externa',
    (probador) async {
      aplicacion.main();
      await probador.pump();
      expect(find.byType(Image), findsOneWidget);
      expect(probador.takeException(), isNull);
      await probador.pump(const Duration(milliseconds: 1600));
      await probador.pumpAndSettle();
      await probador.enterText(
        find.byType(TextField).at(0),
        'ana.alumno@tutopar.local',
      );
      await probador.enterText(find.byType(TextField).at(1), 'Tutorias123!');
      await probador.tap(find.text('Iniciar sesión'));
      await probador.pumpAndSettle();
      expect(find.text('6 tutores disponibles'), findsOneWidget);
      expect(probador.takeException(), isNull);
    },
  );
}
