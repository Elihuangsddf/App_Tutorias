// Importa los componentes visuales y estilos Material de Flutter.
import 'package:flutter/material.dart';
// Importa las herramientas de entrada y de las barras del sistema.
import 'package:flutter/services.dart';
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
// Importa botonesAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/botonesAplicacion.dart';
// Importa campoTexto.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/campoTexto.dart';
// Importa avisoSinResultados.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/avisoSinResultados.dart';
// Importa botonesFiltro.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/botonesFiltro.dart';
// Importa avatarIniciales.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/avatarIniciales.dart';
// Importa modeloTutor.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/models/modeloTutor.dart';
// Importa controladorSolicitudes.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/providers/controladorSolicitudes.dart';
// Importa controladorTutores.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/providers/controladorTutores.dart';

/// Formulario para enviar una solicitud de tutoría.
// Define SolicitudFormScreen, que representa el formulario de nueva solicitud.
class SolicitudFormScreen extends StatefulWidget {
  // Define cómo se crea SolicitudFormScreen y qué datos recibe.
  const SolicitudFormScreen({super.key, required this.idTutor});

  // Declara el identificador del tutor sin permitir reasignarlo.
  final String idTutor;

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Crea el objeto que guardará el estado de esta pantalla.
  State<SolicitudFormScreen> createState() {
    // Devuelve _SolicitudFormScreenState() como resultado de esta función.
    return _SolicitudFormScreenState();
    // Cierra el bloque de createState.
  }

  // Cierra la clase SolicitudFormScreen.
}

// Guarda los datos y acciones que pueden cambiar en esta pantalla.
class _SolicitudFormScreenState extends State<SolicitudFormScreen> {
  // Permite consultar el contexto de Flutter de esta pantalla mediante una propiedad de lectura.
  BuildContext get contexto {
    // Entrega el contexto de Flutter asociado a esta pantalla.
    return context;
    // Cierra la propiedad contexto.
  }

  // Crea el controlador que conserva el mensaje escrito en el formulario.
  final TextEditingController _controladorMensaje = TextEditingController();

