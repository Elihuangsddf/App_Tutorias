// Importa package:flutter/material.dart para utilizar sus componentes y clases.
import 'package:flutter/material.dart';
// Importa package:provider/provider.dart para utilizar sus componentes y clases.
import 'package:provider/provider.dart';
// Importa controladorSesion.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/providers/controladorSesion.dart';
// Importa modeloUsuario.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/models/modeloUsuario.dart';
// Importa pantallaInicioSesion.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/features/auth/pantallaInicioSesion.dart';
// Importa pantallaBienvenida.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/features/auth/pantallaBienvenida.dart';
// Importa pantallaSolicitudes.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/features/solicitudes/pantallaSolicitudes.dart';
// Importa pantallaNuevaSolicitud.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/features/solicitudes/pantallaNuevaSolicitud.dart';
// Importa pantallaCatalogoTutores.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/features/tutores/pantallaCatalogoTutores.dart';
// Importa pantallaDetalleTutor.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/features/tutores/pantallaDetalleTutor.dart';
// Importa pantallaAdministrador.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/features/admin/pantallaAdministrador.dart';

// Define AppRoutes y los datos o acciones que contiene.
class AppRoutes {
  // Crea un objeto AppRoutes con los valores indicados.
  const AppRoutes._();

  // Prepara bienvenida.
  static const String bienvenida = '/';
  // Prepara inicio sesion.
  static const String inicioSesion = '/login';
  // Prepara catalogo.
  static const String catalogo = '/catalogo';
  // Prepara detalle tutor.
  static const String detalleTutor = '/detalle-tutor';
  // Prepara solicitud.
  static const String solicitud = '/solicitud';
  // Prepara panel solicitudes.
  static const String panelSolicitudes = '/panel-solicitudes';
  // Prepara administrador.
  static const String administrador = '/administrador';

  // Obtiene la ruta inicial del alumno, tutor o administrador.
  static String inicioPorRol(Rol rol) {
    // Comprueba (rol == Rol.alumno) antes de ejecutar el bloque.
    if (rol == Rol.alumno) {
      // Devuelve catalogo como resultado de la función.
      return catalogo;
      // Cierra el bloque de instrucciones o la definición.
    }
    // Comprueba (rol == Rol.tutor) antes de ejecutar el bloque.
    if (rol == Rol.tutor) {
      // Devuelve panelSolicitudes como resultado de la función.
      return panelSolicitudes;
      // Cierra el bloque de instrucciones o la definición.
    }
    // Devuelve administrador como resultado de la función.
    return administrador;
    // Cierra el bloque de instrucciones o la definición.
  }

