// Importa los componentes visuales y estilos Material de Flutter.
import 'package:flutter/material.dart';
// Importa Provider para compartir y consultar el estado de la aplicación.
import 'package:provider/provider.dart';

// Importa rutasAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/routes/rutasAplicacion.dart';
// Importa temaAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/theme/temaAplicacion.dart';
// Importa mostrarAvisos.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/utils/mostrarAvisos.dart';
// Importa formatoTextos.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/utils/formatoTextos.dart';
// Importa barraNavegacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/barraNavegacion.dart';
// Importa avisoSinResultados.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/avisoSinResultados.dart';
// Importa botonesFiltro.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/botonesFiltro.dart';
// Importa botonCerrarSesion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/botonCerrarSesion.dart';
// Importa indicadoresCarga.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/indicadoresCarga.dart';
// Importa tarjetaSolicitud.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/tarjetaSolicitud.dart';
// Importa modeloSolicitud.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/models/modeloSolicitud.dart';
// Importa modeloUsuario.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/models/modeloUsuario.dart';
// Importa controladorSesion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/providers/controladorSesion.dart';
// Importa controladorSolicitudes.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/providers/controladorSolicitudes.dart';

// Define las opciones permitidas para el filtro del panel.
enum _FiltroPanel { todas, pendientes, aceptadas, rechazadas }

/// Panel de solicitudes: variante alumno (consulta) y tutor (acepta/rechaza).
// Define PanelSolicitudesScreen, que representa la pantalla de solicitudes.
class PanelSolicitudesScreen extends StatefulWidget {
  // Define cómo se crea PanelSolicitudesScreen y qué datos recibe.
  const PanelSolicitudesScreen({super.key});

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Crea el objeto que guardará el estado de esta pantalla.
  State<PanelSolicitudesScreen> createState() {
    // Devuelve _PanelSolicitudesScreenState() como resultado de esta función.
    return _PanelSolicitudesScreenState();
    // Cierra el bloque de createState.
  }

  // Cierra la clase PanelSolicitudesScreen.
}

// Guarda los datos y acciones que pueden cambiar en esta pantalla.
class _PanelSolicitudesScreenState extends State<PanelSolicitudesScreen> {
  // Permite consultar el contexto de Flutter de esta pantalla mediante una propiedad de lectura.
  BuildContext get contexto {
    // Entrega el contexto de Flutter asociado a esta pantalla.
    return context;
    // Cierra la propiedad contexto.
  }

  // Guarda el filtro actual del panel; inicialmente muestra todas las solicitudes.
  _FiltroPanel _filtro = _FiltroPanel.todas;
  // Declara el identificador de la solicitud en proceso. El signo ? del tipo permite que este dato sea null.
  String? _idEnProceso;
  // Declara la acción de solicitud que se está ejecutando. El signo ? del tipo permite que este dato sea null.
  EstadoSolicitud? _accionEnProceso;

