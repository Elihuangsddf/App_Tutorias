// Importa los componentes visuales y estilos Material de Flutter.
import 'package:flutter/material.dart';
// Importa las herramientas de entrada y de las barras del sistema.
import 'package:flutter/services.dart';

// Importa temaAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/theme/temaAplicacion.dart';

/// Campo de texto con etiqueta visible, mensaje de ayuda/error y contador.
// Define AppTextField, que representa un campo de texto con etiqueta y ayuda.
class AppTextField extends StatelessWidget {
  // Define cómo se crea AppTextField y qué datos recibe.
  const AppTextField({
    // Entrega a Flutter la clave opcional que identifica este componente.
    super.key,
    // Recibe como opción la etiqueta visible.
    this.etiqueta,
    // Recibe como opción el ejemplo mostrado mientras el campo está vacío.
    this.textoEjemplo,
    // Recibe como opción el controlador del texto.
    this.controlador,
    // Recibe como opción si el campo oculta su texto.
    this.ocultarTexto = false,
    // Recibe como opción el mínimo de líneas del campo.
    this.lineasMinimas = 1,
    // Recibe como opción el máximo de líneas del campo.
    this.lineasMaximas = 1,
    // Recibe como opción el tipo de teclado.
    this.tipoTeclado,
    // Recibe como opción la acción del teclado.
    this.accionTeclado,
    // Recibe como opción las reglas que limitan la entrada.
    this.formatosEntrada,
    // Recibe como opción la acción al cambiar el texto.
    this.alCambiar,
    // Recibe como opción el error del campo.
    this.errorTexto,
    // Recibe como opción la ayuda inferior del campo.
    this.textoAyuda,
    // Recibe como opción el contador de caracteres.
    this.contadorTexto,
    // Recibe como opción si el contador llegó al límite.
    this.contadorAlLimite = false,
    // Recibe como opción habilitado.
    this.habilitado = true,
    // Recibe como opción resaltar error.
    this.resaltarError = false,
    // Cierra el bloque de AppTextField y termina la instrucción.
  });

  // Declara la etiqueta visible sin permitir reasignarlo. El signo ? del tipo permite que este dato sea null.
  final String? etiqueta;
  // Declara el ejemplo mostrado mientras el campo está vacío sin permitir reasignarlo. El signo ? del tipo permite que este dato sea null.
  final String? textoEjemplo;
  // Declara el controlador del texto sin permitir reasignarlo. El signo ? del tipo permite que este dato sea null.
  final TextEditingController? controlador;
  // Declara si el campo oculta su texto sin permitir reasignarlo.
  final bool ocultarTexto;
  // Declara el mínimo de líneas del campo sin permitir reasignarlo.
  final int lineasMinimas;
  // Declara el máximo de líneas del campo sin permitir reasignarlo.
  final int lineasMaximas;
  // Declara el tipo de teclado sin permitir reasignarlo. El signo ? del tipo permite que este dato sea null.
  final TextInputType? tipoTeclado;
  // Declara la acción del teclado sin permitir reasignarlo. El signo ? del tipo permite que este dato sea null.
  final TextInputAction? accionTeclado;
  // Declara las reglas que limitan la entrada sin permitir reasignarlo.
  final List<TextInputFormatter>? formatosEntrada;
  // Declara la acción al cambiar el texto sin permitir reasignarlo.
  final ValueChanged<String>? alCambiar;
  // Declara el error del campo sin permitir reasignarlo. El signo ? del tipo permite que este dato sea null.
  final String? errorTexto;
  // Declara la ayuda inferior del campo sin permitir reasignarlo. El signo ? del tipo permite que este dato sea null.
  final String? textoAyuda;
  // Declara el contador de caracteres sin permitir reasignarlo. El signo ? del tipo permite que este dato sea null.
  final String? contadorTexto;
  // Declara si el contador llegó al límite sin permitir reasignarlo.
  final bool contadorAlLimite;
  // Declara habilitado sin permitir reasignarlo.
  final bool habilitado;
  // Declara resaltar error sin permitir reasignarlo.
  final bool resaltarError;

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Prepara con error sin permitir reasignarlo.
    final conError = resaltarError || errorTexto != null;
    // Prepara mensaje inferior sin permitir reasignarlo. Si el dato es null, usa la alternativa situada después de ??.
    final mensajeInferior = errorTexto ?? textoAyuda;
    // Prepara tiene fila inferior sin permitir reasignarlo.
    final tieneFilaInferior = mensajeInferior != null || contadorTexto != null;

