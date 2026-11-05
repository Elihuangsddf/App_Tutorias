import 'package:flutter_test/flutter_test.dart';
import 'package:app_tutorias/providers/controladorTutores.dart';
import 'package:app_tutorias/repositories/repositorioTutores.dart';

void main() {
  late TutoresProvider catalogo;

  setUp(() async {
    catalogo = TutoresProvider(MockTutoresRepository());
    await catalogo.cargarTutores();
  });

  tearDown(() {
    catalogo.dispose();
  });

  test('busca por nombre y por materia sin distinguir mayúsculas', () {
    catalogo.actualizarBusqueda('  ANA MARTÍNEZ  ');
    expect(catalogo.resultados.single.id, 'tutor-1');
    catalogo.actualizarBusqueda('BASES DE DATOS');
    expect(catalogo.resultados.single.id, 'tutor-2');
  });

  test('combina materia, calificación y día y permite quitar filtros', () {
    catalogo.filtrarPorMateria('Matemáticas');
    catalogo.filtrarPorCalificacion(4.8);
    catalogo.filtrarPorDia('Lunes');
    expect(catalogo.resultados.single.id, 'tutor-1');
    catalogo.filtrarPorDia('Viernes');
    expect(catalogo.resultados, isEmpty);
    catalogo.limpiarFiltros();
    expect(catalogo.resultados.length, 6);
    expect(catalogo.hayFiltros, isFalse);
    expect(catalogo.busqueda, isEmpty);
  });

  test('una búsqueda sin coincidencias no modifica el catálogo original', () {
    catalogo.actualizarBusqueda('materia que no existe');
    expect(catalogo.resultados, isEmpty);
    expect(catalogo.tutores.length, 6);
    expect(catalogo.error, isNull);
    catalogo.actualizarBusqueda('');
    expect(catalogo.resultados.length, 6);
  });
}
