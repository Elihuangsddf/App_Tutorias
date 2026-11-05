// Importa los componentes visuales y estilos Material de Flutter.
import 'package:flutter/material.dart';

// Importa temaAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/theme/temaAplicacion.dart';

/// Placeholder de carga con la forma de una tarjeta de tutor.
// Define SkeletonCard, que representa una tarjeta provisional de carga.
class SkeletonCard extends StatelessWidget {
  // Define cómo se crea SkeletonCard y qué datos recibe.
  const SkeletonCard({super.key, this.altura = 104});

  // Declara la altura del componente sin permitir reasignarlo.
  final double altura;

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Devuelve un contenedor con tamaño y decoración con la configuración siguiente.
    return Container(
      // Establece la altura al valor indicado.
      height: altura,
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
      child: Row(
        // Establece la lista de componentes visuales hijos al valor indicado.
        children: [
          // Crea un contenedor con tamaño y decoración.
          Container(
            // Establece el ancho al valor indicado.
            width: 56,
            // Establece la altura al valor indicado.
            height: 56,
            // Establece la decoración de fondo, bordes o campo al valor indicado.
            decoration: const BoxDecoration(
              // Establece el color al valor indicado.
              color: AppColors.carga,
              // Establece la forma del componente al valor indicado.
              shape: BoxShape.circle,
              // Cierra la configuración de BoxDecoration.
            ),
            // Cierra la configuración de Container.
          ),
          // Crea un espacio o caja de tamaño fijo con valores constantes.
          const SizedBox(width: 16),
          // Crea un componente que ocupa el espacio restante.
          Expanded(
            // Establece el único componente visual contenido al valor indicado.
            child: Column(
              // Establece la distribución de los elementos en el eje principal al valor indicado.
              mainAxisAlignment: MainAxisAlignment.center,
              // Establece la alineación en el eje transversal al valor indicado.
              crossAxisAlignment: CrossAxisAlignment.start,
              // Establece la lista de componentes visuales hijos al valor indicado.
              children: [
                // Utiliza _Line con los argumentos indicados.
                _Line(proporcionAncho: 0.68),
                // Crea un espacio o caja de tamaño fijo con valores constantes.
                const SizedBox(height: 12),
                // Utiliza _Line con los argumentos indicados.
                _Line(proporcionAncho: 0.45),
                // Cierra la lista de elementos.
              ],
              // Cierra la configuración de Column.
            ),
            // Cierra la configuración de Expanded.
          ),
          // Crea un espacio o caja de tamaño fijo con valores constantes.
          const SizedBox(width: 12),
          // Cierra la lista de elementos.
        ],
        // Cierra la configuración de Row.
      ),
      // Cierra la configuración de Container y termina la instrucción.
    );
    // Cierra el bloque de build.
  }

  // Cierra la clase SkeletonCard.
}

// Define _Line, que representa el componente line.
class _Line extends StatelessWidget {
  // Define cómo se crea _Line y qué datos recibe.
  const _Line({required this.proporcionAncho});

  // Declara proporcion ancho sin permitir reasignarlo.
  final double proporcionAncho;

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Devuelve una caja con tamaño proporcional con la configuración siguiente.
    return FractionallySizedBox(
      // Establece la proporción del ancho disponible al valor indicado.
      widthFactor: proporcionAncho,
      // Establece el único componente visual contenido al valor indicado.
      child: Container(
        // Establece la altura al valor indicado.
        height: 12,
        // Establece la decoración de fondo, bordes o campo al valor indicado.
        decoration: BoxDecoration(
          // Establece el color al valor indicado.
          color: AppColors.carga,
          // Establece el redondeado de las esquinas al valor indicado.
          borderRadius: BorderRadius.circular(999),
          // Cierra la configuración de BoxDecoration.
        ),
        // Cierra la configuración de Container.
      ),
      // Cierra la configuración de FractionallySizedBox y termina la instrucción.
    );
    // Cierra el bloque de build.
  }

  // Cierra la clase _Line.
}

/// Placeholder genérico de bloques para el detalle del tutor.
// Define SkeletonBloque, que representa un bloque provisional de carga.
class SkeletonBloque extends StatelessWidget {
  // Define cómo se crea SkeletonBloque y qué datos recibe.
  const SkeletonBloque({
    // Entrega a Flutter la clave opcional que identifica este componente.
    super.key,
    // Recibe como opción ancho.
    this.ancho,
    // Solicita la altura del componente.
    required this.altura,
    // Recibe como opción radio.
    this.radio = 12,
    // Cierra el bloque de SkeletonBloque y termina la instrucción.
  });

  // Declara ancho sin permitir reasignarlo. El signo ? del tipo permite que este dato sea null.
  final double? ancho;
  // Declara la altura del componente sin permitir reasignarlo.
  final double altura;
  // Declara radio sin permitir reasignarlo.
  final double radio;

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Devuelve un contenedor con tamaño y decoración con la configuración siguiente.
    return Container(
      // Establece el ancho al valor indicado.
      width: ancho,
      // Establece la altura al valor indicado.
      height: altura,
      // Establece la decoración de fondo, bordes o campo al valor indicado.
      decoration: BoxDecoration(
        // Establece el color al valor indicado.
        color: AppColors.carga,
        // Establece el redondeado de las esquinas al valor indicado.
        borderRadius: BorderRadius.circular(radio),
        // Cierra la configuración de BoxDecoration.
      ),
      // Cierra la configuración de Container y termina la instrucción.
    );
    // Cierra el bloque de build.
  }

  // Cierra la clase SkeletonBloque.
}
