// Importa los componentes visuales y estilos Material de Flutter.
import 'package:flutter/material.dart';
// Importa Provider para compartir y consultar el estado de la aplicación.
import 'package:provider/provider.dart';

// Importa rutasAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/routes/rutasAplicacion.dart';
// Importa temaAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/theme/temaAplicacion.dart';
// Importa formatoTextos.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/utils/formatoTextos.dart';
// Importa botonesAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/botonesAplicacion.dart';
// Importa avisoSinResultados.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/avisoSinResultados.dart';
// Importa botonesFiltro.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/botonesFiltro.dart';
// Importa avatarIniciales.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/avatarIniciales.dart';
// Importa tarjetaSeccion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/tarjetaSeccion.dart';
// Importa indicadoresCarga.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/indicadoresCarga.dart';
// Importa modeloTutor.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/models/modeloTutor.dart';
// Importa controladorTutores.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/providers/controladorTutores.dart';

/// Perfil completo del tutor con llamada a la acción fija.
// Define DetalleTutorScreen, que representa la pantalla del perfil del tutor.
class DetalleTutorScreen extends StatefulWidget {
  // Define cómo se crea DetalleTutorScreen y qué datos recibe.
  const DetalleTutorScreen({super.key, required this.idTutor});

  // Declara el identificador del tutor sin permitir reasignarlo.
  final String idTutor;

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Crea el objeto que guardará el estado de esta pantalla.
  State<DetalleTutorScreen> createState() {
    // Devuelve _DetalleTutorScreenState() como resultado de esta función.
    return _DetalleTutorScreenState();
    // Cierra el bloque de createState.
  }

  // Cierra la clase DetalleTutorScreen.
}

// Guarda los datos y acciones que pueden cambiar en esta pantalla.
class _DetalleTutorScreenState extends State<DetalleTutorScreen> {
  // Permite consultar el contexto de Flutter de esta pantalla mediante una propiedad de lectura.
  BuildContext get contexto {
    // Entrega el contexto de Flutter asociado a esta pantalla.
    return context;
    // Cierra la propiedad contexto.
  }

  // Prepara el indicador de carga inicial.
  bool _iniciando = false;

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