  // Selecciona la pantalla y los roles que pueden visitarla.
  static Route<dynamic> generarRuta(RouteSettings configuracionRuta) {
    // Completa la operación utilizando Widget pantalla.
    Widget pantalla;
    // Prepara los roles que pueden abrir la ruta.
    List<Rol> rolesPermitidos = [];
    // Selecciona el caso que corresponde al nombre de ruta solicitado.
    switch (configuracionRuta.name) {
      // Atiende la ruta bienvenida.
      case bienvenida:
        // Actualiza el contenido protegido por los permisos de la ruta con el valor indicado.
        pantalla = const SplashScreen();
        // Termina este caso o recorrido y continúa después de él.
        break;
      // Atiende la ruta inicioSesion.
      case inicioSesion:
        // Actualiza el contenido protegido por los permisos de la ruta con el valor indicado.
        pantalla = const LoginScreen();
        // Termina este caso o recorrido y continúa después de él.
        break;
      // Atiende la ruta catalogo.
      case catalogo:
        // Actualiza el contenido protegido por los permisos de la ruta con el valor indicado.
        pantalla = const CatalogoTutoresScreen();
        // Actualiza los roles que pueden abrir la ruta con el valor indicado.
        rolesPermitidos = [Rol.alumno];
        // Termina este caso o recorrido y continúa después de él.
        break;
      // Atiende la ruta panelSolicitudes.
      case panelSolicitudes:
        // Actualiza el contenido protegido por los permisos de la ruta con el valor indicado.
        pantalla = const PanelSolicitudesScreen();
        // Actualiza los roles que pueden abrir la ruta con el valor indicado.
        rolesPermitidos = [Rol.alumno, Rol.tutor];
        // Termina este caso o recorrido y continúa después de él.
        break;
      // Atiende la ruta administrador.
      case administrador:
        // Actualiza el contenido protegido por los permisos de la ruta con el valor indicado.
        pantalla = const PantallaAdministrador();
        // Actualiza los roles que pueden abrir la ruta con el valor indicado.
        rolesPermitidos = [Rol.administrador];
        // Termina este caso o recorrido y continúa después de él.
        break;
      // Atiende la ruta detalleTutor.
      case detalleTutor:
      // Atiende la ruta solicitud.
      case solicitud:
        // Prepara id tutor.
        final idTutor = configuracionRuta.arguments;
        // Comprueba (idTutor is! String || idTutor.isEmpty) antes de ejecutar el bloque.
        if (idTutor is! String || idTutor.isEmpty) {
          // Devuelve _rutaInvalida( como resultado de la función.
          return _rutaInvalida(
            // Completa la operación utilizando configuracionRuta.
            configuracionRuta,
            // Aporta el texto indicado a la operación actual.
            'Falta el identificador del tutor.',
            // Cierra los argumentos de la operación actual.
          );
          // Cierra el bloque de instrucciones o la definición.
        }
        // Comprueba (configuracionRuta.name == detalleTutor) antes de ejecutar el bloque.
        if (configuracionRuta.name == detalleTutor) {
          // Actualiza el contenido protegido por los permisos de la ruta con el valor indicado.
          pantalla = DetalleTutorScreen(idTutor: idTutor);
          // Ejecuta esta alternativa cuando la condición anterior no se cumplió.
        } else {
          // Actualiza el contenido protegido por los permisos de la ruta con el valor indicado.
          pantalla = SolicitudFormScreen(idTutor: idTutor);
          // Cierra el bloque de instrucciones o la definición.
        }
        // Actualiza los roles que pueden abrir la ruta con el valor indicado.
        rolesPermitidos = [Rol.alumno];
        // Termina este caso o recorrido y continúa después de él.
        break;
      // Atiende una ruta que no está definida en la aplicación.
      default:
        // Devuelve _rutaInvalida( como resultado de la función.
        return _rutaInvalida(
          // Completa la operación utilizando configuracionRuta.
          configuracionRuta,
          // Aporta el texto indicado a la operación actual.
          'La ruta solicitada no existe.',
          // Cierra los argumentos de la operación actual.
        );
      // Cierra el bloque de instrucciones o la definición.
    }
    // Devuelve una ruta hacia una pantalla con la configuración siguiente.
    return MaterialPageRoute(
      // Configura los datos de navegación recibidos.
      settings: configuracionRuta,
      // Configura la función que construye la ruta.
      builder: (contexto) {
        // Comprueba (rolesPermitidos.isEmpty) antes de ejecutar el bloque.
        if (rolesPermitidos.isEmpty) {
          // Devuelve pantalla como resultado de la función.
          return pantalla;
          // Cierra el bloque de instrucciones o la definición.
        }
        // Devuelve _AccesoProtegido( como resultado de la función.
        return _AccesoProtegido(
          // Configura los roles que pueden abrir la ruta.
          rolesPermitidos: rolesPermitidos,
          // Configura el contenido protegido por los permisos de la ruta.
          pantalla: pantalla,
          // Cierra los argumentos de la operación actual.
        );
        // Cierra el bloque de instrucciones o la definición.
      },
      // Cierra los argumentos de la operación actual.
    );
    // Cierra el bloque de instrucciones o la definición.
  }

