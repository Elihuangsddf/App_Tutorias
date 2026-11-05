// Utiliza widgets reales para comprobar el cambio entre las cuentas.
import 'package:flutter/material.dart';
// Permite interactuar con la aplicación y verificar los resultados.
import 'package:flutter_test/flutter_test.dart';
// Construye la misma aplicación utilizada por el punto de entrada.
import 'package:app_tutorias/main.dart';
// Identifica los roles de las cuentas registradas.
import 'package:app_tutorias/models/modeloUsuario.dart';
// Comprueba el control de acceso al directorio administrativo.
import 'package:app_tutorias/providers/controladorSesion.dart';
// Verifica el catálogo conectado a las cuentas locales.
import 'package:app_tutorias/providers/controladorTutores.dart';
// Utiliza el registro local real, sin simular el resultado del alta.
import 'package:app_tutorias/repositories/repositorioAutenticacion.dart';
// Mantiene la fuente de solicitudes existente.
import 'package:app_tutorias/repositories/repositorioSolicitudes.dart';
// Mantiene los perfiles de ejemplo del catálogo.
import 'package:app_tutorias/repositories/repositorioTutores.dart';

// Inicia sesión desde el formulario real de la aplicación.
Future<void> entrar(WidgetTester probador, String correo) async {
  // Introduce el correo de la cuenta elegida.
  await probador.enterText(find.byType(TextField).at(0), correo);
  // Conserva la contraseña de demostración configurada en el proyecto.
  await probador.enterText(find.byType(TextField).at(1), 'admin1234');
  // Envía el formulario de acceso.
  await probador.tap(find.text('Iniciar sesión'));
  // Espera a que terminen la autenticación, la navegación y la carga.
  await probador.pumpAndSettle();
}

