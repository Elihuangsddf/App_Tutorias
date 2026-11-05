// Importa botonesAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/botonesAplicacion.dart';
// Importa temaAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/theme/temaAplicacion.dart';
// Importa modeloSolicitud.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/models/modeloSolicitud.dart';
// Importa formatoTextos.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/utils/formatoTextos.dart';
// Importa los componentes visuales y estilos Material de Flutter.
import 'package:flutter/material.dart';

/// Tarjeta de solicitud usada en el panel de alumno y en el de tutor.
// Define SolicitudCard, que representa una tarjeta con información de la solicitud.
class SolicitudCard extends StatelessWidget {
  // Define cómo se crea SolicitudCard y qué datos recibe.
  const SolicitudCard({
    // Entrega a Flutter la clave opcional que identifica este componente.
    super.key,
    // Solicita la solicitud que se muestra.
    required this.solicitud,
    // Solicita si la persona aparece como tutor o alumno.
    required this.etiquetaPersona,
    // Solicita el nombre de la persona mostrada.
    required this.nombrePersona,
    // Recibe como opción el máximo de líneas visibles del mensaje.
    this.lineasMensaje = 2,
    // Recibe como opción si aparecen los botones de aceptar y rechazar.
    this.mostrarAcciones = false,
    // Recibe como opción si aparece la opción de rechazar.
    this.mostrarRechazar = false,
    // Recibe como opción si la solicitud se está actualizando.
    this.enProceso = false,
    // Recibe como opción la acción que se está ejecutando.
    this.accionEnProceso,
    // Recibe como opción la acción para aceptar la solicitud.
    this.alAceptar,
    // Recibe como opción la acción para rechazarla.
    this.alRechazar,
    // Cierra el bloque de SolicitudCard y termina la instrucción.
  });

  // Declara la solicitud que se muestra sin permitir reasignarlo.
  final Solicitud solicitud;

  /// "Tutora", "Tutor" o "Alumno".
  // Declara si la persona aparece como tutor o alumno sin permitir reasignarlo.
  final String etiquetaPersona;
  // Declara el nombre de la persona mostrada sin permitir reasignarlo.
  final String nombrePersona;
  // Declara el máximo de líneas visibles del mensaje sin permitir reasignarlo.
  final int lineasMensaje;

  /// Muestra los botones Rechazar / Aceptar (solo solicitudes pendientes).
  // Declara si aparecen los botones de aceptar y rechazar sin permitir reasignarlo.
  final bool mostrarAcciones;

  /// Muestra el enlace rojo "Rechazar" en solicitudes ya aceptadas.
  // Declara si aparece la opción de rechazar sin permitir reasignarlo.
  final bool mostrarRechazar;

