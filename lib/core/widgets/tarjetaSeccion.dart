// Importa los componentes visuales y estilos Material de Flutter.
import 'package:flutter/material.dart';

// Importa temaAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/theme/temaAplicacion.dart';

/// Tarjeta blanca con título opcional para agrupar contenido.
// Define SectionCard, que representa una tarjeta que agrupa una sección.
class SectionCard extends StatelessWidget {
  // Define cómo se crea SectionCard y qué datos recibe.
  const SectionCard({
    // Entrega a Flutter la clave opcional que identifica este componente.
    super.key,
    // Recibe como opción el título visible.
    this.titulo,
    // Recibe como opción el icono del componente.
    this.icono,
    // Solicita el contenido de la tarjeta.
    required this.contenido,
    // Recibe como opción el espacio interior de la tarjeta.
    this.relleno = const EdgeInsets.all(AppSpacing.tarjeta),
    // Cierra el bloque de SectionCard y termina la instrucción.
  });

  // Declara el título visible sin permitir reasignarlo. El signo ? del tipo permite que este dato sea null.
  final String? titulo;
  // Declara el icono del componente sin permitir reasignarlo. El signo ? del tipo permite que este dato sea null.
  final IconData? icono;
  // Declara el contenido de la tarjeta sin permitir reasignarlo.
  final Widget contenido;
  // Declara el espacio interior de la tarjeta sin permitir reasignarlo.
  final EdgeInsetsGeometry relleno;

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Devuelve un contenedor con tamaño y decoración con la configuración siguiente.
    return Container(
      // Establece el ancho al valor indicado.
      width: double.infinity,
      // Establece el espacio interior alrededor del contenido al valor indicado.
      padding: relleno,
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
          // Comprueba (titulo != null) ...[ para decidir si se ejecuta esta parte. Los puntos ... incorporan los elementos directamente a la lista.
          if (titulo != null) ...[
            // Crea una fila de componentes.
            Row(
              // Establece la lista de componentes visuales hijos al valor indicado.
              children: [
                // Comprueba (icono != null) ...[ para decidir si se ejecuta esta parte. Los puntos ... incorporan los elementos directamente a la lista.
                if (icono != null) ...[
                  // Crea un icono.
                  Icon(icono, size: 20, color: AppColors.morado),
                  // Crea un espacio o caja de tamaño fijo con valores constantes.
                  const SizedBox(width: 10),
                  // Cierra la lista de elementos.
                ],
                // Crea un componente que ocupa el espacio restante.
                Expanded(
                  // Establece el único componente visual contenido al valor indicado. El signo ! afirma que ese dato no es null en este punto.
                  child: Text(titulo!, style: AppTextStyles.tituloSeccion),
                  // Cierra la configuración de Expanded.
                ),
                // Cierra la lista de elementos.
              ],
              // Cierra la configuración de Row.
            ),
            // Crea un espacio o caja de tamaño fijo con valores constantes.
            const SizedBox(height: 14),
            // Cierra la lista de elementos.
          ],
          // Utiliza contenido como parte de la operación actual.
          contenido,
          // Cierra la lista de elementos.
        ],
        // Cierra la configuración de Column.
      ),
      // Cierra la configuración de Container y termina la instrucción.
    );
    // Cierra el bloque de build.
  }

  // Cierra la clase SectionCard.
}

/// Fila de icono + etiqueta + valor, usada en horarios y metadatos.
// Define LabelValueRow, que representa el componente label value row.
class LabelValueRow extends StatelessWidget {
  // Define cómo se crea LabelValueRow y qué datos recibe.
  const LabelValueRow({super.key, required this.valor, this.icono, this.extra});

  // Declara el valor recibido o almacenado sin permitir reasignarlo.
  final String valor;
  // Declara el icono del componente sin permitir reasignarlo. El signo ? del tipo permite que este dato sea null.
  final IconData? icono;
  // Declara extra sin permitir reasignarlo. El signo ? del tipo permite que este dato sea null.
  final String? extra;

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Devuelve una fila de componentes con la configuración siguiente.
    return Row(
      // Establece la lista de componentes visuales hijos al valor indicado.
      children: [
        // Comprueba (icono != null) ...[ para decidir si se ejecuta esta parte. Los puntos ... incorporan los elementos directamente a la lista.
        if (icono != null) ...[
          // Crea un icono.
          Icon(icono, size: 19, color: AppColors.textoSecundario),
          // Crea un espacio o caja de tamaño fijo con valores constantes.
          const SizedBox(width: 9),
          // Cierra la lista de elementos.
        ],
        // Crea un componente que ocupa el espacio restante.
        Expanded(
          // Establece el único componente visual contenido al valor indicado.
          child: Text(
            // Utiliza valor como parte de la operación actual.
            valor,
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
            // Cierra la configuración de Text.
          ),
          // Cierra la configuración de Expanded.
        ),
        // Comprueba (extra != null) ...[ para decidir si se ejecuta esta parte. Los puntos ... incorporan los elementos directamente a la lista.
        if (extra != null) ...[
          // Crea un espacio o caja de tamaño fijo con valores constantes.
          const SizedBox(width: 8),
          // Crea un texto visible. El signo ! afirma que ese dato no es null en este punto.
          Text(extra!, style: AppTextStyles.etiqueta),
          // Cierra la lista de elementos.
        ],
        // Cierra la lista de elementos.
      ],
      // Cierra la configuración de Row y termina la instrucción.
    );
    // Cierra el bloque de build.
  }

  // Cierra la clase LabelValueRow.
}
