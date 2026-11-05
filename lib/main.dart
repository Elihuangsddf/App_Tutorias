// Importa los componentes visuales y estilos Material de Flutter.
import 'package:flutter/material.dart';
// Importa Provider para compartir y consultar el estado de la aplicación.
import 'package:provider/provider.dart';

// Importa rutasAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/routes/rutasAplicacion.dart';
// Importa temaAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/theme/temaAplicacion.dart';
// Importa constantesAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/utils/constantesAplicacion.dart';
// Importa controladorSesion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/providers/controladorSesion.dart';
// Importa controladorSolicitudes.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/providers/controladorSolicitudes.dart';
// Importa controladorTutores.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/providers/controladorTutores.dart';
// Importa repositorioAutenticacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/repositories/repositorioAutenticacion.dart';
// Importa repositorioSolicitudes.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/repositories/repositorioSolicitudes.dart';
// Importa repositorioTutores.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/repositories/repositorioTutores.dart';

// Inicia la aplicación y prepara los repositorios de datos de ejemplo.
void main() {
  // Etapa 1: usa cuentas locales y funciona sin servidor, red ni credenciales externas.
  final AuthRepository repositorioAutenticacion = MockAuthRepository();
  // Prepara el repositorio del catálogo sin permitir reasignarlo.
  final TutoresRepository repositorioTutores = MockTutoresRepository();
  // Prepara el repositorio de solicitudes sin permitir reasignarlo.
  final SolicitudesRepository repositorioSolicitudes =
      // Utiliza MockSolicitudesRepository con los argumentos indicados.
      MockSolicitudesRepository();

  // Utiliza runApp con los argumentos indicados.
  runApp(
    // Utiliza AppTutorias con los argumentos indicados.
    AppTutorias(
      // Establece el repositorio que inicia y cierra sesiones al valor indicado.
      repositorioAutenticacion: repositorioAutenticacion,
      // Establece el repositorio del catálogo al valor indicado.
      repositorioTutores: repositorioTutores,
      // Establece el repositorio de solicitudes al valor indicado.
      repositorioSolicitudes: repositorioSolicitudes,
      // Cierra la configuración de AppTutorias.
    ),
    // Cierra la configuración de runApp y termina la instrucción.
  );
  // Cierra el bloque de main.
}

/// Raíz de la aplicación: registra los Providers y la tabla de rutas.
// Define la clase que reúne la aplicación y el registro de sus controladores compartidos.
class AppTutorias extends StatelessWidget {
  // Define cómo se crea AppTutorias y qué datos recibe.
  const AppTutorias({
    // Entrega a Flutter la clave opcional que identifica este componente.
    super.key,
    // Solicita el repositorio que inicia y cierra sesiones.
    required this.repositorioAutenticacion,
    // Solicita el repositorio del catálogo.
    required this.repositorioTutores,
    // Solicita el repositorio de solicitudes.
    required this.repositorioSolicitudes,
    // Cierra el bloque de AppTutorias y termina la instrucción.
  });

  // Declara el repositorio que inicia y cierra sesiones sin permitir reasignarlo.
  final AuthRepository repositorioAutenticacion;
  // Declara el repositorio del catálogo sin permitir reasignarlo.
  final TutoresRepository repositorioTutores;
  // Declara el repositorio de solicitudes sin permitir reasignarlo.
  final SolicitudesRepository repositorioSolicitudes;

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Devuelve el registro de los controladores compartidos con la configuración siguiente.
    return MultiProvider(
      // Establece los controladores compartidos de la aplicación al valor indicado.
      providers: [
        // Crea un proveedor de estado que notifica cambios.
        ChangeNotifierProvider(
          // Define la función que crea el controlador compartido mediante una función.
          create: (_) {
            // Devuelve SesionProvider(repositorioAutenticacion) como resultado de esta función.
            return SesionProvider(repositorioAutenticacion);
            // Cierra el bloque de instrucciones.
          },
          // Cierra la configuración de ChangeNotifierProvider.
        ),
        // Crea un proveedor de estado que notifica cambios.
        ChangeNotifierProvider(
          // Define la función que crea el controlador compartido mediante una función.
          create: (_) {
            // Devuelve TutoresProvider(repositorioTutores) como resultado de esta función.
            // Comparte las cuentas del registro con el catálogo de alumnos.
            return TutoresProvider(
              // Mantiene la fuente actual de perfiles y filtros.
              repositorioTutores,
              // Añade las cuentas nuevas sin cambiar los datos de ejemplo.
              repositorioUsuarios: repositorioAutenticacion,
            );
            // Cierra el bloque de instrucciones.
          },
          // Cierra la configuración de ChangeNotifierProvider.
        ),
        // Crea un proveedor que depende de los cambios de sesión.
        ChangeNotifierProxyProvider<SesionProvider, SolicitudesProvider>(
          // Define la función que crea el controlador compartido mediante una función.
          create: (_) {
            // Devuelve SolicitudesProvider(repositorioSolicitudes) como resultado de esta función.
            return SolicitudesProvider(repositorioSolicitudes);
            // Cierra el bloque de instrucciones.
          },
          // Define la función que actualiza las solicitudes cuando cambia la sesión mediante una función.
          update: (contexto, sesion, solicitudes) {
            // Prepara el controlador de solicitudes sin permitir reasignarlo.
            final estadoSolicitudes =
                // Evalúa solicitudes ?? SolicitudesProvider(repositorioSolicitudes) como parte del resultado actual. Si el dato es null, usa la alternativa situada después de ??.
                solicitudes ?? SolicitudesProvider(repositorioSolicitudes);
            // Ejecuta actualizarSesion sobre estadoSolicitudes.
            estadoSolicitudes.actualizarSesion(sesion);
            // Devuelve estadoSolicitudes como resultado de esta función.
            return estadoSolicitudes;
            // Cierra el bloque de instrucciones.
          },
          // Cierra los argumentos.
        ),
        // Cierra la lista de elementos.
      ],
      // Establece el único componente visual contenido al valor indicado.
      child: MaterialApp(
        // Establece el título al valor indicado.
        title: AppConstants.nombreApp,
        // Establece si se muestra la banda de depuración al valor indicado.
        debugShowCheckedModeBanner: false,
        // Establece el tema visual de la aplicación al valor indicado.
        theme: AppTheme.claro,
        // Establece la pantalla inicial al valor indicado.
        initialRoute: AppRoutes.bienvenida,
        // Establece la función que resuelve las rutas al valor indicado.
        onGenerateRoute: AppRoutes.generarRuta,
        // Cierra la configuración de MaterialApp.
      ),
      // Cierra la configuración de MultiProvider y termina la instrucción.
    );
    // Cierra el bloque de build.
  }

  // Cierra la clase AppTutorias.
}