  // Declara si la solicitud se está actualizando sin permitir reasignarlo.
  final bool enProceso;
  // Declara la acción que se está ejecutando sin permitir reasignarlo. El signo ? del tipo permite que este dato sea null.
  final EstadoSolicitud? accionEnProceso;
  // Declara la acción para aceptar la solicitud sin permitir reasignarlo. El signo ? del tipo permite que este dato sea null.
  final VoidCallback? alAceptar;
  // Declara la acción para rechazarla sin permitir reasignarlo. El signo ? del tipo permite que este dato sea null.
  final VoidCallback? alRechazar;

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Devuelve un contenedor con tamaño y decoración con la configuración siguiente.
    return Container(
      // Establece el ancho al valor indicado.
      width: double.infinity,
      // Establece el espacio interior alrededor del contenido al valor indicado.
      padding: const EdgeInsets.all(AppSpacing.tarjeta),
      // Establece la decoración de fondo, bordes o campo al valor indicado.
      decoration: BoxDecoration(
        // Establece el color al valor indicado.
        color: AppColors.superficie,
        // Establece el redondeado de las esquinas al valor indicado.
        borderRadius: BorderRadius.circular(AppRadii.tarjeta),
        // Establece el borde al valor indicado.
        border: Border.all(color: AppColors.borde),
        // Cierra la configuración de BoxDecoration.
      ),
      // Establece el único componente visual contenido al valor indicado.
      child: Column(
        // Establece la alineación en el eje transversal al valor indicado.
        crossAxisAlignment: CrossAxisAlignment.start,
        // Establece la lista de componentes visuales hijos al valor indicado.
        children: [
          // Crea una fila de componentes.
          Row(
            // Establece la alineación en el eje transversal al valor indicado.
            crossAxisAlignment: CrossAxisAlignment.start,
            // Establece la lista de componentes visuales hijos al valor indicado.
            children: [
              // Crea un componente que ocupa el espacio restante.
              Expanded(
                // Establece el único componente visual contenido al valor indicado.
                child: Text(
                  // Utiliza solicitud.materia como parte de la operación actual.
                  solicitud.materia,
                  // Establece el estilo visual al valor indicado.
                  style: AppTextStyles.tituloSeccion.copyWith(fontSize: 18),
                  // Cierra la configuración de Text.
                ),
                // Cierra la configuración de Expanded.
              ),
              // Crea un espacio o caja de tamaño fijo con valores constantes.
              const SizedBox(width: 8),
              // Crea una etiqueta de estado de solicitud.
              StatusChip(estado: solicitud.estado),
              // Cierra la lista de elementos.
            ],
            // Cierra la configuración de Row.
          ),
          // Crea un espacio o caja de tamaño fijo con valores constantes.
          const SizedBox(height: 10),
          // Crea un texto visible.
          Text(
            // Proporciona este texto al la configuración de Text.
            '$etiquetaPersona: $nombrePersona',
            // Establece el estilo visual al valor indicado.
            style: AppTextStyles.cuerpo.copyWith(fontSize: 14.5),
            // Cierra la configuración de Text.
          ),
          // Crea un espacio o caja de tamaño fijo con valores constantes.
          const SizedBox(height: 8),
          // Crea una fila de componentes.
          Row(
            // Establece la lista de componentes visuales hijos al valor indicado.
            children: [
              // Crea un icono con valores constantes.
              const Icon(
                // Utiliza Icons.schedule_rounded como parte de la operación actual.
                Icons.schedule_rounded,
                // Establece el tamaño del icono al valor indicado.
                size: 16,
                // Establece el color al valor indicado.
                color: AppColors.textoSecundario,
                // Cierra la configuración de Icon.
              ),
              // Crea un espacio o caja de tamaño fijo con valores constantes.
              const SizedBox(width: 6),
              // Crea un componente que ocupa el espacio restante.
              Expanded(
                // Establece el único componente visual contenido al valor indicado.
                child: Text(
                  // Utiliza solicitud.horario como parte de la operación actual.
                  solicitud.horario,
                  // Establece el estilo visual al valor indicado.
                  style: AppTextStyles.etiqueta.copyWith(fontSize: 13.5),
                  // Cierra la configuración de Text.
                ),
                // Cierra la configuración de Expanded.
              ),
              // Crea un espacio o caja de tamaño fijo con valores constantes.
              const SizedBox(width: 8),
              // Crea un texto visible.
              Text(
                // Ejecuta fechaCorta sobre Formato.
                Formato.fechaCorta(solicitud.fecha),
                // Establece el estilo visual al valor indicado.
                style: AppTextStyles.etiqueta,
                // Cierra la configuración de Text.
              ),
              // Cierra la lista de elementos.
            ],
            // Cierra la configuración de Row.
          ),
          // Crea un espacio o caja de tamaño fijo con valores constantes.
          const SizedBox(height: 14),
          // Crea un texto visible.
          Text(
            // Utiliza solicitud.mensaje como parte de la operación actual.
            solicitud.mensaje,
            // Establece el máximo de líneas al valor indicado.
            maxLines: lineasMensaje,
            // Establece cómo se muestra un texto que no cabe al valor indicado.
            overflow: TextOverflow.ellipsis,
            // Establece el estilo visual al valor indicado.
            style: const TextStyle(
              // Establece la familia tipográfica al valor indicado.
              fontFamily: AppTextStyles.inter,
              // Establece el tamaño de la letra al valor indicado.
              fontSize: 14,
              // Establece la altura al valor indicado.
              height: 1.45,
              // Establece el color al valor indicado.
              color: AppColors.moradoOscuro,
              // Cierra la configuración de TextStyle.
            ),
            // Cierra la configuración de Text.
          ),
          // Comprueba (mostrarAcciones) ...[ para decidir si se ejecuta esta parte. Los puntos ... incorporan los elementos directamente a la lista.
          if (mostrarAcciones) ...[
            // Crea un espacio o caja de tamaño fijo con valores constantes.
            const SizedBox(height: 16),
            // Crea una fila de componentes.
            Row(
              // Establece la lista de componentes visuales hijos al valor indicado.
              children: [
                // Crea un componente que ocupa el espacio restante.
                Expanded(
                  // Establece el único componente visual contenido al valor indicado.
                  child: SecondaryButton(
                    // Establece el texto que se va a utilizar al valor indicado.
                    texto: 'Rechazar',
                    // Establece si el botón representa una acción de rechazo al valor indicado.
                    peligro: true,
                    // Establece la altura del componente al valor indicado.
                    altura: 44,
                    // Establece si se muestra el indicador de carga.
                    cargando:
                        // Evalúa enProceso && como parte del resultado actual.
                        enProceso &&
                        // Actualiza accionEnProceso con = EstadoSolicitud.rechazada.
                        accionEnProceso == EstadoSolicitud.rechazada,
                    // Establece la acción al presionar el botón al valor indicado. La expresión ? : elige un valor según la condición.
                    alPresionar: enProceso ? null : alRechazar,
                    // Cierra la configuración de SecondaryButton.
                  ),
                  // Cierra la configuración de Expanded.
                ),
                // Crea un espacio o caja de tamaño fijo con valores constantes.
                const SizedBox(width: 12),
                // Crea un componente que ocupa el espacio restante.
                Expanded(
                  // Establece el único componente visual contenido al valor indicado.
                  child: PrimaryButton(
                    // Establece el texto que se va a utilizar al valor indicado.
                    texto: 'Aceptar',
                    // Establece la altura del componente al valor indicado.
                    altura: 44,
                    // Establece si se muestra el indicador de carga.
                    cargando:
                        // Evalúa enProceso && como parte del resultado actual.
                        enProceso &&
                        // Actualiza accionEnProceso con = EstadoSolicitud.aceptada.
                        accionEnProceso == EstadoSolicitud.aceptada,
                    // Establece la acción al presionar el botón al valor indicado. La expresión ? : elige un valor según la condición.
                    alPresionar: enProceso ? null : alAceptar,
                    // Cierra la configuración de PrimaryButton.
                  ),
                  // Cierra la configuración de Expanded.
                ),
                // Cierra la lista de elementos.
              ],
              // Cierra la configuración de Row.
            ),
            // Termina el primer grupo y añade el siguiente si se cumple la nueva condición. Los puntos ... incorporan los elementos directamente a la lista.
          ] else if (mostrarRechazar) ...[
            // Crea un espacio o caja de tamaño fijo con valores constantes.
            const SizedBox(height: 6),
            // Crea un contenido con alineación específica.
            Align(
              // Establece la alineación del contenido al valor indicado.
              alignment: Alignment.centerLeft,
              // Establece el único componente visual contenido al valor indicado.
              child: Padding(
                // Establece el espacio interior alrededor del contenido al valor indicado.
                padding: const EdgeInsets.only(left: 40),
                // Establece el único componente visual contenido al valor indicado.
                child: TextButton(
                  // Establece la acción al presionar el botón al valor indicado. La expresión ? : elige un valor según la condición.
                  onPressed: enProceso ? null : alRechazar,
                  // Establece el estilo visual al valor indicado.
                  style: TextButton.styleFrom(
                    // Establece el color del texto y los iconos al valor indicado.
                    foregroundColor: AppColors.rechazada,
                    // Establece el espacio interior alrededor del contenido al valor indicado.
                    padding: const EdgeInsets.symmetric(
                      // Establece el espacio horizontal al valor indicado.
                      horizontal: 8,
                      // Establece el espacio vertical al valor indicado.
                      vertical: 10,
                      // Cierra la configuración de symmetric.
                    ),
                    // Establece el estilo del texto del botón al valor indicado.
                    textStyle: const TextStyle(
                      // Establece la familia tipográfica al valor indicado.
                      fontFamily: AppTextStyles.poppins,
                      // Establece el tamaño de la letra al valor indicado.
                      fontSize: 15,
                      // Establece el grosor de la letra al valor indicado.
                      fontWeight: FontWeight.w600,
                      // Cierra la configuración de TextStyle.
                    ),
                    // Cierra la configuración de styleFrom.
                  ),
                  // Establece el único componente visual contenido al valor indicado.
                  child: const Text('Rechazar'),
                  // Cierra la configuración de TextButton.
                ),
                // Cierra la configuración de Padding.
              ),
              // Cierra la configuración de Align.
            ),
            // Cierra la lista de elementos.
          ],
          // Cierra la lista de elementos.
        ],
        // Cierra la configuración de Column.
      ),
      // Cierra la configuración de Container y termina la instrucción.
    );
    // Cierra el bloque de build.
  }

  // Cierra la clase SolicitudCard.
}