// Comprueba los dos fallos reportados y los permisos del directorio.
void main() {
  // Garantiza que el registro no reemplace perfiles ni publique otros roles.
  test(
    'el catálogo incorpora tutores sin duplicar perfiles ni publicar alumnos',
    () async {
      // Comparte una sola fuente de cuentas con el catálogo.
      final cuentas = MockAuthRepository();
      // Crea el controlador con las mismas dependencias del arranque real.
      final catalogo = TutoresProvider(
        MockTutoresRepository(),
        repositorioUsuarios: cuentas,
      );
      // Libera el controlador al terminar la prueba.
      addTearDown(catalogo.dispose);
      // Carga el catálogo antes del registro para reproducir la información almacenada.
      await catalogo.cargarTutores();
      // Conserva la cantidad de perfiles completos de ejemplo.
      expect(catalogo.tutores.length, 6);
      // Registra una cuenta de tutor con el repositorio real.
      final tutor = await cuentas.registrar(
        nombre: 'Tutor nuevo',
        correo: 'nuevo@escuela.local',
        contrasena: 'Clave123!',
        rol: Rol.tutor,
      );
      // Registra también un alumno que no debe aparecer como tutor.
      final alumno = await cuentas.registrar(
        nombre: 'Alumno nuevo',
        correo: 'alumno@escuela.local',
        contrasena: 'Clave123!',
        rol: Rol.alumno,
      );
      // Actualiza el catálogo para recoger las cuentas recién creadas.
      await catalogo.cargarTutores();
      // El nuevo tutor aparece una sola vez junto a los perfiles existentes.
      expect(catalogo.tutores.length, 7);
      // El identificador del perfil coincide con la cuenta que recibirá solicitudes.
      expect(catalogo.tutorPorId(tutor.id)?.nombre, 'Tutor nuevo');
      // El alumno no obtiene un perfil de tutor.
      expect(catalogo.tutorPorId(alumno.id), isNull);
      // El perfil completo de ejemplo conserva sus materias originales.
      expect(catalogo.tutorPorId('tutor-1')?.materias, [
        'Matemáticas',
        'Física',
      ]);
      // Otra recarga no duplica al tutor nuevo.
      await catalogo.cargarTutores();
      // Conserva exactamente los siete perfiles esperados.
      expect(catalogo.tutores.length, 7);
      // La búsqueda encuentra al tutor registrado.
      catalogo.actualizarBusqueda('TUTOR NUEVO');
      // Encuentra el perfil por el identificador de su cuenta.
      expect(catalogo.resultados.single.id, tutor.id);
    },
  );

  // Verifica que el directorio no se entregue a sesiones sin permiso.
  test(
    'solo el administrador consulta cuentas y la lista no expone contraseñas',
    () async {
      // Utiliza las cuentas locales configuradas para la aplicación.
      final sesion = SesionProvider(MockAuthRepository());
      // Libera los recursos del controlador al terminar.
      addTearDown(sesion.dispose);
      // Rechaza la lectura cuando todavía no existe una sesión.
      await expectLater(
        sesion.obtenerUsuariosAdministracion(),
        throwsA(isA<ErrorAutenticacion>()),
      );
      // Autentica a un alumno con credenciales válidas.
      await sesion.iniciarSesion('ana.alumno@tutopar.local', 'admin1234');
      // Rechaza también al alumno aunque esté autenticado.
      await expectLater(
        sesion.obtenerUsuariosAdministracion(),
        throwsA(isA<ErrorAutenticacion>()),
      );
      // Autentica la cuenta administrativa existente.
      await sesion.iniciarSesion('admin@tutopar.local', 'admin1234');
      // Consulta el directorio con la sesión autorizada.
      final cuentas = await sesion.obtenerUsuariosAdministracion();
      // Recupera las cuatro cuentas reales de demostración.
      expect(cuentas.length, 9);
      // Los mapas públicos contienen únicamente los campos del usuario.
      expect(
        cuentas.first.toMap().keys,
        unorderedEquals(['id', 'nombre', 'correo', 'rol']),
      );
      // Impide que el consumidor modifique la lista del directorio.
      expect(() => cuentas.clear(), throwsUnsupportedError);
    },
  );

  // Reproduce el alta después de haber visitado el catálogo y revisa ambos roles.
  testWidgets(
    'un tutor registrado aparece al alumno y al administrador con catálogo previo',
    (probador) async {
      // Comprueba también que los nuevos componentes caben en un teléfono.
      probador.view.physicalSize = const Size(390, 844);
      // Usa píxeles lógicos equivalentes al tamaño establecido.
      probador.view.devicePixelRatio = 1;
      // Restaura el tamaño para las siguientes pruebas.
      addTearDown(probador.view.resetPhysicalSize);
      // Restaura la densidad al finalizar.
      addTearDown(probador.view.resetDevicePixelRatio);
      // Conserva los repositorios durante todos los cambios de cuenta.
      await probador.pumpWidget(
        AppTutorias(
          repositorioAutenticacion: MockAuthRepository(),
          repositorioTutores: MockTutoresRepository(),
          repositorioSolicitudes: MockSolicitudesRepository(),
        ),
      );
      // Espera a que termine la bienvenida.
      await probador.pump(const Duration(milliseconds: 1600));
      // Completa la navegación inicial.
      await probador.pumpAndSettle();
      // Abre el catálogo antes de que exista la cuenta nueva.
      await entrar(probador, 'ana.alumno@tutopar.local');
      // Confirma que se cargaron los seis perfiles originales.
      expect(find.text('6 tutores disponibles'), findsOneWidget);
      // Cierra la sesión del alumno para registrar al tutor.
      await probador.tap(
        find.descendant(of: find.byType(AppBar), matching: find.text('Salir')),
      );
      // Espera a que aparezca el acceso.
      await probador.pumpAndSettle();
      // Abre el formulario real de registro.
      await probador.tap(find.text('Crear una cuenta'));
      // Espera la transición al formulario.
      await probador.pumpAndSettle();
      // Desplaza el selector de rol dentro del área visible.
      await probador.ensureVisible(find.byType(DropdownButtonFormField<Rol>));
      // Abre las opciones de rol.
      await probador.tap(find.byType(DropdownButtonFormField<Rol>));
      // Espera el menú de selección.
      await probador.pumpAndSettle();
      // Selecciona una cuenta de tutor.
      await probador.tap(find.text('Tutor').last);
      // Cierra el menú antes de completar los datos.
      await probador.pumpAndSettle();
      // Introduce el nombre que después debe aparecer en ambas vistas.
      await probador.enterText(
        find.byType(TextField).at(0),
        'Tutor recién creado',
      );
      // Introduce un correo que no existe en las cuentas de demostración.
      await probador.enterText(
        find.byType(TextField).at(1),
        'nuevo@escuela.local',
      );
      // Introduce una contraseña válida para la nueva cuenta.
      await probador.enterText(find.byType(TextField).at(2), 'Clave123!');
      // Confirma la contraseña para superar la validación del formulario.
      await probador.enterText(find.byType(TextField).at(3), 'Clave123!');
      // Hace visible el botón de registro en la pantalla pequeña.
      await probador.enterText(
        find.byType(TextField).at(4),
        'Matemáticas, Física',
      );
      await probador.enterText(
        find.byType(TextField).at(5),
        'Lunes 08:00 - 10:00',
      );
      await probador.ensureVisible(find.text('Registrarme'));
      // Crea la cuenta desde la interfaz.
      await probador.tap(find.text('Registrarme'));
      // Espera el inicio automático de la sesión del tutor.
      await probador.pumpAndSettle();
      // Confirma que la nueva cuenta tiene acceso como tutor.
      expect(find.text('Solicitudes recibidas'), findsOneWidget);
      // Cierra la sesión para comprobar la vista del alumno.
      await probador.tap(
        find.descendant(of: find.byType(AppBar), matching: find.text('Salir')),
      );
      // Espera a que vuelva el acceso.
      await probador.pumpAndSettle();
      // Regresa a la misma cuenta de alumno que tenía el catálogo cargado.
      await entrar(probador, 'ana.alumno@tutopar.local');
      // Confirma que el catálogo ahora incluye al tutor registrado.
      expect(find.text('7 tutores disponibles'), findsOneWidget);
      // Busca el nombre para hacer visible su tarjeta.
      await probador.enterText(find.byType(TextField), 'Tutor recién creado');
      // Actualiza los resultados del filtro.
      await probador.pumpAndSettle();
      // Encuentra al tutor registrado en la vista del alumno.
      // Busca el texto del perfil sin confundirlo con el campo de búsqueda.
      final nombreTutor = find.byWidgetPredicate(
        // Exige un texto visible de la tarjeta, en lugar de un campo editable.
        (widget) => widget is Text && widget.data == 'Tutor recién creado',
      );
      // Comprueba que existe una sola tarjeta con el nombre registrado.
      expect(nombreTutor, findsOneWidget);
      // Abre su perfil para verificar que no ofrece datos inventados.
      await probador.tap(nombreTutor);
      // Espera a que aparezca el detalle.
      await probador.pumpAndSettle();
      // Explica que todavía faltan materias y horarios en el registro actual.
      expect(find.text('Solicitar tutoría'), findsOneWidget);
      // Regresa al catálogo para cambiar a la cuenta administrativa.
      await probador.tap(find.byTooltip('Volver'));
      // Completa el regreso al catálogo.
      await probador.pumpAndSettle();
      // Cierra la sesión del alumno.
      await probador.tap(
        find.descendant(of: find.byType(AppBar), matching: find.text('Salir')),
      );
      // Espera el formulario de acceso.
      await probador.pumpAndSettle();
      // Accede con la cuenta administrativa existente.
      await entrar(probador, 'admin@tutopar.local');
      // Cuenta las cuatro cuentas originales más el tutor registrado.
      expect(find.text('Cuentas registradas: 10'), findsOneWidget);
      // Hace visible la cuenta nueva dentro del listado administrativo.
      await probador.scrollUntilVisible(
        find.text('Tutor recién creado'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      // Confirma que el administrador ve también al tutor registrado.
      expect(find.text('Tutor recién creado'), findsOneWidget);
      // Comprueba que la interfaz no produjo errores durante todo el recorrido.
      expect(probador.takeException(), isNull);
    },
  );
}
