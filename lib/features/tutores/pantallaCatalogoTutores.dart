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
// Importa barraNavegacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/barraNavegacion.dart';
// Importa avisoSinResultados.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/avisoSinResultados.dart';
// Importa botonesFiltro.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/botonesFiltro.dart';
// Importa avatarIniciales.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/avatarIniciales.dart';
// Importa botonCerrarSesion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/botonCerrarSesion.dart';
// Importa indicadoresCarga.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/indicadoresCarga.dart';
// Importa tarjetaTutor.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/tarjetaTutor.dart';
// Importa modeloTutor.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/models/modeloTutor.dart';
// Importa controladorSesion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/providers/controladorSesion.dart';
// Importa controladorTutores.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/providers/controladorTutores.dart';

/// Catálogo de tutores con búsqueda, filtros y estados de carga.
// Define CatalogoTutoresScreen, que representa la pantalla del catálogo de tutores.
class CatalogoTutoresScreen extends StatefulWidget {
  // Define cómo se crea CatalogoTutoresScreen y qué datos recibe.
  const CatalogoTutoresScreen({super.key});

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Crea el objeto que guardará el estado de esta pantalla.
  State<CatalogoTutoresScreen> createState() {
    // Devuelve _CatalogoTutoresScreenState() como resultado de esta función.
    return _CatalogoTutoresScreenState();
    // Cierra el bloque de createState.
  }

  // Cierra la clase CatalogoTutoresScreen.
}

// Guarda los datos y acciones que pueden cambiar en esta pantalla.
class _CatalogoTutoresScreenState extends State<CatalogoTutoresScreen> {
  // Permite consultar el contexto de Flutter de esta pantalla mediante una propiedad de lectura.
  BuildContext get contexto {
    // Entrega el contexto de Flutter asociado a esta pantalla.
    return context;
    // Cierra la propiedad contexto.
  }

  // Prepara materias filtro.
  static const List<String> _materiasFiltro = [
    // Proporciona este texto al la lista de elementos.
    'Matemáticas',
    // Proporciona este texto al la lista de elementos.
    'Física',
    // Proporciona este texto al la lista de elementos.
    'Programación',
    // Proporciona este texto al la lista de elementos.
    'Química',
    // Cierra la lista de elementos y termina la instrucción.
  ];