    // Devuelve una columna de componentes con la configuración siguiente.
    return Column(
      // Establece la alineación en el eje transversal al valor indicado.
      crossAxisAlignment: CrossAxisAlignment.start,
      // Establece la lista de componentes visuales hijos al valor indicado.
      children: [
        // Comprueba (etiqueta != null) ...[ para decidir si se ejecuta esta parte. Los puntos ... incorporan los elementos directamente a la lista.
        if (etiqueta != null) ...[
          // Crea un texto visible. El signo ! afirma que ese dato no es null en este punto.
          Text(etiqueta!, style: AppTextStyles.etiquetaCampo),
          // Crea un espacio o caja de tamaño fijo con valores constantes.
          const SizedBox(height: 8),
          // Cierra la lista de elementos.
        ],
        // Crea un campo editable.
        TextField(
          // Establece el controlador que guarda el texto del campo al valor indicado.
          controller: controlador,
          // Establece si se ocultan los caracteres escritos al valor indicado.
          obscureText: ocultarTexto,
          // Establece el mínimo de líneas al valor indicado. La expresión ? : elige un valor según la condición.
          minLines: ocultarTexto ? 1 : lineasMinimas,
          // Establece el máximo de líneas al valor indicado. La expresión ? : elige un valor según la condición.
          maxLines: ocultarTexto ? 1 : lineasMaximas,
          // Establece el tipo de teclado al valor indicado.
          keyboardType: tipoTeclado,
          // Establece la acción del teclado al valor indicado.
          textInputAction: accionTeclado,
          // Establece las reglas que limitan la entrada al valor indicado.
          inputFormatters: formatosEntrada,
          // Establece la acción al cambiar el texto al valor indicado.
          onChanged: alCambiar,
          // Establece si se permite editar el campo al valor indicado.
          enabled: habilitado,
          // Establece el estilo visual al valor indicado.
          style: const TextStyle(
            // Establece la familia tipográfica al valor indicado.
            fontFamily: AppTextStyles.inter,
            // Establece el tamaño de la letra al valor indicado.
            fontSize: 15,
            // Establece la altura al valor indicado.
            height: 1.4,
            // Establece el color al valor indicado.
            color: AppColors.moradoOscuro,
            // Cierra la configuración de TextStyle.
          ),
          // Establece la decoración de fondo, bordes o campo al valor indicado.
          decoration: InputDecoration(
            // Establece el texto de ejemplo del campo al valor indicado.
            hintText: textoEjemplo,
            // Establece el borde del campo habilitado al valor indicado.
            enabledBorder: conError
                // Usa esta alternativa cuando la condición anterior es verdadera.
                ? const OutlineInputBorder(
                    // Establece el redondeado de las esquinas al valor indicado.
                    borderRadius: BorderRadius.all(
                      // Ejecuta circular sobre Radius.
                      Radius.circular(AppRadii.campo),
                      // Cierra la configuración de all.
                    ),
                    // Establece el color y grosor del borde al valor indicado.
                    borderSide: BorderSide(
                      // Establece el color al valor indicado.
                      color: AppColors.rechazada,
                      // Establece el ancho al valor indicado.
                      width: 1.4,
                      // Cierra la configuración de BorderSide.
                    ),
                    // Cierra la configuración de OutlineInputBorder.
                  )
                // Usa esta alternativa cuando la condición anterior es falsa.
                : null,
            // Establece el borde del campo seleccionado al valor indicado.
            focusedBorder: conError
                // Usa esta alternativa cuando la condición anterior es verdadera.
                ? const OutlineInputBorder(
                    // Establece el redondeado de las esquinas al valor indicado.
                    borderRadius: BorderRadius.all(
                      // Ejecuta circular sobre Radius.
                      Radius.circular(AppRadii.campo),
                      // Cierra la configuración de all.
                    ),
                    // Establece el color y grosor del borde al valor indicado.
                    borderSide: BorderSide(
                      // Establece el color al valor indicado.
                      color: AppColors.rechazada,
                      // Establece el ancho al valor indicado.
                      width: 1.6,
                      // Cierra la configuración de BorderSide.
                    ),
                    // Cierra la configuración de OutlineInputBorder.
                  )
                // Usa esta alternativa cuando la condición anterior es falsa.
                : null,
            // Cierra la configuración de InputDecoration.
          ),
          // Cierra la configuración de TextField.
        ),
        // Comprueba (tieneFilaInferior) ...[ para decidir si se ejecuta esta parte. Los puntos ... incorporan los elementos directamente a la lista.
        if (tieneFilaInferior) ...[
          // Crea un espacio o caja de tamaño fijo con valores constantes.
          const SizedBox(height: 8),
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
                  // Evalúa mensajeInferior ?? '' como parte del resultado actual. Si el dato es null, usa la alternativa situada después de ??.
                  mensajeInferior ?? '',
                  // Establece el estilo visual al valor indicado.
                  style: AppTextStyles.etiqueta.copyWith(
                    // Establece el color al valor indicado.
                    color: errorTexto != null
                        // Usa esta alternativa cuando la condición anterior es verdadera.
                        ? AppColors.rechazada
                        // Usa esta alternativa cuando la condición anterior es falsa.
                        : AppColors.textoSecundario,
                    // Cierra la configuración de copyWith.
                  ),
                  // Cierra la configuración de Text.
                ),
                // Cierra la configuración de Expanded.
              ),
              // Comprueba (contadorTexto != null) para decidir si se ejecuta esta parte.
              if (contadorTexto != null)
                // Crea un texto visible.
                Text(
                  // Entrega el contador de texto; el signo ! indica que aquí se espera un valor no nulo. El signo ! afirma que ese dato no es null en este punto.
                  contadorTexto!,
                  // Establece el estilo visual al valor indicado.
                  style: AppTextStyles.etiqueta.copyWith(
                    // Establece el color al valor indicado.
                    color: contadorAlLimite
                        // Usa esta alternativa cuando la condición anterior es verdadera.
                        ? AppColors.rechazada
                        // Usa esta alternativa cuando la condición anterior es falsa.
                        : AppColors.textoSecundario,
                    // Cierra la configuración de copyWith.
                  ),
                  // Cierra la configuración de Text.
                ),
              // Cierra la lista de elementos.
            ],
            // Cierra la configuración de Row.
          ),
          // Cierra la lista de elementos.
        ],
        // Cierra la lista de elementos.
      ],
      // Cierra la configuración de Column y termina la instrucción.
    );
    // Cierra el bloque de build.
  }

  // Cierra la clase AppTextField.
}