  // Abre el formulario con el identificador del tutor.
  void _abrirFormulario(Tutor tutor) {
    // Accede a la navegación para abrir o reemplazar una pantalla.
    Navigator.of(contexto).pushNamed(AppRoutes.solicitud, arguments: tutor.id);
    // Cierra el bloque de _abrirFormulario.
  }

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Prepara la referencia al controlador compartido de esta pantalla sin permitir reasignarlo.
    final estadoDatos = contexto.watch<TutoresProvider>();
    // Prepara el tutor que se muestra sin permitir reasignarlo.
    final tutor = estadoDatos.tutorPorId(widget.idTutor);

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
        title: const Text('Perfil del tutor'),
        // Cierra la configuración de AppBar.
      ),
      // Establece el contenido principal de la pantalla al valor indicado.
      body: _cuerpo(estadoDatos, tutor),
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
        // Declara en el contrato la operación que construye la representación provisional del perfil durante la carga.
        return _esqueleto();
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
              titulo: 'No se pudo cargar el perfil',
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
            subtitulo: 'Puede que ya no esté disponible en el catálogo.',
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

    // Devuelve una columna de componentes con la configuración siguiente.
    return Column(
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // Establece la lista de componentes visuales hijos al valor indicado.
              children: [
                // Crea un contenido centrado.
                Center(child: InitialsAvatar(nombre: tutor.nombre, tamano: 72)),
                // Crea un espacio o caja de tamaño fijo con valores constantes.
                const SizedBox(height: 18),
                // Crea un contenido centrado.
                Center(
                  // Establece el único componente visual contenido al valor indicado.
                  child: Text(
                    // Utiliza tutor.nombre como parte de la operación actual.
                    tutor.nombre,
                    // Establece la alineación del texto al valor indicado.
                    textAlign: TextAlign.center,
                    // Establece el estilo visual al valor indicado.
                    style: AppTextStyles.tituloPrincipal.copyWith(fontSize: 25),
                    // Cierra la configuración de Text.
                  ),
                  // Cierra la configuración de Center.
                ),
                // Crea un espacio o caja de tamaño fijo con valores constantes.
                const SizedBox(height: 10),
                // Crea un contenido centrado.
                Center(
                  // Establece el único componente visual contenido al valor indicado.
                  child: Row(
                    // Establece el espacio que ocupa el eje principal al valor indicado.
                    mainAxisSize: MainAxisSize.min,
                    // Establece la lista de componentes visuales hijos al valor indicado.
                    children: [
                      // Crea un icono con valores constantes.
                      const Icon(
                        // Utiliza Icons.star_rounded como parte de la operación actual.
                        Icons.star_rounded,
                        // Establece el tamaño del icono al valor indicado.
                        size: 20,
                        // Establece el color al valor indicado.
                        color: AppColors.ambar,
                        // Cierra la configuración de Icon.
                      ),
                      // Crea un espacio o caja de tamaño fijo con valores constantes.
                      const SizedBox(width: 6),
                      // Crea un texto visible.
                      Text(
                        // Proporciona este texto al la configuración de Text.
                        '${tutor.calificacion.toStringAsFixed(1)} de 5',
                        // Establece el estilo visual al valor indicado.
                        style: const TextStyle(
                          // Establece la familia tipográfica al valor indicado.
                          fontFamily: AppTextStyles.inter,
                          // Establece el tamaño de la letra al valor indicado.
                          fontSize: 16,
                          // Establece el grosor de la letra al valor indicado.
                          fontWeight: FontWeight.w600,
                          // Establece el color al valor indicado.
                          color: AppColors.ambarTexto,
                          // Cierra la configuración de TextStyle.
                        ),
                        // Cierra la configuración de Text.
                      ),
                      // Cierra la lista de elementos.
                    ],
                    // Cierra la configuración de Row.
                  ),
                  // Cierra la configuración de Center.
                ),
                // Crea un espacio o caja de tamaño fijo con valores constantes.
                const SizedBox(height: 20),
                // Crea un contenido centrado.
                Center(
                  // Establece el único componente visual contenido al valor indicado.
                  child: Wrap(
                    // Establece la separación entre elementos al valor indicado.
                    spacing: 10,
                    // Establece la separación entre filas al valor indicado.
                    runSpacing: 10,
                    // Establece la alineación del contenido al valor indicado.
                    alignment: WrapAlignment.center,
                    // Establece la lista de componentes visuales hijos al valor indicado.
                    children: [
                      // Recorre tutor.materias y utiliza materia para cada elemento.
                      for (final materia in tutor.materias)
                        // Utiliza InfoPill con los argumentos indicados.
                        InfoPill(texto: materia),
                      // Cierra la lista de elementos.
                    ],
                    // Cierra la configuración de Wrap.
                  ),
                  // Cierra la configuración de Center.
                ),
                // Crea un espacio o caja de tamaño fijo con valores constantes.
                const SizedBox(height: 30),
                // Crea un texto visible.
                Text('Sobre el tutor', style: AppTextStyles.tituloSeccion),
                // Crea un espacio o caja de tamaño fijo con valores constantes.
                const SizedBox(height: 8),
                // Crea un texto visible.
                Text(tutor.descripcion, style: AppTextStyles.cuerpo),
                // Crea un espacio o caja de tamaño fijo con valores constantes.
                const SizedBox(height: 24),
                // Crea una tarjeta que agrupa una sección.
                SectionCard(
                  // Establece el título visible al valor indicado.
                  titulo: 'Horarios disponibles',
                  // Establece el contenido de la tarjeta al valor indicado.
                  contenido: Column(
                    // Establece la lista de componentes visuales hijos al valor indicado.
                    children: [
                      // Inicia un recorrido por posiciones de la lista.
                      for (
                        // Prepara la posición del elemento en la lista.
                        int indice = 0;
                        // Evalúa indice < tutor.horariosDisponibles.length como parte del resultado actual.
                        indice < tutor.horariosDisponibles.length;
                        // Evalúa indice++ como parte del resultado actual.
                        indice++
                        // Termina el recorrido y abre los componentes que se añadirán en cada repetición. Los puntos ... incorporan los elementos directamente a la lista.
                      ) ...[
                        // Comprueba (indice > 0) const SizedBox(height: 16) para decidir si se ejecuta esta parte.
                        if (indice > 0) const SizedBox(height: 16),
                        // Utiliza LabelValueRow con los argumentos indicados.
                        LabelValueRow(
                          // Establece el icono del componente al valor indicado.
                          icono: Icons.schedule_rounded,
                          // Establece el valor recibido o almacenado al valor indicado.
                          valor: Formato.horarioDetalle(
                            // Obtiene el horario del tutor situado en la posición actual.
                            tutor.horariosDisponibles[indice],
                            // Cierra la configuración de horarioDetalle.
                          ),
                          // Cierra la configuración de LabelValueRow.
                        ),
                        // Cierra la lista de elementos.
                      ],
                      // Cierra la lista de elementos.
                    ],
                    // Cierra la configuración de Column.
                  ),
                  // Cierra la configuración de SectionCard.
                ),
                // Crea un espacio o caja de tamaño fijo con valores constantes.
                const SizedBox(height: 24),
                // Crea un texto visible.
                Text('Materias', style: AppTextStyles.tituloSeccion),
                // Crea un espacio o caja de tamaño fijo con valores constantes.
                const SizedBox(height: 12),
                // Crea una lista visual que pasa a otra fila si no cabe.
                Wrap(
                  // Establece la separación entre elementos al valor indicado.
                  spacing: 10,
                  // Establece la separación entre filas al valor indicado.
                  runSpacing: 10,
                  // Establece la lista de componentes visuales hijos al valor indicado.
                  children: [
                    // Recorre tutor.materias y utiliza materia para cada elemento.
                    for (final materia in tutor.materias)
                      // Utiliza InfoPill con los argumentos indicados.
                      InfoPill(texto: materia),
                    // Cierra la lista de elementos.
                  ],
                  // Cierra la configuración de Wrap.
                ),
                // Crea un espacio o caja de tamaño fijo con valores constantes.
                const SizedBox(height: 8),
                // Cierra la lista de elementos.
              ],
              // Cierra la configuración de Column.
            ),
            // Cierra la configuración de SingleChildScrollView.
          ),
          // Cierra la configuración de Expanded.
        ),
        // Crea un área protegida de las barras del dispositivo.
        SafeArea(
          // Establece el tratamiento del borde superior al valor indicado.
          top: false,
          // Establece el único componente visual contenido al valor indicado.
          child: Padding(
            // Establece el espacio interior alrededor del contenido al valor indicado.
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            // Establece el único componente visual contenido al valor indicado.
            child: PrimaryButton(
              // Establece el texto que se va a utilizar al valor indicado.
              texto: 'Solicitar tutoría',
              // Establece el icono del componente al valor indicado.
              icono: Icons.send_rounded,
              // Define la acción al presionar el botón mediante una función.
              alPresionar: () {
                // Declara en el contrato la operación que abre el formulario con el identificador del tutor.
                return _abrirFormulario(tutor);
                // Cierra el bloque de instrucciones.
              },
              // Cierra la configuración de PrimaryButton.
            ),
            // Cierra la configuración de Padding.
          ),
          // Cierra la configuración de SafeArea.
        ),
        // Cierra la lista de elementos.
      ],
      // Cierra la configuración de Column y termina la instrucción.
    );
    // Cierra el bloque de _cuerpo.
  }

  // Construye la representación provisional del perfil durante la carga.
  Widget _esqueleto() {
    // Devuelve una lista que permite desplazamiento con la configuración siguiente.
    return ListView(
      // Establece el espacio interior alrededor del contenido al valor indicado.
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
      // Establece la lista de componentes visuales hijos al valor indicado.
      children: const [
        // Crea un contenido centrado.
        Center(child: SkeletonBloque(ancho: 72, altura: 72, radio: 36)),
        // Crea un espacio o caja de tamaño fijo.
        SizedBox(height: 18),
        // Crea un contenido centrado.
        Center(child: SkeletonBloque(ancho: 190, altura: 22)),
        // Crea un espacio o caja de tamaño fijo.
        SizedBox(height: 12),
        // Crea un contenido centrado.
        Center(child: SkeletonBloque(ancho: 120, altura: 16)),
        // Crea un espacio o caja de tamaño fijo.
        SizedBox(height: 26),
        // Crea un contenido centrado.
        Center(child: SkeletonBloque(ancho: 220, altura: 34, radio: 999)),
        // Crea un espacio o caja de tamaño fijo.
        SizedBox(height: 32),
        // Crea un bloque provisional de carga.
        SkeletonBloque(ancho: 140, altura: 18),
        // Crea un espacio o caja de tamaño fijo.
        SizedBox(height: 12),
        // Crea un bloque provisional de carga.
        SkeletonBloque(ancho: double.infinity, altura: 14),
        // Crea un espacio o caja de tamaño fijo.
        SizedBox(height: 8),
        // Crea un bloque provisional de carga.
        SkeletonBloque(ancho: double.infinity, altura: 14),
        // Crea un espacio o caja de tamaño fijo.
        SizedBox(height: 8),
        // Crea un bloque provisional de carga.
        SkeletonBloque(ancho: 240, altura: 14),
        // Crea un espacio o caja de tamaño fijo.
        SizedBox(height: 28),
        // Crea un bloque provisional de carga.
        SkeletonBloque(ancho: double.infinity, altura: 120, radio: 16),
        // Cierra la lista de elementos.
      ],
      // Cierra la configuración de ListView y termina la instrucción.
    );
    // Cierra el bloque de _esqueleto.
  }

  // Cierra la clase _DetalleTutorScreenState.
}