  // Crea el controlador que conserva el texto de búsqueda del catálogo.
  final TextEditingController _controladorBusqueda = TextEditingController();

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Prepara la pantalla una sola vez al crear su estado.
  void initState() {
    // Ejecuta la preparación básica del estado definida por Flutter.
    super.initState();
    // Prepara la referencia al controlador compartido de esta pantalla sin permitir reasignarlo.
    final estadoDatos = contexto.read<TutoresProvider>();
    // Actualiza _controladorBusqueda.text con estadoDatos.busqueda.
    _controladorBusqueda.text = estadoDatos.busqueda;

    // Programa esta acción para después de que Flutter termine de dibujar el primer cuadro.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Detiene la acción si la pantalla ya se eliminó.
      if (!mounted) return;
      // Comprueba (estadoDatos.tutores.isEmpty && !estadoDatos.cargando) para decidir si se ejecuta esta parte.
      if (estadoDatos.tutores.isEmpty && !estadoDatos.cargando) {
        // Ejecuta cargarTutores sobre estadoDatos.
        estadoDatos.cargarTutores();
        // Cierra el bloque de if.
      }
      // Cierra el bloque de addPostFrameCallback y termina la instrucción.
    });
    // Cierra el bloque de initState.
  }

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Libera los recursos de la pantalla antes de eliminarla.
  void dispose() {
    // Libera el controlador de texto para que deje de conservar recursos.
    _controladorBusqueda.dispose();
    // Completa la liberación del estado definida por Flutter.
    super.dispose();
    // Cierra el bloque de dispose.
  }

  // Limpia los filtros y el campo de búsqueda.
  void _limpiarFiltros(TutoresProvider estadoDatos) {
    // Ejecuta limpiarFiltros sobre estadoDatos.
    estadoDatos.limpiarFiltros();
    // Vacía _controladorBusqueda.
    _controladorBusqueda.clear();
    // Cierra el bloque de _limpiarFiltros.
  }

  // Abre el perfil del tutor elegido.
  void _abrirDetalle(Tutor tutor) {
    // Accede a la navegación para abrir o reemplazar una pantalla.
    Navigator.of(
      // Utiliza contexto como parte de la operación actual.
      contexto,
      // Accede a la navegación para abrir o reemplazar una pantalla.
    ).pushNamed(AppRoutes.detalleTutor, arguments: tutor.id);
    // Cierra el bloque de _abrirDetalle.
  }

  // Responde a la selección de la barra de navegación inferior.
  void _cambiarDestino(DestinoInferior destino) {
    // Comprueba (destino == DestinoInferior.solicitudes) para decidir si se ejecuta esta parte.
    if (destino == DestinoInferior.solicitudes) {
      // Accede a la navegación para abrir o reemplazar una pantalla.
      Navigator.of(contexto).pushReplacementNamed(AppRoutes.panelSolicitudes);
      // Cierra el bloque de if.
    }
    // Cierra el bloque de _cambiarDestino.
  }

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Prepara la referencia al controlador compartido de esta pantalla sin permitir reasignarlo.
    final estadoDatos = contexto.watch<TutoresProvider>();
    // Prepara el controlador de la sesión sin permitir reasignarlo.
    final sesion = contexto.watch<SesionProvider>();
    // Prepara nombre usuario sin permitir reasignarlo. Si el dato es null, usa la alternativa situada después de ??.
    final nombreUsuario = sesion.usuario?.nombre ?? 'Alumno';

    // Devuelve la estructura de la pantalla con la configuración siguiente.
    return Scaffold(
      // Establece la barra superior de la pantalla al valor indicado.
      appBar: AppBar(
        // Establece el título al valor indicado.
        title: const Text('Tutores'),
        // Establece si Flutter agrega automáticamente un botón para volver al valor indicado.
        automaticallyImplyLeading: false,
        // Establece los botones de la barra superior al valor indicado.
        actions: [
          // Crea un contenido centrado.
          Center(child: InitialsAvatar(nombre: nombreUsuario, tamano: 42)),
          // Crea un espacio o caja de tamaño fijo con valores constantes.
          const SizedBox(width: 2),
          // Crea un botón para cerrar la sesión con valores constantes.
          const SalirButton(),
          // Crea un espacio o caja de tamaño fijo con valores constantes.
          const SizedBox(width: 8),
          // Cierra la lista de elementos.
        ],
        // Cierra la configuración de AppBar.
      ),
      // Establece la barra de navegación inferior al valor indicado.
      bottomNavigationBar: AppBottomNav(
        // Establece el destino o estado activo al valor indicado.
        activo: DestinoInferior.tutores,
        // Establece la acción al tocar el componente al valor indicado.
        alTocar: _cambiarDestino,
        // Cierra la configuración de AppBottomNav.
      ),
      // Establece el contenido principal de la pantalla al valor indicado.
      body: _cuerpo(estadoDatos),
      // Cierra la configuración de Scaffold y termina la instrucción.
    );
    // Cierra el bloque de build.
  }

  // Construye el contenido según los datos y el estado de carga.
  Widget _cuerpo(TutoresProvider estadoDatos) {
    // Comprueba (estadoDatos.cargando && estadoDatos.tutores.isEmpty) para decidir si se ejecuta esta parte.
    if (estadoDatos.cargando && estadoDatos.tutores.isEmpty) {
      // Declara en el contrato la operación que construye los componentes que se muestran mientras llegan los datos.
      return _cargando();
      // Cierra el bloque de if.
    }

    // Comprueba (estadoDatos.error != null && estadoDatos.tutores.isEmpty) para decidir si se ejecuta esta parte.
    if (estadoDatos.error != null && estadoDatos.tutores.isEmpty) {
      // Devuelve un contenido centrado con la configuración siguiente.
      return Center(
        // Establece el único componente visual contenido al valor indicado.
        child: SingleChildScrollView(
          // Establece el único componente visual contenido al valor indicado.
          child: EmptyState(
            // Establece el icono del componente al valor indicado.
            icono: Icons.warning_amber_rounded,
            // Establece el título visible al valor indicado.
            titulo: 'No se pudo cargar el catálogo',
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

    // Comprueba (estadoDatos.tutores.isEmpty) para decidir si se ejecuta esta parte.
    if (estadoDatos.tutores.isEmpty) {
      // Devuelve un contenido centrado con la configuración siguiente.
      return const Center(
        // Establece el único componente visual contenido al valor indicado.
        child: SingleChildScrollView(
          // Establece el único componente visual contenido al valor indicado.
          child: EmptyState(
            // Establece el icono del componente al valor indicado.
            icono: Icons.groups_outlined,
            // Establece el título visible al valor indicado.
            titulo: 'Aún no hay tutores disponibles',
            // Establece el texto explicativo al valor indicado.
            subtitulo: 'Vuelve a intentarlo más tarde.',
            // Cierra la configuración de EmptyState.
          ),
          // Cierra la configuración de SingleChildScrollView.
        ),
        // Cierra la configuración de Center y termina la instrucción.
      );
      // Cierra el bloque de if.
    }

    // Prepara los tutores que cumplen los filtros sin permitir reasignarlo.
    final resultados = estadoDatos.resultados;

    // Devuelve una lista que permite desplazamiento con la configuración siguiente.
    return ListView(
      // Establece el espacio interior alrededor del contenido al valor indicado.
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      // Establece la lista de componentes visuales hijos al valor indicado.
      children: [
        // Crea un campo editable.
        TextField(
          // Establece el controlador que guarda el texto del campo al valor indicado.
          controller: _controladorBusqueda,
          // Establece la acción al cambiar el texto al valor indicado.
          onChanged: estadoDatos.actualizarBusqueda,
          // Establece la acción del teclado al valor indicado.
          textInputAction: TextInputAction.search,
          // Establece el estilo visual al valor indicado.
          style: const TextStyle(
            // Establece la familia tipográfica al valor indicado.
            fontFamily: AppTextStyles.inter,
            // Establece el tamaño de la letra al valor indicado.
            fontSize: 15,
            // Establece el color al valor indicado.
            color: AppColors.moradoOscuro,
            // Cierra la configuración de TextStyle.
          ),
          // Establece la decoración de fondo, bordes o campo al valor indicado.
          decoration: const InputDecoration(
            // Establece el texto de ejemplo del campo al valor indicado.
            hintText: 'Buscar por nombre o materia',
            // Establece el icono inicial del campo al valor indicado.
            prefixIcon: Icon(
              // Utiliza Icons.search_rounded como parte de la operación actual.
              Icons.search_rounded,
              // Establece el tamaño del icono al valor indicado.
              size: 21,
              // Establece el color al valor indicado.
              color: AppColors.textoSecundario,
              // Cierra la configuración de Icon.
            ),
            // Establece los límites de tamaño del icono inicial al valor indicado.
            prefixIconConstraints: BoxConstraints(minWidth: 46, minHeight: 24),
            // Establece el espacio interior del campo o aviso al valor indicado.
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            // Cierra la configuración de InputDecoration.
          ),
          // Cierra la configuración de TextField.
        ),
        // Crea un espacio o caja de tamaño fijo con valores constantes.
        const SizedBox(height: 16),
        // Crea una lista visual que pasa a otra fila si no cabe.
        Wrap(
          // Establece la separación entre elementos al valor indicado.
          spacing: 12,
          // Establece la separación entre filas al valor indicado.
          runSpacing: 12,
          // Establece la lista de componentes visuales hijos al valor indicado.
          children: [
            // Crea un botón de filtro.
            FilterPill(
              // Establece el texto que se va a utilizar al valor indicado.
              texto: 'Todas',
              // Establece si el filtro está seleccionado al valor indicado.
              seleccionado: !estadoDatos.hayFiltros,
              // Define la acción al tocar el componente mediante una función.
              alTocar: () {
                // Declara en el contrato la operación que limpia los filtros y el campo de búsqueda.
                return _limpiarFiltros(estadoDatos);
                // Cierra el bloque de instrucciones.
              },
              // Cierra la configuración de FilterPill.
            ),
            // Recorre _materiasFiltro y utiliza materia para cada elemento.
            for (final materia in _materiasFiltro)
              // Crea un botón de filtro.
              FilterPill(
                // Establece el texto que se va a utilizar al valor indicado.
                texto: materia,
                // Establece si el filtro está seleccionado al valor indicado.
                seleccionado: estadoDatos.materiaFiltro == materia,
                // Define la acción al tocar el componente mediante una función.
                alTocar: () {
                  // Devuelve estadoDatos.filtrarPorMateria(materia) como resultado de esta función.
                  return estadoDatos.filtrarPorMateria(materia);
                  // Cierra el bloque de instrucciones.
                },
                // Cierra la configuración de FilterPill.
              ),
            // Crea un botón de filtro.
            FilterPill(
              // Establece el texto que se va a utilizar al valor indicado.
              texto: '4.8+',
              // Establece si el filtro está seleccionado al valor indicado.
              seleccionado: estadoDatos.calificacionMinima == 4.8,
              // Define la acción al tocar el componente mediante una función.
              alTocar: () {
                // Devuelve estadoDatos.filtrarPorCalificacion(4.8) como resultado de esta función.
                return estadoDatos.filtrarPorCalificacion(4.8);
                // Cierra el bloque de instrucciones.
              },
              // Cierra la configuración de FilterPill.
            ),
            // Cierra la lista de elementos.
          ],
          // Cierra la configuración de Wrap.
        ),
        // Comprueba (resultados.isNotEmpty) ...[ para decidir si se ejecuta esta parte. Los puntos ... incorporan los elementos directamente a la lista.
        if (resultados.isNotEmpty) ...[
          // Crea un espacio o caja de tamaño fijo con valores constantes.
          const SizedBox(height: 20),
          // Crea un texto visible.
          Text(
            // Ejecuta contadorTutores sobre Formato.
            Formato.contadorTutores(resultados.length),
            // Establece el estilo visual al valor indicado.
            style: AppTextStyles.etiqueta.copyWith(fontSize: 13.5),
            // Cierra la configuración de Text.
          ),
          // Crea un espacio o caja de tamaño fijo con valores constantes.
          const SizedBox(height: 14),
          // Inicia un recorrido por posiciones de la lista. Los puntos ... incorporan los elementos directamente a la lista.
          for (int indice = 0; indice < resultados.length; indice++) ...[
            // Comprueba (indice > 0) const SizedBox(height: 12) para decidir si se ejecuta esta parte.
            if (indice > 0) const SizedBox(height: 12),
            // Crea una tarjeta con información del tutor.
            TutorCard(
              // Establece el tutor que se muestra al valor indicado.
              tutor: resultados[indice],
              // Define la acción al tocar el componente mediante una función.
              alTocar: () {
                // Declara en el contrato la operación que abre el perfil del tutor elegido.
                return _abrirDetalle(resultados[indice]);
                // Cierra el bloque de instrucciones.
              },
              // Cierra la configuración de TutorCard.
            ),
            // Cierra la lista de elementos.
          ],
          // Termina los componentes del primer caso y añade los del caso alternativo. Los puntos ... incorporan los elementos directamente a la lista.
        ] else ...[
          // Crea un espacio o caja de tamaño fijo con valores constantes.
          const SizedBox(height: 16),
          // Crea un aviso de ausencia de datos o error.
          EmptyState(
            // Establece el icono del componente al valor indicado.
            icono: Icons.search_rounded,
            // Establece el título visible al valor indicado.
            titulo: 'No encontramos tutores',
            // Establece el texto explicativo al valor indicado.
            subtitulo: 'Prueba con otra materia o limpia los filtros.',
            // Establece el texto del botón del aviso al valor indicado.
            textoAccion: 'Limpiar filtros',
            // Define la acción del botón del aviso mediante una función.
            alAccionar: () {
              // Declara en el contrato la operación que limpia los filtros y el campo de búsqueda.
              return _limpiarFiltros(estadoDatos);
              // Cierra el bloque de instrucciones.
            },
            // Cierra la configuración de EmptyState.
          ),
          // Cierra la lista de elementos.
        ],
        // Cierra la lista de elementos.
      ],
      // Cierra la configuración de ListView y termina la instrucción.
    );
    // Cierra el bloque de _cuerpo.
  }

  // Construye los componentes que se muestran mientras llegan los datos.
  Widget _cargando() {
    // Devuelve una lista que permite desplazamiento con la configuración siguiente.
    return ListView(
      // Establece el espacio interior alrededor del contenido al valor indicado.
      padding: const EdgeInsets.fromLTRB(20, 48, 20, 24),
      // Establece la lista de componentes visuales hijos al valor indicado.
      children: const [
        // Crea un texto visible.
        Text(
          // Proporciona este texto al la configuración de Text.
          'Cargando tutores...',
          // Establece el estilo visual al valor indicado.
          style: TextStyle(
            // Establece la familia tipográfica al valor indicado.
            fontFamily: AppTextStyles.poppins,
            // Establece el tamaño de la letra al valor indicado.
            fontSize: 23,
            // Establece la altura al valor indicado.
            height: 1.2,
            // Establece el grosor de la letra al valor indicado.
            fontWeight: FontWeight.w700,
            // Establece el color al valor indicado.
            color: AppColors.moradoOscuro,
            // Cierra la configuración de TextStyle.
          ),
          // Cierra la configuración de Text.
        ),
        // Crea un espacio o caja de tamaño fijo.
        SizedBox(height: 10),
        // Crea un texto visible.
        Text('Estamos preparando el catálogo.', style: AppTextStyles.cuerpo),
        // Crea un espacio o caja de tamaño fijo.
        SizedBox(height: 28),
        // Crea una tarjeta provisional de carga.
        SkeletonCard(),
        // Crea un espacio o caja de tamaño fijo.
        SizedBox(height: 12),
        // Crea una tarjeta provisional de carga.
        SkeletonCard(),
        // Crea un espacio o caja de tamaño fijo.
        SizedBox(height: 12),
        // Crea una tarjeta provisional de carga.
        SkeletonCard(),
        // Cierra la lista de elementos.
      ],
      // Cierra la configuración de ListView y termina la instrucción.
    );
    // Cierra el bloque de _cargando.
  }

  // Cierra la clase _CatalogoTutoresScreenState.
}
