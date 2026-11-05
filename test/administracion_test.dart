// Comprueba la administración real y su efecto sobre autenticación y catálogo.
import 'package:flutter_test/flutter_test.dart';
import 'package:app_tutorias/models/modeloUsuario.dart';
import 'package:app_tutorias/models/modeloTutor.dart';
import 'package:app_tutorias/providers/controladorSesion.dart';
import 'package:app_tutorias/providers/controladorTutores.dart';
import 'package:app_tutorias/repositories/repositorioAutenticacion.dart';
import 'package:app_tutorias/repositories/repositorioTutores.dart';

void main() {
  test(
    'el administrador crea, modifica y borra un tutor sin perder la contraseña',
    () async {
      final cuentas = MockAuthRepository();
      final sesion = SesionProvider(cuentas);
      final catalogo = TutoresProvider(
        MockTutoresRepository(),
        repositorioUsuarios: cuentas,
      );
      addTearDown(sesion.dispose);
      addTearDown(catalogo.dispose);
      const usuario = Usuario(
        id: 'prueba-admin',
        nombre: 'Tutor de prueba',
        correo: 'prueba@escuela.local',
        rol: Rol.tutor,
      );
      // Usa un perfil distinto en cada edición para comprobar la sustitución completa.
      Tutor perfil(String materia, double puntuacion) => Tutor(
        id: usuario.id,
        nombre: usuario.nombre,
        materias: [materia],
        horariosDisponibles: ['Lunes 08:00 - 10:00'],
        calificacion: puntuacion,
        descripcion: 'Apoyo académico',
        foto: '',
      );
      // Impide modificar datos antes de iniciar una sesión administrativa.
      await expectLater(
        sesion.guardarCuenta(usuario, 'Clave123!', perfil('Física', 4)),
        throwsA(isA<ErrorAutenticacion>()),
      );
      await sesion.iniciarSesion('admin@tutopar.local', 'admin1234');
      await sesion.guardarCuenta(usuario, 'Clave123!', perfil('Física', 4));
      await catalogo.cargarTutores();
      expect(catalogo.tutorPorId(usuario.id)?.materias, ['Física']);
      // Una puntuación inválida se rechaza sin alterar el perfil existente.
      await expectLater(
        sesion.guardarCuenta(usuario, '', perfil('Química', 6)),
        throwsA(isA<ErrorAutenticacion>()),
      );
      await sesion.guardarCuenta(usuario, '', perfil('Química', 4.5));
      await catalogo.cargarTutores();
      expect(catalogo.tutorPorId(usuario.id)?.materias, ['Química']);
      expect(catalogo.tutorPorId(usuario.id)?.calificacion, 4.5);
      expect(
        (await cuentas.iniciarSesion(usuario.correo, 'Clave123!')).id,
        usuario.id,
      );
      await sesion.borrarCuenta(usuario.id);
      await catalogo.cargarTutores();
      expect(catalogo.tutorPorId(usuario.id), isNull);
      await expectLater(
        cuentas.iniciarSesion(usuario.correo, 'Clave123!'),
        throwsA(isA<ErrorAutenticacion>()),
      );
      // La cuenta administrativa permanece protegida.
      await expectLater(
        sesion.borrarCuenta('admin-1'),
        throwsA(isA<ErrorAutenticacion>()),
      );
    },
  );

  test(
    'el administrador gestiona alumnos y elimina perfiles de ejemplo',
    () async {
      final cuentas = MockAuthRepository();
      final sesion = SesionProvider(cuentas);
      final catalogo = TutoresProvider(
        MockTutoresRepository(),
        repositorioUsuarios: cuentas,
      );
      addTearDown(sesion.dispose);
      addTearDown(catalogo.dispose);
      await sesion.iniciarSesion('admin@tutopar.local', 'admin1234');
      const alumno = Usuario(
        id: 'alumno-admin',
        nombre: 'Alumno nuevo',
        correo: 'alumno.nuevo@escuela.local',
        rol: Rol.alumno,
      );
      await sesion.guardarCuenta(alumno, 'Clave123!', null);
      await sesion.guardarCuenta(
        Usuario(
          id: alumno.id,
          nombre: 'Alumno editado',
          correo: alumno.correo,
          rol: Rol.alumno,
        ),
        '',
        null,
      );
      expect(
        (await cuentas.iniciarSesion(alumno.correo, 'Clave123!')).nombre,
        'Alumno editado',
      );
      await sesion.borrarCuenta(alumno.id);
      expect(
        (await cuentas.obtenerUsuarios()).any(
          (usuario) => usuario.id == alumno.id,
        ),
        isFalse,
      );
      // El tutor de demostración no debe reaparecer al recargar el catálogo.
      await sesion.borrarCuenta('tutor-2');
      await catalogo.cargarTutores();
      expect(catalogo.tutorPorId('tutor-2'), isNull);
    },
  );
}