/// Chip de estado con fondo tintado y texto oscuro (contraste AA).
// Define StatusChip, que representa una etiqueta de estado de solicitud.
class StatusChip extends StatelessWidget {
  // Define cómo se crea StatusChip y qué datos recibe.
  const StatusChip({super.key, required this.estado});

  // Declara el estado de la solicitud sin permitir reasignarlo.
  final EstadoSolicitud estado;

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Prepara el color de fondo elegido.
    Color fondo = AppColors.pendienteTinte;
    // Prepara el texto que se va a utilizar.
    Color texto = AppColors.pendienteTexto;
    // Prepara el color del punto del estado.
    Color punto = AppColors.ambar;

    // Comprueba (estado == EstadoSolicitud.aceptada) para decidir si se ejecuta esta parte.
    if (estado == EstadoSolicitud.aceptada) {
      // Actualiza fondo con AppColors.aceptadaTinte.
      fondo = AppColors.aceptadaTinte;
      // Actualiza texto con AppColors.aceptadaTexto.
      texto = AppColors.aceptadaTexto;
      // Actualiza punto con AppColors.aceptada.
      punto = AppColors.aceptada;
      // Si no se cumplió la condición anterior, comprueba (estado == EstadoSolicitud.rechazada).
    } else if (estado == EstadoSolicitud.rechazada) {
      // Actualiza fondo con AppColors.rechazadaTinte.
      fondo = AppColors.rechazadaTinte;
      // Actualiza texto con AppColors.rechazadaTexto.
      texto = AppColors.rechazadaTexto;
      // Actualiza punto con AppColors.rechazada.
      punto = AppColors.rechazada;
      // Cierra el bloque de if.
    }