  // Actualiza el estado de una solicitud.
  Future<void> _cambiarEstado(
    // Recibe la solicitud que se muestra con tipo Solicitud.
    Solicitud solicitud,
    // Recibe el estado de la solicitud con tipo EstadoSolicitud.
    EstadoSolicitud estado,
    // Termina los parámetros e inicia una función que puede esperar operaciones asíncronas.
  ) async {
    // Comprueba (_idEnProceso != null) return para decidir si se ejecuta esta parte.
    if (_idEnProceso != null) return;

    // Agrupa cambios locales y solicita a Flutter que vuelva a dibujar la pantalla.
    setState(() {
      // Actualiza _idEnProceso con solicitud.id.
      _idEnProceso = solicitud.id;
      // Actualiza _accionEnProceso con estado.
      _accionEnProceso = estado;
      // Cierra el bloque de setState y termina la instrucción.
    });

    // Prepara la referencia al controlador compartido de esta pantalla sin permitir reasignarlo.
    final estadoDatos = contexto.read<SolicitudesProvider>();
    // Comprueba (estado == EstadoSolicitud.aceptada) para decidir si se ejecuta esta parte.
    if (estado == EstadoSolicitud.aceptada) {
      // Espera a que termine estadoDatos.aceptar(solicitud.id) antes de continuar.
      await estadoDatos.aceptar(solicitud.id);
      // Ejecuta esta alternativa cuando no se cumplió la condición anterior.
    } else {
      // Espera a que termine estadoDatos.rechazar(solicitud.id) antes de continuar.
      await estadoDatos.rechazar(solicitud.id);
      // Cierra el bloque de instrucciones.
    }

    // Detiene la acción si la pantalla ya se eliminó.
    if (!mounted) return;
    // Prepara el error o su presentación sin permitir reasignarlo.
    final error = estadoDatos.error;
    // Agrupa cambios locales y solicita a Flutter que vuelva a dibujar la pantalla.
    setState(() {
      // Actualiza _idEnProceso con null.
      _idEnProceso = null;
      // Actualiza _accionEnProceso con null.
      _accionEnProceso = null;
      // Cierra el bloque de setState y termina la instrucción.
    });

    // Comprueba (error != null) para decidir si se ejecuta esta parte.
    if (error != null) {
      // Ejecuta mostrarAviso. Muestra un mensaje flotante de información, éxito o error.
      mostrarAviso(contexto, error, error: true);
      // Termina la función sin continuar con las instrucciones siguientes.
      return;
      // Cierra el bloque de if.
    }

    // Ejecuta mostrarAviso. Muestra un mensaje flotante de información, éxito o error.
    mostrarAviso(
      // Utiliza contexto como parte de la operación actual.
      contexto,
      // Actualiza estado con = EstadoSolicitud.aceptada.
      estado == EstadoSolicitud.aceptada
          // Usa esta alternativa cuando la condición anterior es verdadera.
          ? 'Solicitud aceptada.'
          // Usa esta alternativa cuando la condición anterior es falsa.
          : 'Solicitud rechazada.',
      // Establece el resultado que indica si la operación funcionó al valor indicado.
      exito: estado == EstadoSolicitud.aceptada,
      // Establece el error o su presentación al valor indicado.
      error: estado == EstadoSolicitud.rechazada,
      // Cierra la configuración de mostrarAviso y termina la instrucción.
    );
    // Cierra el bloque de instrucciones.
  }

  // Responde a la selección de la barra de navegación inferior.
  void _cambiarDestino(DestinoInferior destino) {
    // Comprueba (destino == DestinoInferior.tutores) para decidir si se ejecuta esta parte.
    if (destino == DestinoInferior.tutores) {
      // Accede a la navegación para abrir o reemplazar una pantalla.
      Navigator.of(contexto).pushNamedAndRemoveUntil(AppRoutes.catalogo, (
        // Utiliza ruta como parte de la operación actual.
        ruta,
        // Termina los parámetros o la condición y abre el bloque de instrucciones.
      ) {
        // Devuelve ruta.settings.name == AppRoutes.inicioSesion || ruta.isFirst como resultado de esta función.
        return ruta.settings.name == AppRoutes.inicioSesion || ruta.isFirst;
        // Cierra el bloque de instrucciones y termina la instrucción.
      });
      // Cierra el bloque de if.
    }
    // Cierra el bloque de _cambiarDestino.
  }

