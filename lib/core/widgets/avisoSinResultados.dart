// Importa los componentes visuales y estilos Material de Flutter.
import 'package:flutter/material.dart';

// Importa temaAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/theme/temaAplicacion.dart';
// Importa botonesAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/widgets/botonesAplicacion.dart';

/// Estado vacío, sin resultados o de error.
///
/// El icono y la acción son opcionales para respetar las variantes de Figma.
// Define EmptyState, que representa un aviso de ausencia de datos o error.
class EmptyState extends StatelessWidget {
  // Define cómo se crea EmptyState y qué datos recibe.
  const EmptyState({
    // Entrega a Flutter la clave opcional que identifica este componente.
    super.key,
    // Solicita el título visible.
    required this.titulo,
    // Solicita el texto explicativo.
    required this.subtitulo,
    // Recibe como opción el icono del componente.
    this.icono,
    // Recibe como opción el texto del botón del aviso.
    this.textoAccion,
    // Recibe como opción la acción del botón del aviso.
    this.alAccionar,
    // Recibe como opción si se utiliza una presentación reducida.
    this.compacto = false,
    // Cierra el bloque de EmptyState y termina la instrucción.
  });

  // Declara el título visible sin permitir reasignarlo.
  final String titulo;
  // Declara el texto explicativo sin permitir reasignarlo.
  final String subtitulo;
  // Declara el icono del componente sin permitir reasignarlo. El signo ? del tipo permite que este dato sea null.
  final IconData? icono;
  // Declara el texto del botón del aviso sin permitir reasignarlo. El signo ? del tipo permite que este dato sea null.
  final String? textoAccion;
  // Declara la acción del botón del aviso sin permitir reasignarlo. El signo ? del tipo permite que este dato sea null.
  final VoidCallback? alAccionar;
  // Declara si se utiliza una presentación reducida sin permitir reasignarlo.
  final bool compacto;

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Devuelve un contenido centrado con la configuración siguiente.
    return Center(
      // Establece el único componente visual contenido al valor indicado.
      child: Padding(
        // Establece el espacio interior alrededor del contenido al valor indicado.
        padding: EdgeInsets.symmetric(
          // Establece el espacio horizontal al valor indicado.
          horizontal: AppSpacing.margen,
          // Establece el espacio vertical al valor indicado. La expresión ? : elige un valor según la condición.
          vertical: compacto ? 24 : 40,
          // Cierra la configuración de symmetric.
        ),
        // Establece el único componente visual contenido al valor indicado.
        child: Column(
          // Establece el espacio que ocupa el eje principal al valor indicado.
          mainAxisSize: MainAxisSize.min,
          // Establece la lista de componentes visuales hijos al valor indicado.
          children: [
            // Comprueba (icono != null) ...[ para decidir si se ejecuta esta parte. Los puntos ... incorporan los elementos directamente a la lista.
            if (icono != null) ...[
              // Crea un icono.
              Icon(icono, size: 46, color: AppColors.textoSecundario),
              // Crea un espacio o caja de tamaño fijo con valores constantes.
              const SizedBox(height: 20),
              // Cierra la lista de elementos.
            ],
            // Crea un texto visible.
            Text(
              // Utiliza titulo como parte de la operación actual.
              titulo,
              // Establece la alineación del texto al valor indicado.
              textAlign: TextAlign.center,
              // Establece el estilo visual al valor indicado.
              style: AppTextStyles.tituloPrincipal.copyWith(
                // Establece el tamaño de la letra al valor indicado. La expresión ? : elige un valor según la condición.
                fontSize: compacto ? 20 : 23,
                // Cierra la configuración de copyWith.
              ),
              // Cierra la configuración de Text.
            ),
            // Crea un espacio o caja de tamaño fijo con valores constantes.
            const SizedBox(height: 12),
            // Crea un texto visible.
            Text(
              // Utiliza subtitulo como parte de la operación actual.
              subtitulo,
              // Establece la alineación del texto al valor indicado.
              textAlign: TextAlign.center,
              // Establece el estilo visual al valor indicado.
              style: AppTextStyles.cuerpo,
              // Cierra la configuración de Text.
            ),
            // Comprueba (textoAccion != null && alAccionar != null) ...[ para decidir si se ejecuta esta parte. Los puntos ... incorporan los elementos directamente a la lista.
            if (textoAccion != null && alAccionar != null) ...[
              // Crea un espacio o caja de tamaño fijo con valores constantes.
              const SizedBox(height: 28),
              // Crea un botón principal reutilizable. El signo ! afirma que ese dato no es null en este punto.
              PrimaryButton(texto: textoAccion!, alPresionar: alAccionar),
              // Cierra la lista de elementos.
            ],
            // Cierra la lista de elementos.
          ],
          // Cierra la configuración de Column.
        ),
        // Cierra la configuración de Padding.
      ),
      // Cierra la configuración de Center y termina la instrucción.
    );
    // Cierra el bloque de build.
  }

  // Cierra la clase EmptyState.
}