  // Muestra un mensaje si los datos de navegación no son válidos.
  static Route<dynamic> _rutaInvalida(
    // Recibe configuracion ruta con tipo RouteSettings.
    RouteSettings configuracionRuta,
    // Recibe el mensaje de error con tipo String.
    String mensaje,
    // Termina los parámetros o la condición y abre el bloque de instrucciones.
  ) {
    // Devuelve una ruta hacia una pantalla con la configuración siguiente.
    return MaterialPageRoute(
      // Configura los datos de navegación recibidos.
      settings: configuracionRuta,
      // Configura la función que construye la ruta.
      builder: (contexto) {
        // Devuelve la estructura de la pantalla con la configuración siguiente.
        return Scaffold(
          // Configura la barra superior.
          appBar: AppBar(title: const Text('Error de navegación')),
          // Configura el contenido principal.
          body: Center(child: Text(mensaje)),
          // Cierra los argumentos de la operación actual.
        );
        // Cierra el bloque de instrucciones o la definición.
      },
      // Cierra los argumentos de la operación actual.
    );
    // Cierra el bloque de instrucciones o la definición.
  }

  // Cierra el bloque de instrucciones o la definición.
}

// Esta protección visual se repetirá en el servidor al conectar PostgreSQL.
class _AccesoProtegido extends StatelessWidget {
  // Crea un objeto _AccesoProtegido con los valores indicados.
  const _AccesoProtegido({
    // Recibe los roles que pueden abrir la ruta al crear el objeto.
    required this.rolesPermitidos,
    // Recibe el contenido protegido por los permisos de la ruta al crear el objeto.
    required this.pantalla,
    // Cierra el bloque de instrucciones o la definición.
  });
  // Guarda los roles que pueden abrir la ruta.
  final List<Rol> rolesPermitidos;
  // Guarda el contenido protegido por los permisos de la ruta.
  final Widget pantalla;

  // Implementa un método definido por Flutter o por el contrato del repositorio.
  @override
  // Construye el contenido visual de esta pantalla.
  Widget build(BuildContext contexto) {
    // Prepara el controlador de la sesión.
    final sesion = contexto.watch<SesionProvider>();
    // Muestra el inicio de sesión cuando no hay una cuenta autenticada.
    if (!sesion.autenticado) {
      // Devuelve el formulario de inicio de sesión y registro con la configuración siguiente.
      return const LoginScreen();
      // Cierra el bloque de instrucciones o la definición.
    }
    // Bloquea la pantalla si el rol de la cuenta no está autorizado.
    if (!rolesPermitidos.contains(sesion.rol)) {
      // Devuelve la estructura de la pantalla con la configuración siguiente.
      return Scaffold(
        // Configura la barra superior.
        appBar: AppBar(title: const Text('Acceso no autorizado')),
        // Configura el contenido principal.
        body: Center(
          // Configura el contenido visual del componente.
          child: TextButton(
            // Configura la acción al tocar el botón.
            onPressed: () {
              // Abre el destino elegido y actualiza el historial de navegación.
              Navigator.of(contexto).pushNamedAndRemoveUntil(
                // Completa la operación utilizando AppRoutes.inicioPorRol(sesion.rol!).
                AppRoutes.inicioPorRol(sesion.rol!),
                // Define la función que se ejecuta con los argumentos indicados.
                (ruta) {
                  // Devuelve false para indicar el resultado de la operación.
                  return false;
                  // Cierra el bloque de instrucciones o la definición.
                },
                // Cierra los argumentos de la operación actual.
              );
              // Cierra el bloque de instrucciones o la definición.
            },
            // Configura el contenido visual del componente.
            child: const Text('Volver a mi inicio'),
            // Cierra los argumentos de la operación actual.
          ),
          // Cierra los argumentos de la operación actual.
        ),
        // Cierra los argumentos de la operación actual.
      );
      // Cierra el bloque de instrucciones o la definición.
    }
    // Devuelve pantalla como resultado de la función.
    return pantalla;
    // Cierra el bloque de instrucciones o la definición.
  }

  // Cierra el bloque de instrucciones o la definición.
}