  // Selecciona las solicitudes que cumplen los filtros indicados.
  List<Solicitud> _filtrar(List<Solicitud> solicitudes) {
    // Comprueba (_filtro == _FiltroPanel.todas) para decidir si se ejecuta esta parte.
    if (_filtro == _FiltroPanel.todas) {
      // Devuelve solicitudes como resultado de esta función.
      return solicitudes;
      // Cierra el bloque de if.
    }
    // Prepara el estado de solicitud que se desea mostrar.
    EstadoSolicitud estadoBuscado = EstadoSolicitud.pendiente;
    // Comprueba (_filtro == _FiltroPanel.aceptadas) para decidir si se ejecuta esta parte.
    if (_filtro == _FiltroPanel.aceptadas) {
      // Actualiza estadoBuscado con EstadoSolicitud.aceptada.
      estadoBuscado = EstadoSolicitud.aceptada;
      // Si no se cumplió la condición anterior, comprueba (_filtro == _FiltroPanel.rechazadas).
    } else if (_filtro == _FiltroPanel.rechazadas) {
      // Actualiza estadoBuscado con EstadoSolicitud.rechazada.
      estadoBuscado = EstadoSolicitud.rechazada;
      // Cierra el bloque de if.
    }
    // Prepara la lista de solicitudes que cumplen la condición sin permitir reasignarlo.
    final List<Solicitud> solicitudesFiltradas = [];
    // Recorre solicitudes y utiliza solicitud para cada elemento.
    for (final solicitud in solicitudes) {
      // Comprueba (solicitud.estado == estadoBuscado) para decidir si se ejecuta esta parte.
      if (solicitud.estado == estadoBuscado) {
        // Agrega un elemento a solicitudesFiltradas.
        solicitudesFiltradas.add(solicitud);
        // Cierra el bloque de if.
      }
      // Cierra el bloque de for.
    }
    // Devuelve solicitudesFiltradas como resultado de esta función.
    return solicitudesFiltradas;
    // Cierra el bloque de _filtrar.
  }

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Prepara el controlador de la sesión sin permitir reasignarlo.
    final sesion = contexto.watch<SesionProvider>();
    // Prepara la referencia al controlador compartido de esta pantalla sin permitir reasignarlo.
    final estadoDatos = contexto.watch<SolicitudesProvider>();
    // Prepara es tutor sin permitir reasignarlo.
    final esTutor = sesion.rol == Rol.tutor;