  // Declara la materia seleccionada. El signo ? del tipo permite que este dato sea null.
  String? _materia;
  // Declara el horario seleccionado. El signo ? del tipo permite que este dato sea null.
  String? _horario;
  // Declara el mensaje de error al elegir materia. El signo ? del tipo permite que este dato sea null.
  String? _errorMateria;
  // Declara el mensaje de error al elegir horario. El signo ? del tipo permite que este dato sea null.
  String? _errorHorario;
  // Declara el mensaje de error del texto escrito. El signo ? del tipo permite que este dato sea null.
  String? _errorMensaje;
  // Prepara el indicador de envío en curso.
  bool _enviando = false;
  // Prepara el indicador de carga inicial.
  bool _iniciando = false;
  // Prepara la cantidad de caracteres escritos.
  int _longitud = 0;

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Prepara la pantalla una sola vez al crear su estado.
  void initState() {
    // Ejecuta la preparación básica del estado definida por Flutter.
    super.initState();
    // Programa esta acción para después de que Flutter termine de dibujar el primer cuadro.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Ejecuta _asegurarCarga. Carga el catálogo si todavía no hay tutores ni otra carga en curso.
      _asegurarCarga();
      // Cierra el bloque de addPostFrameCallback y termina la instrucción.
    });
    // Cierra el bloque de initState.
  }

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Libera los recursos de la pantalla antes de eliminarla.
  void dispose() {
    // Libera el controlador de texto para que deje de conservar recursos.
    _controladorMensaje.dispose();
    // Completa la liberación del estado definida por Flutter.
    super.dispose();
    // Cierra el bloque de dispose.
  }

  // Carga el catálogo si todavía no hay tutores ni otra carga en curso. async permite esperar operaciones sin bloquear la interfaz.
  Future<void> _asegurarCarga() async {
    // Detiene la acción si la pantalla ya se eliminó.
    if (!mounted) return;
    // Prepara la referencia al controlador compartido de esta pantalla sin permitir reasignarlo.
    final estadoDatos = contexto.read<TutoresProvider>();
    // Evita iniciar otra carga si ya hay tutores o una carga en curso.
    if (estadoDatos.tutores.isNotEmpty || estadoDatos.cargando) return;

    // Agrupa cambios locales y solicita a Flutter que vuelva a dibujar la pantalla.
    setState(() {
      // Actualiza _iniciando con true.
      _iniciando = true;
      // Cierra el bloque de setState y termina la instrucción.
    });
    // Espera a que termine estadoDatos.cargarTutores() antes de continuar.
    await estadoDatos.cargarTutores();
    // Comprueba que la pantalla siga activa antes de actualizarla.
    if (mounted) {
      // Agrupa cambios locales y solicita a Flutter que vuelva a dibujar la pantalla.
      setState(() {
        // Actualiza _iniciando con false.
        _iniciando = false;
        // Cierra el bloque de setState y termina la instrucción.
      });
      // Cierra el bloque de if.
    }
    // Cierra el bloque de _asegurarCarga.
  }

  // Devuelve el error del mensaje o null cuando cumple las reglas. El signo ? del tipo permite que este dato sea null.
  String? _validarMensaje(String valor) {
    // Prepara el texto que se va a utilizar sin permitir reasignarlo.
    final texto = valor.trim();
    // Comprueba si el texto quedó vacío después de quitar los espacios de los extremos.
    if (texto.isEmpty) {
      // Devuelve 'El mensaje es obligatorio.' como resultado de esta función.
      return 'El mensaje es obligatorio.';
      // Cierra el bloque de if.
    }
    // Comprueba si el mensaje tiene menos de los diez caracteres requeridos.
    if (texto.length < 10) {
      // Devuelve 'El mensaje debe tener al menos 10 caracteres.' como resultado de esta función.
      return 'El mensaje debe tener al menos 10 caracteres.';
      // Cierra el bloque de if.
    }
    // Devuelve null para indicar que no hay un resultado o error que entregar.
    return null;
    // Cierra el bloque de _validarMensaje.
  }

  // Actualiza el contador y vuelve a revisar un mensaje que tenía error.
  void _actualizarMensaje(String valor) {
    // Agrupa cambios locales y solicita a Flutter que vuelva a dibujar la pantalla.
    setState(() {
      // Actualiza _longitud con valor.length.
      _longitud = valor.length;
      // Vuelve a validar mientras exista un error visible en el mensaje.
      if (_errorMensaje != null) {
        // Actualiza _errorMensaje con _validarMensaje(valor).
        _errorMensaje = _validarMensaje(valor);
        // Cierra el bloque de if.
      }
      // Cierra el bloque de setState y termina la instrucción.
    });
    // Cierra el bloque de _actualizarMensaje.
  }

  // Valida los campos y envía la solicitud al tutor. async permite esperar operaciones sin bloquear la interfaz.
  Future<void> _enviar(Tutor tutor) async {
    // Quita el foco del campo activo para cerrar el teclado.
    FocusScope.of(contexto).unfocus();

    // Prepara el mensaje del alumno sin permitir reasignarlo.
    final mensaje = _controladorMensaje.text.trim();
    // Agrupa cambios locales y solicita a Flutter que vuelva a dibujar la pantalla.
    setState(() {
      // Actualiza _errorMateria con _materia == null ? 'Selecciona una materia.' : null.
      _errorMateria = _materia == null ? 'Selecciona una materia.' : null;
      // Actualiza _errorHorario con _horario == null ? 'Selecciona un horario.' : null.
      _errorHorario = _horario == null ? 'Selecciona un horario.' : null;
      // Actualiza _errorMensaje con _validarMensaje(mensaje).
      _errorMensaje = _validarMensaje(mensaje);
      // Cierra el bloque de setState y termina la instrucción.
    });

    // Comprueba (_errorMateria != null || para decidir si se ejecuta esta parte.
    if (_errorMateria != null ||
        // Evalúa _errorHorario != null || como parte del resultado actual.
        _errorHorario != null ||
        // Evalúa _errorMensaje != null) { como parte del resultado actual.
        _errorMensaje != null) {
      // Termina la función sin continuar con las instrucciones siguientes.
      return;
      // Cierra el bloque de instrucciones.
    }

    // Agrupa cambios locales y solicita a Flutter que vuelva a dibujar la pantalla.
    setState(() {
      // Actualiza _enviando con true.
      _enviando = true;
      // Cierra el bloque de setState y termina la instrucción.
    });
    // Prepara la referencia al controlador compartido de esta pantalla sin permitir reasignarlo.
    final estadoDatos = contexto.read<SolicitudesProvider>();
    // Prepara el resultado que indica si la operación funcionó sin permitir reasignarlo.
    final exito = await estadoDatos.crearSolicitud(
      // Establece el identificador del tutor al valor indicado.
      idTutor: tutor.id,
      // Establece el nombre del tutor al valor indicado.
      nombreTutor: tutor.nombre,
      // Establece la materia elegida al valor indicado. El signo ! afirma que ese dato no es null en este punto.
      materia: _materia!,
      // Establece el horario elegido al valor indicado. El signo ! afirma que ese dato no es null en este punto.
      horario: _horario!,
      // Establece el mensaje del alumno al valor indicado.
      mensaje: mensaje,
      // Cierra la configuración de crearSolicitud y termina la instrucción.
    );

    // Detiene la acción si la pantalla ya se eliminó.
    if (!mounted) return;
    // Agrupa cambios locales y solicita a Flutter que vuelva a dibujar la pantalla.
    setState(() {
      // Actualiza _enviando con false.
      _enviando = false;
      // Cierra el bloque de setState y termina la instrucción.
    });

    // Entra al manejo del error cuando la operación no se completó correctamente.
    if (!exito) {
      // Ejecuta mostrarAviso. Muestra un mensaje flotante de información, éxito o error.
      mostrarAviso(
        // Utiliza contexto como parte de la operación actual.
        contexto,
        // Evalúa estadoDatos.error ?? como parte del resultado actual.
        estadoDatos.error ??
            // Proporciona este texto al la configuración de mostrarAviso.
            'No se pudo enviar la solicitud. Intenta de nuevo.',
        // Establece el error o su presentación al valor indicado.
        error: true,
        // Cierra la configuración de mostrarAviso y termina la instrucción.
      );
      // Termina la función sin continuar con las instrucciones siguientes.
      return;
      // Cierra el bloque de if.
    }

    // Ejecuta mostrarAviso. Muestra un mensaje flotante de información, éxito o error.
    mostrarAviso(contexto, 'Solicitud enviada correctamente.', exito: true);
    // Accede a la navegación para abrir o reemplazar una pantalla.
    Navigator.of(contexto).pushNamedAndRemoveUntil(AppRoutes.panelSolicitudes, (
      // Utiliza ruta como parte de la operación actual.
      ruta,
      // Termina los parámetros o la condición y abre el bloque de instrucciones.
    ) {
      // Devuelve ruta.settings.name == AppRoutes.inicioSesion || ruta.isFirst como resultado de esta función.
      return ruta.settings.name == AppRoutes.inicioSesion || ruta.isFirst;
      // Cierra el bloque de instrucciones y termina la instrucción.
    });
    // Cierra el bloque de _enviar.
  }

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Prepara la referencia al controlador del catálogo sin permitir reasignarlo.
    final estadoTutores = contexto.watch<TutoresProvider>();
    // Prepara el tutor que se muestra sin permitir reasignarlo.
    final tutor = estadoTutores.tutorPorId(widget.idTutor);

    // Devuelve la estructura de la pantalla con la configuración siguiente.
    return Scaffold(
      // Establece la barra superior de la pantalla al valor indicado.
      appBar: AppBar(
        // Establece el ancho reservado al botón inicial al valor indicado.
        leadingWidth: 48,
        // Establece la separación del título de la barra al valor indicado.
        titleSpacing: 0,
        // Establece el componente al inicio de la barra al valor indicado.
        leading: IconButton(
          // Establece la ayuda que describe el botón al valor indicado.
          tooltip: 'Volver',
          // Define la acción al presionar el botón mediante una función.
          onPressed: () {
            // Accede a la navegación para abrir o reemplazar una pantalla.
            Navigator.of(contexto).pop();
            // Cierra el bloque de instrucciones.
          },
          // Establece el icono al valor indicado.
          icon: const Icon(Icons.chevron_left_rounded, size: 30),
          // Cierra la configuración de IconButton.
        ),
        // Establece el título al valor indicado.
        title: const Text('Solicitar tutoría'),
        // Cierra la configuración de AppBar.
      ),
      // Establece el contenido principal de la pantalla al valor indicado.
      body: _cuerpo(estadoTutores, tutor),
      // Cierra la configuración de Scaffold y termina la instrucción.
    );
    // Cierra el bloque de build.
  }

  // Construye el contenido según los datos y el estado de carga. El signo ? del tipo permite que este dato sea null.
  Widget _cuerpo(TutoresProvider estadoDatos, Tutor? tutor) {
    // Comprueba (tutor == null) para decidir si se ejecuta esta parte.
    if (tutor == null) {
      // Comprueba (estadoDatos.cargando || _iniciando) para decidir si se ejecuta esta parte.
      if (estadoDatos.cargando || _iniciando) {
        // Devuelve un contenido centrado con la configuración siguiente.
        return const Center(child: CircularProgressIndicator());
        // Cierra el bloque de if.
      }
      // Comprueba (estadoDatos.error != null) para decidir si se ejecuta esta parte.
      if (estadoDatos.error != null) {
        // Devuelve un contenido centrado con la configuración siguiente.
        return Center(
          // Establece el único componente visual contenido al valor indicado.
          child: SingleChildScrollView(
            // Establece el único componente visual contenido al valor indicado.
            child: EmptyState(
              // Establece el icono del componente al valor indicado.
              icono: Icons.warning_amber_rounded,
              // Establece el título visible al valor indicado.
              titulo: 'No se pudo cargar el tutor',
              // Establece el texto explicativo al valor indicado.
              subtitulo: 'Revisa tu conexión e inténtalo de nuevo.',
              // Establece el texto del botón del aviso al valor indicado.
              textoAccion: 'Reintentar',
              // Establece la acción del botón del aviso al valor indicado.
              alAccionar: estadoDatos.cargarTutores,
              // Cierra la configuración de EmptyState.
            ),
            // Cierra la configuración de SingleChildScrollView.
          ),
          // Cierra la configuración de Center y termina la instrucción.
        );
        // Cierra el bloque de if.
      }
      // Devuelve un contenido centrado con la configuración siguiente.
      return Center(
        // Establece el único componente visual contenido al valor indicado.
        child: SingleChildScrollView(
          // Establece el único componente visual contenido al valor indicado.
          child: EmptyState(
            // Establece el icono del componente al valor indicado.
            icono: Icons.person_off_outlined,
            // Establece el título visible al valor indicado.
            titulo: 'No encontramos este tutor',
            // Establece el texto explicativo al valor indicado.
            subtitulo: 'Vuelve al catálogo y elige otro perfil.',
            // Establece el texto del botón del aviso al valor indicado.
            textoAccion: 'Volver',
            // Define la acción del botón del aviso mediante una función.
            alAccionar: () {
              // Accede a la navegación para abrir o reemplazar una pantalla.
              Navigator.of(contexto).pop();
              // Cierra el bloque de instrucciones.
            },
            // Cierra la configuración de EmptyState.
          ),
          // Cierra la configuración de SingleChildScrollView.
        ),
        // Cierra la configuración de Center y termina la instrucción.
      );
      // Cierra el bloque de if.
    }

    // Devuelve un área protegida de las barras del dispositivo con la configuración siguiente.
    return SafeArea(
      // Establece el tratamiento del borde superior al valor indicado.
      top: false,
      // Establece el único componente visual contenido al valor indicado.
      child: Column(
        // Establece la lista de componentes visuales hijos al valor indicado.
        children: [
          // Crea un componente que ocupa el espacio restante.
          Expanded(
            // Establece el único componente visual contenido al valor indicado.
            child: SingleChildScrollView(
              // Establece el espacio interior alrededor del contenido al valor indicado.
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              // Establece el único componente visual contenido al valor indicado.
              child: Column(
                // Establece la alineación en el eje transversal al valor indicado.
                crossAxisAlignment: CrossAxisAlignment.start,
                // Establece la lista de componentes visuales hijos al valor indicado.
                children: [
                  // Ejecuta _resumen. Construye el resumen del tutor seleccionado.
                  _resumen(tutor),
                  // Crea un espacio o caja de tamaño fijo con valores constantes.
                  const SizedBox(height: 30),
                  // Crea un texto visible.
                  Text('Materia', style: AppTextStyles.etiquetaCampo),
                  // Crea un espacio o caja de tamaño fijo con valores constantes.
                  const SizedBox(height: 12),
                  // Crea una lista visual que pasa a otra fila si no cabe.
                  Wrap(
                    // Establece la separación entre elementos al valor indicado.
                    spacing: 12,
                    // Establece la separación entre filas al valor indicado.
                    runSpacing: 12,
                    // Establece la lista de componentes visuales hijos al valor indicado.
                    children: [
                      // Recorre tutor.materias y utiliza materia para cada elemento.
                      for (final materia in tutor.materias)
                        // Crea un botón de filtro.
                        FilterPill(
                          // Establece el texto que se va a utilizar al valor indicado.
                          texto: materia,
                          // Establece si el filtro está seleccionado al valor indicado.
                          seleccionado: _materia == materia,
                          // Define la acción al tocar el componente mediante una función.
                          alTocar: () {
                            // Devuelve setState(() { como resultado de esta función.
                            return setState(() {
                              // Actualiza _materia con _materia == materia ? null : materia. La expresión ? : elige un valor según la condición.
                              _materia = _materia == materia ? null : materia;
                              // Actualiza _errorMateria con null.
                              _errorMateria = null;
                              // Cierra el bloque de setState y termina la instrucción.
                            });
                            // Cierra el bloque de instrucciones.
                          },
                          // Cierra la configuración de FilterPill.
                        ),
                      // Cierra la lista de elementos.
                    ],
                    // Cierra la configuración de Wrap.
                  ),
                  // Comprueba (_errorMateria != null) ...[ para decidir si se ejecuta esta parte. Los puntos ... incorporan los elementos directamente a la lista.
                  if (_errorMateria != null) ...[
                    // Crea un espacio o caja de tamaño fijo con valores constantes.
                    const SizedBox(height: 8),
                    // Ejecuta _textoError. Construye el texto de un error de validación. El signo ! afirma que ese dato no es null en este punto.
                    _textoError(_errorMateria!),
                    // Cierra la lista de elementos.
                  ],
                  // Crea un espacio o caja de tamaño fijo con valores constantes.
                  const SizedBox(height: 28),
                  // Crea un texto visible.
                  Text('Horario', style: AppTextStyles.etiquetaCampo),
                  // Crea un espacio o caja de tamaño fijo con valores constantes.
                  const SizedBox(height: 12),
                  // Crea una lista visual que pasa a otra fila si no cabe.
                  Wrap(
                    // Establece la separación entre elementos al valor indicado.
                    spacing: 12,
                    // Establece la separación entre filas al valor indicado.
                    runSpacing: 12,
                    // Establece la lista de componentes visuales hijos al valor indicado.
                    children: [
                      // Recorre tutor.horariosDisponibles y utiliza horario para cada elemento.
                      for (final horario in tutor.horariosDisponibles)
                        // Crea un botón de filtro.
                        FilterPill(
                          // Establece el texto que se va a utilizar al valor indicado.
                          texto: Formato.horarioCompacto(horario),
                          // Establece si el filtro está seleccionado al valor indicado.
                          seleccionado: _horario == horario,
                          // Define la acción al tocar el componente mediante una función.
                          alTocar: () {
                            // Devuelve setState(() { como resultado de esta función.
                            return setState(() {
                              // Actualiza _horario con _horario == horario ? null : horario. La expresión ? : elige un valor según la condición.
                              _horario = _horario == horario ? null : horario;
                              // Actualiza _errorHorario con null.
                              _errorHorario = null;
                              // Cierra el bloque de setState y termina la instrucción.
                            });
                            // Cierra el bloque de instrucciones.
                          },
                          // Cierra la configuración de FilterPill.
                        ),
                      // Cierra la lista de elementos.
                    ],
                    // Cierra la configuración de Wrap.
                  ),
                  // Comprueba (_errorHorario != null) ...[ para decidir si se ejecuta esta parte. Los puntos ... incorporan los elementos directamente a la lista.
                  if (_errorHorario != null) ...[
                    // Crea un espacio o caja de tamaño fijo con valores constantes.
                    const SizedBox(height: 8),
                    // Ejecuta _textoError. Construye el texto de un error de validación. El signo ! afirma que ese dato no es null en este punto.
                    _textoError(_errorHorario!),
                    // Cierra la lista de elementos.
                  ],
                  // Crea un espacio o caja de tamaño fijo con valores constantes.
                  const SizedBox(height: 28),
                  // Crea un campo de texto con etiqueta y ayuda.
                  AppTextField(
                    // Establece la etiqueta visible al valor indicado.
                    etiqueta: 'Mensaje',
                    // Establece el ejemplo mostrado mientras el campo está vacío al valor indicado.
                    textoEjemplo: 'Describe qué necesitas repasar',
                    // Establece el controlador del texto al valor indicado.
                    controlador: _controladorMensaje,
                    // Establece el mínimo de líneas del campo al valor indicado.
                    lineasMinimas: 6,
                    // Establece el máximo de líneas del campo al valor indicado.
                    lineasMaximas: 6,
                    // Establece el tipo de teclado al valor indicado.
                    tipoTeclado: TextInputType.multiline,
                    // Establece la acción del teclado al valor indicado.
                    accionTeclado: TextInputAction.newline,
                    // Establece las reglas que limitan la entrada al valor indicado.
                    formatosEntrada: [LengthLimitingTextInputFormatter(300)],
                    // Establece la acción al cambiar el texto al valor indicado.
                    alCambiar: _actualizarMensaje,
                    // Establece el error del campo al valor indicado.
                    errorTexto: _errorMensaje,
                    // Establece la ayuda inferior del campo al valor indicado.
                    textoAyuda: 'Mínimo 10 caracteres',
                    // Establece el contador de caracteres al valor indicado.
                    contadorTexto: '$_longitud/300',
                    // Establece si el contador llegó al límite al valor indicado.
                    contadorAlLimite: _longitud >= 300,
                    // Cierra la configuración de AppTextField.
                  ),
                  // Cierra la lista de elementos.
                ],
                // Cierra la configuración de Column.
              ),
              // Cierra la configuración de SingleChildScrollView.
            ),
            // Cierra la configuración de Expanded.
          ),
          // Crea un espacio interior alrededor del contenido.
          Padding(
            // Establece el espacio interior alrededor del contenido al valor indicado.
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            // Establece el único componente visual contenido al valor indicado.
            child: PrimaryButton(
              // Establece el texto que se va a utilizar al valor indicado.
              texto: 'Enviar solicitud',
              // Establece si se muestra el indicador de carga al valor indicado.
              cargando: _enviando,
              // Define la acción al presionar el botón mediante una función.
              alPresionar: () {
                // Ejecuta _enviar. Valida los campos y envía la solicitud al tutor.
                _enviar(tutor);
                // Cierra el bloque de instrucciones.
              },
              // Cierra la configuración de PrimaryButton.
            ),
            // Cierra la configuración de Padding.
          ),
          // Cierra la lista de elementos.
        ],
        // Cierra la configuración de Column.
      ),
      // Cierra la configuración de SafeArea y termina la instrucción.
    );
    // Cierra el bloque de _cuerpo.
  }

  // Construye el resumen del tutor seleccionado.
  Widget _resumen(Tutor tutor) {
    // Devuelve un contenedor con tamaño y decoración con la configuración siguiente.
    return Container(
      // Establece el ancho al valor indicado.
      width: double.infinity,
      // Establece el espacio interior alrededor del contenido al valor indicado.
      padding: const EdgeInsets.all(16),
      // Establece la decoración de fondo, bordes o campo al valor indicado.
      decoration: BoxDecoration(
        // Establece el color al valor indicado.
        color: AppColors.resumenTinte,
        // Establece el redondeado de las esquinas al valor indicado.
        borderRadius: BorderRadius.circular(AppRadii.tarjeta),
        // Cierra la configuración de BoxDecoration.
      ),
      // Establece el único componente visual contenido al valor indicado.
      child: Row(
        // Establece la lista de componentes visuales hijos al valor indicado.
        children: [
          // Crea un avatar con las iniciales del nombre.
          InitialsAvatar(
            // Establece el nombre al valor indicado.
            nombre: tutor.nombre,
            // Establece el tamaño del componente al valor indicado.
            tamano: 44,
            // Establece el color de fondo al valor indicado.
            colorFondo: Colors.transparent,
            // Cierra la configuración de InitialsAvatar.
          ),
          // Crea un espacio o caja de tamaño fijo con valores constantes.
          const SizedBox(width: 12),
          // Crea un componente que ocupa el espacio restante.
          Expanded(
            // Establece el único componente visual contenido al valor indicado.
            child: Column(
              // Establece la alineación en el eje transversal al valor indicado.
              crossAxisAlignment: CrossAxisAlignment.start,
              // Establece la lista de componentes visuales hijos al valor indicado.
              children: [
                // Crea un texto visible.
                Text(
                  // Utiliza tutor.nombre como parte de la operación actual.
                  tutor.nombre,
                  // Establece el máximo de líneas al valor indicado.
                  maxLines: 1,
                  // Establece cómo se muestra un texto que no cabe al valor indicado.
                  overflow: TextOverflow.ellipsis,
                  // Establece el estilo visual al valor indicado.
                  style: AppTextStyles.tituloTarjeta,
                  // Cierra la configuración de Text.
                ),
                // Crea un espacio o caja de tamaño fijo con valores constantes.
                const SizedBox(height: 4),
                // Crea un texto visible.
                Text(
                  // Une las materias del tutor separándolas con un punto centrado.
                  tutor.materias.join(' · '),
                  // Establece el estilo visual al valor indicado.
                  style: AppTextStyles.cuerpo.copyWith(fontSize: 14),
                  // Cierra la configuración de Text.
                ),
                // Cierra la lista de elementos.
              ],
              // Cierra la configuración de Column.
            ),
            // Cierra la configuración de Expanded.
          ),
          // Cierra la lista de elementos.
        ],
        // Cierra la configuración de Row.
      ),
      // Cierra la configuración de Container y termina la instrucción.
    );
    // Cierra el bloque de _resumen.
  }

  // Construye el texto de un error de validación.
  Widget _textoError(String texto) {
    // Devuelve un texto visible con la configuración siguiente.
    return Text(
      // Utiliza texto como parte de la operación actual.
      texto,
      // Establece el estilo visual al valor indicado.
      style: AppTextStyles.etiqueta.copyWith(color: AppColors.rechazada),
      // Cierra la configuración de Text y termina la instrucción.
    );
    // Cierra el bloque de _textoError.
  }

  // Cierra la clase _SolicitudFormScreenState.
}