    // Devuelve un contenedor con tamaño y decoración con la configuración siguiente.
    return Container(
      // Establece el espacio interior alrededor del contenido al valor indicado.
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      // Establece la decoración de fondo, bordes o campo al valor indicado.
      decoration: BoxDecoration(
        // Establece el color al valor indicado.
        color: fondo,
        // Establece el redondeado de las esquinas al valor indicado.
        borderRadius: BorderRadius.circular(AppRadii.pildora),
        // Cierra la configuración de BoxDecoration.
      ),
      // Establece el único componente visual contenido al valor indicado.
      child: Row(
        // Establece el espacio que ocupa el eje principal al valor indicado.
        mainAxisSize: MainAxisSize.min,
        // Establece la lista de componentes visuales hijos al valor indicado.
        children: [
          // Crea un contenedor con tamaño y decoración.
          Container(
            // Establece el ancho al valor indicado.
            width: 8,
            // Establece la altura al valor indicado.
            height: 8,
            // Establece la decoración de fondo, bordes o campo al valor indicado.
            decoration: BoxDecoration(color: punto, shape: BoxShape.circle),
            // Cierra la configuración de Container.
          ),
          // Crea un espacio o caja de tamaño fijo con valores constantes.
          const SizedBox(width: 8),
          // Crea un texto visible.
          Text(
            // Utiliza estado.etiqueta como parte de la operación actual.
            estado.etiqueta,
            // Establece el estilo visual al valor indicado.
            style: AppTextStyles.chipEstado.copyWith(
              // Establece el color al valor indicado.
              color: texto,
              // Establece el tamaño de la letra al valor indicado.
              fontSize: 14,
              // Cierra la configuración de copyWith.
            ),
            // Cierra la configuración de Text.
          ),
          // Cierra la lista de elementos.
        ],
        // Cierra la configuración de Row.
      ),
      // Cierra la configuración de Container y termina la instrucción.
    );
    // Cierra el bloque de build.
  }

  // Cierra la clase StatusChip.
}