    // Devuelve la estructura de la pantalla con la configuración siguiente.
    return Scaffold(
      // Establece la barra superior de la pantalla al valor indicado.
      appBar: AppBar(
        // Establece el título al valor indicado.
        title: Text(esTutor ? 'Solicitudes recibidas' : 'Mis solicitudes'),
        // Establece si Flutter agrega automáticamente un botón para volver al valor indicado.
        automaticallyImplyLeading: false,
        // Establece los botones de la barra superior al valor indicado.
        actions: const [SalirButton(), SizedBox(width: 8)],
        // Cierra la configuración de AppBar.
      ),
      // Establece la barra de navegación inferior al valor indicado.
      bottomNavigationBar: esTutor
          // Recibe null con tipo ?.
          ? null
          // Usa esta alternativa cuando la condición anterior es falsa.
          : AppBottomNav(
              // Establece el destino o estado activo al valor indicado.
              activo: DestinoInferior.solicitudes,
              // Establece la acción al tocar el componente al valor indicado.
              alTocar: _cambiarDestino,
              // Cierra la configuración de AppBottomNav.
            ),
      // Establece el contenido principal de la pantalla al valor indicado.
      body: _cuerpo(sesion, estadoDatos, esTutor),
      // Cierra la configuración de Scaffold y termina la instrucción.
    );
    // Cierra el bloque de build.
  }

  // Construye el contenido según los datos y el estado de carga.
  Widget _cuerpo(
    // Recibe el controlador de la sesión con tipo SesionProvider.
    SesionProvider sesion,
    // Recibe la referencia al controlador compartido de esta pantalla con tipo SolicitudesProvider.
    SolicitudesProvider estadoDatos,
    // Recibe es tutor con tipo bool.
    bool esTutor,
    // Termina los parámetros o la condición y abre el bloque de instrucciones.
  ) {
    // Comprueba (estadoDatos.cargando && estadoDatos.solicitudes.isEmpty) para decidir si se ejecuta esta parte.
    if (estadoDatos.cargando && estadoDatos.solicitudes.isEmpty) {
      // Declara en el contrato la operación que construye los componentes que se muestran mientras llegan los datos.
      return _cargando(sesion, esTutor);
      // Cierra el bloque de if.
    }

    // Comprueba (estadoDatos.error != null && estadoDatos.solicitudes.isEmpty) para decidir si se ejecuta esta parte.
    if (estadoDatos.error != null && estadoDatos.solicitudes.isEmpty) {
      // Organiza el contenido y el acceso al cierre de sesión.
      return _conSalir(
        // Crea un contenido centrado.
        Center(
          // Establece el único componente visual contenido al valor indicado.
          child: SingleChildScrollView(
            // Establece el único componente visual contenido al valor indicado.
            child: EmptyState(
              // Establece el icono del componente al valor indicado.
              icono: Icons.warning_amber_rounded,
              // Establece el título visible al valor indicado.
              titulo: 'No se pudieron cargar las solicitudes',
              // Establece el texto explicativo al valor indicado.
              subtitulo: 'Revisa tu conexión e inténtalo de nuevo.',
              // Establece el texto del botón del aviso al valor indicado.
              textoAccion: 'Reintentar',
              // Establece la acción del botón del aviso al valor indicado.
              alAccionar: estadoDatos.cargar,
              // Cierra la configuración de EmptyState.
            ),
            // Cierra la configuración de SingleChildScrollView.
          ),
          // Cierra la configuración de Center.
        ),
        // Cierra la configuración de _conSalir y termina la instrucción.
      );
      // Cierra el bloque de if.
    }

    // Comprueba (estadoDatos.solicitudes.isEmpty) para decidir si se ejecuta esta parte.
    if (estadoDatos.solicitudes.isEmpty) {
      // Organiza el contenido y el acceso al cierre de sesión.
      return _conSalir(
        // Crea un contenido centrado.
        Center(
          // Establece el único componente visual contenido al valor indicado.
          child: SingleChildScrollView(
            // Establece el único componente visual contenido al valor indicado.
            child: esTutor
                // Usa esta alternativa cuando la condición anterior es verdadera.
                ? const EmptyState(
                    // Establece el título visible al valor indicado.
                    titulo: 'No tienes solicitudes por ahora',
                    // Establece el texto explicativo al valor indicado.
                    subtitulo: 'Cuando recibas solicitudes, aparecerán aquí.',
                    // Cierra la configuración de EmptyState.
                  )
                // Usa esta alternativa cuando la condición anterior es falsa.
                : EmptyState(
                    // Establece el título visible al valor indicado.
                    titulo: 'Todavía no has enviado solicitudes',
                    // Establece el texto explicativo.
                    subtitulo:
                        // Proporciona este texto al la configuración de EmptyState.
                        'Explora el catálogo para encontrar apoyo académico.',
                    // Establece el texto del botón del aviso al valor indicado.
                    textoAccion: 'Explorar tutores',
                    // Define la acción del botón del aviso mediante una función.
                    alAccionar: () {
                      // Accede a la navegación para abrir o reemplazar una pantalla.
                      Navigator.of(
                        // Utiliza contexto como parte de la operación actual.
                        contexto,
                        // Abre el catálogo y reemplaza la pantalla anterior en el historial.
                      ).pushReplacementNamed(AppRoutes.catalogo);
                      // Cierra el bloque de instrucciones.
                    },
                    // Cierra la configuración de EmptyState.
                  ),
            // Cierra la configuración de SingleChildScrollView.
          ),
          // Cierra la configuración de Center.
        ),
        // Cierra la configuración de _conSalir y termina la instrucción.
      );
      // Cierra el bloque de if.
    }

    // Prepara las solicitudes que cumplen el filtro sin permitir reasignarlo.
    final filtradas = _filtrar(estadoDatos.solicitudes);
    // Prepara el nombre sin permitir reasignarlo. Si el dato es null, usa la alternativa situada después de ??.
    final nombre = sesion.usuario?.nombre ?? '';

    // Devuelve una lista que permite desplazamiento con la configuración siguiente.
    return ListView(
      // Establece el espacio interior alrededor del contenido al valor indicado.
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      // Establece la lista de componentes visuales hijos al valor indicado.
      children: [
        // Crea un texto visible.
        Text(
          // Evalúa nombre.isEmpty ? 'Hola' : 'Hola, ${Formato.primerNombre(nombre)}' como parte del resultado actual.
          nombre.isEmpty ? 'Hola' : 'Hola, ${Formato.primerNombre(nombre)}',
          // Establece el estilo visual al valor indicado.
          style: AppTextStyles.tituloPrincipal.copyWith(fontSize: 26),
          // Cierra la configuración de Text.
        ),
        // Crea un espacio o caja de tamaño fijo con valores constantes.
        const SizedBox(height: 6),
        // Crea un texto visible.
        Text(
          // Utiliza esTutor como parte de la operación actual.
          esTutor
              // Usa esta alternativa cuando la condición anterior es verdadera.
              ? 'Revisa las solicitudes que te enviaron.'
              // Usa esta alternativa cuando la condición anterior es falsa.
              : 'Consulta el estado de tus solicitudes.',
          // Establece el estilo visual al valor indicado.
          style: AppTextStyles.cuerpo.copyWith(fontSize: 15.5),
          // Cierra la configuración de Text.
        ),
        // Crea un espacio o caja de tamaño fijo con valores constantes.
        const SizedBox(height: 24),
        // Crea una lista visual que pasa a otra fila si no cabe.
        Wrap(
          // Establece la separación entre elementos al valor indicado.
          spacing: 12,
          // Establece la separación entre filas al valor indicado.
          runSpacing: 12,
          // Establece la lista de componentes visuales hijos al valor indicado.
          children: [
            // Ejecuta _filtroPill. Construye un botón para elegir el filtro de solicitudes.
            _filtroPill('Todas', _FiltroPanel.todas),
            // Ejecuta _filtroPill. Construye un botón para elegir el filtro de solicitudes.
            _filtroPill('Pendientes', _FiltroPanel.pendientes),
            // Ejecuta _filtroPill. Construye un botón para elegir el filtro de solicitudes.
            _filtroPill('Aceptadas', _FiltroPanel.aceptadas),
            // Ejecuta _filtroPill. Construye un botón para elegir el filtro de solicitudes.
            _filtroPill('Rechazadas', _FiltroPanel.rechazadas),
            // Cierra la lista de elementos.
          ],
          // Cierra la configuración de Wrap.
        ),
        // Crea un espacio o caja de tamaño fijo con valores constantes.
        const SizedBox(height: 24),
        // Comprueba (filtradas.isEmpty) para decidir si se ejecuta esta parte.
        if (filtradas.isEmpty)
          // Crea un aviso de ausencia de datos o error con valores constantes.
          const EmptyState(
            // Establece si se utiliza una presentación reducida al valor indicado.
            compacto: true,
            // Establece el título visible al valor indicado.
            titulo: 'No tienes solicitudes en este estado.',
            // Establece el texto explicativo al valor indicado.
            subtitulo: 'Prueba con otro filtro.',
            // Cierra la configuración de EmptyState.
          )
        // Utiliza else como parte de la operación actual.
        else
          // Inicia un recorrido por posiciones de la lista. Los puntos ... incorporan los elementos directamente a la lista.
          for (int indice = 0; indice < filtradas.length; indice++) ...[
            // Comprueba (indice > 0) const SizedBox(height: 12) para decidir si se ejecuta esta parte.
            if (indice > 0) const SizedBox(height: 12),
            // Ejecuta _tarjeta. Construye una tarjeta con las acciones permitidas al usuario.
            _tarjeta(filtradas[indice], esTutor),
            // Cierra la lista de elementos.
          ],
        // Crea un espacio o caja de tamaño fijo con valores constantes.
        const SizedBox(height: 10),
        // Ejecuta _botonSalir. Construye el botón de cierre de sesión del panel.
        _botonSalir(),
        // Cierra la lista de elementos.
      ],
      // Cierra la configuración de ListView y termina la instrucción.
    );
    // Cierra el bloque de instrucciones.
  }

  // Construye un botón para elegir el filtro de solicitudes.
  Widget _filtroPill(String label, _FiltroPanel filtro) {
    // Devuelve un botón de filtro con la configuración siguiente.
    return FilterPill(
      // Establece el texto que se va a utilizar al valor indicado.
      texto: label,
      // Establece si el filtro está seleccionado al valor indicado.
      seleccionado: _filtro == filtro,
      // Define la acción al tocar el componente mediante una función.
      alTocar: () {
        // Devuelve setState(() { como resultado de esta función.
        return setState(() {
          // Actualiza _filtro con filtro.
          _filtro = filtro;
          // Cierra el bloque de setState y termina la instrucción.
        });
        // Cierra el bloque de instrucciones.
      },
      // Cierra la configuración de FilterPill y termina la instrucción.
    );
    // Cierra el bloque de _filtroPill.
  }

  // Construye una tarjeta con las acciones permitidas al usuario.
  Widget _tarjeta(Solicitud solicitud, bool esTutor) {
    // Prepara el nombre del alumno sin permitir reasignarlo.
    final nombreAlumno = solicitud.nombreAlumno.isEmpty
        // Usa esta alternativa cuando la condición anterior es verdadera.
        ? 'Alumno'
        // Usa esta alternativa cuando la condición anterior es falsa.
        : solicitud.nombreAlumno;
    // Prepara el nombre del tutor sin permitir reasignarlo.
    final nombreTutor = solicitud.nombreTutor.isEmpty
        // Usa esta alternativa cuando la condición anterior es verdadera.
        ? 'Tutor'
        // Usa esta alternativa cuando la condición anterior es falsa.
        : solicitud.nombreTutor;
    // Prepara pendiente sin permitir reasignarlo.
    final pendiente = solicitud.estado == EstadoSolicitud.pendiente;
    // Prepara aceptada sin permitir reasignarlo.
    final aceptada = solicitud.estado == EstadoSolicitud.aceptada;

    // Devuelve una tarjeta con información de la solicitud con la configuración siguiente.
    return SolicitudCard(
      // Establece la solicitud que se muestra al valor indicado.
      solicitud: solicitud,
      // Establece si la persona aparece como tutor o alumno al valor indicado.
      etiquetaPersona: esTutor ? 'Alumno' : Formato.etiquetaTutor(nombreTutor),
      // Establece el nombre de la persona mostrada al valor indicado. La expresión ? : elige un valor según la condición.
      nombrePersona: esTutor ? nombreAlumno : nombreTutor,
      // Establece el máximo de líneas visibles del mensaje al valor indicado. La expresión ? : elige un valor según la condición.
      lineasMensaje: esTutor ? 3 : 1,
      // Establece si aparecen los botones de aceptar y rechazar al valor indicado.
      mostrarAcciones: esTutor && pendiente,
      // Establece si aparece la opción de rechazar al valor indicado.
      mostrarRechazar: esTutor && aceptada,
      // Establece si la solicitud se está actualizando al valor indicado.
      enProceso: _idEnProceso == solicitud.id,
      // Establece la acción que se está ejecutando al valor indicado.
      accionEnProceso: _accionEnProceso,
      // Define la acción para aceptar la solicitud mediante una función.
      alAceptar: () {
        // Ejecuta _cambiarEstado. Actualiza el estado de una solicitud.
        _cambiarEstado(solicitud, EstadoSolicitud.aceptada);
        // Cierra el bloque de instrucciones.
      },
      // Define la acción para rechazarla mediante una función.
      alRechazar: () {
        // Ejecuta _cambiarEstado. Actualiza el estado de una solicitud.
        _cambiarEstado(solicitud, EstadoSolicitud.rechazada);
        // Cierra el bloque de instrucciones.
      },
      // Cierra la configuración de SolicitudCard y termina la instrucción.
    );
    // Cierra el bloque de _tarjeta.
  }

  // Construye los componentes que se muestran mientras llegan los datos.
  Widget _cargando(SesionProvider sesion, bool esTutor) {
    // Prepara el nombre sin permitir reasignarlo. Si el dato es null, usa la alternativa situada después de ??.
    final nombre = sesion.usuario?.nombre ?? '';
    // Devuelve una lista que permite desplazamiento con la configuración siguiente.
    return ListView(
      // Establece el espacio interior alrededor del contenido al valor indicado.
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      // Establece la lista de componentes visuales hijos al valor indicado.
      children: [
        // Crea un texto visible.
        Text(
          // Evalúa nombre.isEmpty ? 'Hola' : 'Hola, ${Formato.primerNombre(nombre)}' como parte del resultado actual.
          nombre.isEmpty ? 'Hola' : 'Hola, ${Formato.primerNombre(nombre)}',
          // Establece el estilo visual al valor indicado.
          style: AppTextStyles.tituloPrincipal.copyWith(fontSize: 26),
          // Cierra la configuración de Text.
        ),
        // Crea un espacio o caja de tamaño fijo con valores constantes.
        const SizedBox(height: 6),
        // Crea un texto visible.
        Text(
          // Utiliza esTutor como parte de la operación actual.
          esTutor
              // Usa esta alternativa cuando la condición anterior es verdadera.
              ? 'Revisa las solicitudes que te enviaron.'
              // Usa esta alternativa cuando la condición anterior es falsa.
              : 'Consulta el estado de tus solicitudes.',
          // Establece el estilo visual al valor indicado.
          style: AppTextStyles.cuerpo.copyWith(fontSize: 15.5),
          // Cierra la configuración de Text.
        ),
        // Crea un espacio o caja de tamaño fijo con valores constantes.
        const SizedBox(height: 24),
        // Crea una tarjeta provisional de carga con valores constantes.
        const SkeletonCard(altura: 150),
        // Crea un espacio o caja de tamaño fijo con valores constantes.
        const SizedBox(height: 12),
        // Crea una tarjeta provisional de carga con valores constantes.
        const SkeletonCard(altura: 150),
        // Crea un espacio o caja de tamaño fijo con valores constantes.
        const SizedBox(height: 12),
        // Crea una tarjeta provisional de carga con valores constantes.
        const SkeletonCard(altura: 150),
        // Cierra la lista de elementos.
      ],
      // Cierra la configuración de ListView y termina la instrucción.
    );
    // Cierra el bloque de _cargando.
  }

  // Organiza el contenido y el acceso al cierre de sesión.
  Widget _conSalir(Widget contenido) {
    // Devuelve un área protegida de las barras del dispositivo con la configuración siguiente.
    return SafeArea(
      // Establece el tratamiento del borde superior al valor indicado.
      top: false,
      // Establece el único componente visual contenido al valor indicado.
      child: Column(
        // Establece la lista de componentes visuales hijos al valor indicado.
        children: [
          // Crea un componente que ocupa el espacio restante.
          Expanded(child: contenido),
          // Crea un espacio interior alrededor del contenido.
          Padding(
            // Establece el espacio interior alrededor del contenido al valor indicado.
            padding: const EdgeInsets.fromLTRB(20, 0, 12, 8),
            // Establece el único componente visual contenido al valor indicado.
            child: Align(
              // Establece la alineación del contenido al valor indicado.
              alignment: Alignment.centerRight,
              // Establece el único componente visual contenido al valor indicado.
              child: _botonSalir(),
              // Cierra la configuración de Align.
            ),
            // Cierra la configuración de Padding.
          ),
          // Cierra la lista de elementos.
        ],
        // Cierra la configuración de Column.
      ),
      // Cierra la configuración de SafeArea y termina la instrucción.
    );
    // Cierra el bloque de _conSalir.
  }

  // Construye el botón de cierre de sesión del panel.
  Widget _botonSalir() {
    // Devuelve un contenido con alineación específica con la configuración siguiente.
    return const Align(alignment: Alignment.centerRight, child: SalirButton());
    // Cierra el bloque de _botonSalir.
  }

  // Cierra la clase _PanelSolicitudesScreenState.
}
