import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_tutorias/providers/controladorSesion.dart';
import 'package:app_tutorias/providers/controladorSolicitudes.dart';
import 'package:app_tutorias/main.dart';
import 'package:app_tutorias/models/modeloSolicitud.dart';
import 'package:app_tutorias/models/modeloUsuario.dart';
import 'package:app_tutorias/repositories/repositorioAutenticacion.dart';
import 'package:app_tutorias/repositories/repositorioSolicitudes.dart';
import 'package:app_tutorias/repositories/repositorioTutores.dart';
import 'package:app_tutorias/core/routes/rutasAplicacion.dart';

AppTutorias crearAplicacion() {
  return AppTutorias(
    repositorioAutenticacion: MockAuthRepository(),
    repositorioTutores: MockTutoresRepository(),
    repositorioSolicitudes: MockSolicitudesRepository(),
  );
}

Future<void> abrirLogin(WidgetTester probador) async {
  await probador.pumpWidget(crearAplicacion());
  await probador.pump(const Duration(milliseconds: 1600));
  await probador.pumpAndSettle();
}

void main() {
  test(
    'las credenciales determinan el usuario y el rol; el correo se normaliza',
    () async {
      final repositorio = MockAuthRepository();
      final usuario = await repositorio.iniciarSesion(
        '  ANA.TUTOR@TUTOPAR.LOCAL ',
        'Tutorias123!',
      );
      expect(usuario.id, 'tutor-1');
      expect(usuario.rol, Rol.tutor);
      expect(usuario.toMap().containsKey('contrasena'), isFalse);
      final segundoAlumno = await repositorio.iniciarSesion(
        'pedro.alumno@tutopar.local',
        'Tutorias123!',
      );
      expect(segundoAlumno.id, 'alumno-2');
    },
  );

  test('una contraseña incorrecta no abre una sesión', () async {
    final sesion = SesionProvider(MockAuthRepository());
    expect(
      await sesion.iniciarSesion('admin@tutopar.local', 'incorrecta'),
      isFalse,
    );
    expect(sesion.autenticado, isFalse);
    expect(sesion.error, 'Correo o contraseña incorrectos.');
    expect(sesion.cargando, isFalse);
    expect(await sesion.iniciarSesion('', ''), isFalse);
    expect(sesion.error, 'Escribe tu correo y contraseña.');
  });

  for (final rol in [Rol.alumno, Rol.tutor]) {
    test(
      'el registro de ${rol.etiqueta} permite entrar otra vez después de salir',
      () async {
        final repositorio = MockAuthRepository();
        final sesion = SesionProvider(repositorio);
        expect(
          await sesion.registrar(
            nombre: 'Cuenta nueva',
            correo: '  NUEVA@ESCUELA.LOCAL ',
            contrasena: 'Clave123!',
            rol: rol,
          ),
          isTrue,
        );
        final id = sesion.usuario!.id;
        expect(sesion.rol, rol);
        await sesion.cerrarSesion();
        expect(sesion.autenticado, isFalse);
        expect(
          await sesion.iniciarSesion('nueva@escuela.local', 'Clave123!'),
          isTrue,
        );
        expect(sesion.usuario!.id, id);
        expect(sesion.rol, rol);
      },
    );
  }

  test(
    'el registro rechaza administradores, duplicados y contraseñas cortas',
    () async {
      final repositorio = MockAuthRepository();
      await expectLater(
        repositorio.registrar(
          nombre: 'Cuenta admin',
          correo: 'nuevo@escuela.local',
          contrasena: 'Clave123!',
          rol: Rol.administrador,
        ),
        throwsA(isA<ErrorAutenticacion>()),
      );
      await expectLater(
        repositorio.registrar(
          nombre: 'Cuenta nueva',
          correo: 'ANA.ALUMNO@TUTOPAR.LOCAL',
          contrasena: 'Clave123!',
          rol: Rol.alumno,
        ),
        throwsA(isA<ErrorAutenticacion>()),
      );
      await expectLater(
        repositorio.registrar(
          nombre: 'Cuenta nueva',
          correo: 'nuevo@escuela.local',
          contrasena: '123',
          rol: Rol.alumno,
        ),
        throwsA(isA<ErrorAutenticacion>()),
      );
      await expectLater(
        repositorio.registrar(
          nombre: 'Cuenta nueva',
          correo: 'sin-correo',
          contrasena: 'Clave123!',
          rol: Rol.alumno,
        ),
        throwsA(isA<ErrorAutenticacion>()),
      );
    },
  );

  test(
    'un rol desconocido se rechaza en lugar de recibir permisos de alumno',
    () {
      expect(() {
        Rol.desdeValor('docente');
      }, throwsFormatException);
      expect(() {
        Rol.desdeValor(null);
      }, throwsFormatException);
    },
  );

  test(
    'un alumno no puede aceptar solicitudes y un tutor no modifica las ajenas',
    () async {
      final repositorio = MockAuthRepository();
      final sesion = SesionProvider(repositorio);
      final solicitudes = SolicitudesProvider(MockSolicitudesRepository());
      await sesion.iniciarSesion('ana.alumno@tutopar.local', 'Tutorias123!');
      solicitudes.actualizarSesion(sesion);
      await solicitudes.cargar();
      await solicitudes.aceptar('sol-1');
      expect(solicitudes.error, 'Solo un tutor puede responder solicitudes.');
      expect(
        solicitudes.solicitudes.firstWhere((solicitud) {
          return solicitud.id == 'sol-1';
        }).estado,
        EstadoSolicitud.pendiente,
      );
      await sesion.iniciarSesion('ana.tutor@tutopar.local', 'Tutorias123!');
      solicitudes.actualizarSesion(sesion);
      await solicitudes.cargar();
      await solicitudes.aceptar('sol-2');
      expect(
        solicitudes.error,
        'No puedes modificar una solicitud de otro tutor.',
      );
    },
  );

  testWidgets(
    'una cuenta administradora abre su propio panel y puede cerrar sesión',
    (probador) async {
      await abrirLogin(probador);
      await probador.enterText(
        find.byType(TextField).at(0),
        'admin@tutopar.local',
      );
      await probador.enterText(find.byType(TextField).at(1), 'Tutorias123!');
      await probador.tap(find.text('Iniciar sesión'));
      await probador.pumpAndSettle();
      expect(find.text('Panel de administración'), findsOneWidget);
      expect(find.text('Aceptar'), findsNothing);
      await probador.tap(find.text('Salir'));
      await probador.pumpAndSettle();
      expect(find.text('Bienvenido de nuevo'), findsOneWidget);
      expect(find.text('Panel de administración'), findsNothing);
    },
  );

  testWidgets(
    'el registro ofrece solo alumno y tutor y revisa la confirmación',
    (probador) async {
      await abrirLogin(probador);
      await probador.tap(find.text('Crear una cuenta'));
      await probador.pumpAndSettle();
      expect(find.text('Administrador'), findsNothing);
      await probador.ensureVisible(find.byType(DropdownButtonFormField<Rol>));
      await probador.tap(find.byType(DropdownButtonFormField<Rol>));
      await probador.pumpAndSettle();
      await probador.tap(find.text('Tutor').last);
      await probador.pumpAndSettle();
      await probador.enterText(find.byType(TextField).at(0), 'Tutor nuevo');
      await probador.enterText(
        find.byType(TextField).at(1),
        'nuevo@escuela.local',
      );
      await probador.enterText(find.byType(TextField).at(2), 'Clave123!');
      await probador.enterText(find.byType(TextField).at(3), 'OtraClave!');
      await probador.ensureVisible(find.text('Registrarme'));
      await probador.tap(find.text('Registrarme'));
      await probador.pumpAndSettle();
      expect(find.text('Las contraseñas no coinciden.'), findsOneWidget);
      await probador.enterText(find.byType(TextField).at(3), 'Clave123!');
      await probador.ensureVisible(find.text('Registrarme'));
      await probador.tap(find.text('Registrarme'));
      await probador.pumpAndSettle();
      expect(find.text('Solicitudes recibidas'), findsOneWidget);
      expect(find.text('No tienes solicitudes por ahora'), findsOneWidget);
    },
  );

  testWidgets('sin sesión una ruta protegida muestra el login', (
    probador,
  ) async {
    await abrirLogin(probador);
    final contexto = probador.element(find.text('Bienvenido de nuevo'));
    Navigator.of(contexto).pushNamed(AppRoutes.administrador);
    await probador.pumpAndSettle();
    expect(find.text('Panel de administración'), findsNothing);
    expect(find.text('Bienvenido de nuevo'), findsOneWidget);
  });

  testWidgets(
    'un alumno no entra al panel de administración por una ruta directa',
    (probador) async {
      await abrirLogin(probador);
      await probador.enterText(
        find.byType(TextField).at(0),
        'ana.alumno@tutopar.local',
      );
      await probador.enterText(find.byType(TextField).at(1), 'Tutorias123!');
      await probador.tap(find.text('Iniciar sesión'));
      await probador.pumpAndSettle();
      final contexto = probador.element(find.text('Ana Martínez'));
      Navigator.of(contexto).pushNamed(AppRoutes.administrador);
      await probador.pumpAndSettle();
      expect(find.text('Acceso no autorizado'), findsOneWidget);
      expect(find.text('Panel de administración'), findsNothing);
      await probador.tap(find.text('Volver a mi inicio'));
      await probador.pumpAndSettle();
      expect(find.text('6 tutores disponibles'), findsOneWidget);
    },
  );
}
