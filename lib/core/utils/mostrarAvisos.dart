// Importa los componentes visuales y estilos Material de Flutter.
import 'package:flutter/material.dart';

// Importa temaAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/theme/temaAplicacion.dart';

/// Muestra un aviso flotante coherente con el sistema de diseño.
///
/// [exito] usa el verde de "aceptada"; [error], el rojo de "rechazada".
// Muestra un mensaje flotante de información, éxito o error.
void mostrarAviso(
  // Recibe el contexto de Flutter de esta pantalla con tipo BuildContext.
  BuildContext contexto,
  // Recibe el mensaje obligatorio y abre los parámetros opcionales con nombre.
  String mensaje, {
  // Prepara el resultado que indica si la operación funcionó.
  bool exito = false,
  // Prepara el error o su presentación.
  bool error = false,
  // Termina los parámetros opcionales e inicia el cuerpo de la función.
}) {
  // Prepara el color de fondo elegido.
  Color fondo = AppColors.moradoOscuro;
  // Prepara el texto que se va a utilizar.
  Color texto = Colors.white;
  // Prepara el icono del componente.
  IconData icono = Icons.info_outline_rounded;
  // Comprueba (error) para decidir si se ejecuta esta parte.
  if (error) {
    // Actualiza fondo con AppColors.rechazadaTinte.
    fondo = AppColors.rechazadaTinte;
    // Actualiza texto con AppColors.rechazadaTexto.
    texto = AppColors.rechazadaTexto;
    // Actualiza icono con Icons.error_outline_rounded.
    icono = Icons.error_outline_rounded;
    // Si no se cumplió la condición anterior, comprueba (exito).
  } else if (exito) {
    // Actualiza fondo con AppColors.aceptadaTinte.
    fondo = AppColors.aceptadaTinte;
    // Actualiza texto con AppColors.aceptadaTexto.
    texto = AppColors.aceptadaTexto;
    // Actualiza icono con Icons.check_circle_outline_rounded.
    icono = Icons.check_circle_outline_rounded;
    // Cierra el bloque de if.
  }

  // Prepara avisos sin permitir reasignarlo.
  final avisos = ScaffoldMessenger.of(contexto);
  // Oculta el aviso actual de avisos.
  avisos.hideCurrentSnackBar();
  // Muestra un aviso mediante avisos.
  avisos.showSnackBar(
    // Crea un aviso flotante.
    SnackBar(
      // Establece el color de fondo al valor indicado.
      backgroundColor: fondo,
      // Establece la duración del aviso al valor indicado.
      duration: const Duration(seconds: 2),
      // Establece el contenido del aviso al valor indicado.
      content: Row(
        // Establece la lista de componentes visuales hijos al valor indicado.
        children: [
          // Crea un icono.
          Icon(icono, size: 20, color: texto),
          // Crea un espacio o caja de tamaño fijo con valores constantes.
          const SizedBox(width: 10),
          // Crea un componente que ocupa el espacio restante.
          Expanded(
            // Establece el único componente visual contenido al valor indicado.
            child: Text(
              // Utiliza mensaje como parte de la operación actual.
              mensaje,
              // Establece el estilo visual al valor indicado.
              style: TextStyle(
                // Establece la familia tipográfica al valor indicado.
                fontFamily: AppTextStyles.inter,
                // Establece el tamaño de la letra al valor indicado.
                fontSize: 14,
                // Establece el grosor de la letra al valor indicado.
                fontWeight: FontWeight.w500,
                // Establece el color al valor indicado.
                color: texto,
                // Cierra la configuración de TextStyle.
              ),
              // Cierra la configuración de Text.
            ),
            // Cierra la configuración de Expanded.
          ),
          // Cierra la lista de elementos.
        ],
        // Cierra la configuración de Row.
      ),
      // Cierra la configuración de SnackBar.
    ),
    // Cierra la configuración de showSnackBar y termina la instrucción.
  );
  // Cierra el bloque de instrucciones.
}
