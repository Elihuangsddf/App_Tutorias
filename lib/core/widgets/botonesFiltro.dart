// Importa los componentes visuales y estilos Material de Flutter.
import 'package:flutter/material.dart';

// Importa temaAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/theme/temaAplicacion.dart';

/// Chip de filtro o de selección única.
///
/// Sin seleccionar: blanco con borde. Seleccionado: morado con texto blanco.
// Define FilterPill, que representa un botón de filtro.
class FilterPill extends StatelessWidget {
  // Define cómo se crea FilterPill y qué datos recibe.
  const FilterPill({
    // Entrega a Flutter la clave opcional que identifica este componente.
    super.key,
    // Solicita el texto que se va a utilizar.
    required this.texto,
    // Solicita si el filtro está seleccionado.
    required this.seleccionado,
    // Recibe como opción la acción al tocar el componente.
    this.alTocar,
    // Cierra el bloque de FilterPill y termina la instrucción.
  });

  // Declara el texto que se va a utilizar sin permitir reasignarlo.
  final String texto;
  // Declara si el filtro está seleccionado sin permitir reasignarlo.
  final bool seleccionado;
  // Declara la acción al tocar el componente sin permitir reasignarlo. El signo ? del tipo permite que este dato sea null.
  final VoidCallback? alTocar;

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Devuelve una superficie con el comportamiento visual de Material con la configuración siguiente.
    return Material(
      // Establece el color al valor indicado. La expresión ? : elige un valor según la condición.
      color: seleccionado ? AppColors.morado : AppColors.superficie,
      // Establece la forma del componente al valor indicado.
      shape: RoundedRectangleBorder(
        // Establece el redondeado de las esquinas al valor indicado.
        borderRadius: BorderRadius.circular(AppRadii.pildora),
        // Establece el borde de la forma o del botón al valor indicado.
        side: BorderSide(
          // Establece el color al valor indicado. La expresión ? : elige un valor según la condición.
          color: seleccionado ? AppColors.morado : AppColors.borde,
          // Cierra la configuración de BorderSide.
        ),
        // Cierra la configuración de RoundedRectangleBorder.
      ),
      // Establece el único componente visual contenido al valor indicado.
      child: InkWell(
        // Establece la acción al tocar el componente al valor indicado.
        onTap: alTocar,
        // Establece el redondeado de las esquinas al valor indicado.
        borderRadius: BorderRadius.circular(AppRadii.pildora),
        // Establece el único componente visual contenido al valor indicado.
        child: Padding(
          // Establece el espacio interior alrededor del contenido al valor indicado.
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          // Establece el único componente visual contenido al valor indicado.
          child: Text(
            // Utiliza texto como parte de la operación actual.
            texto,
            // Establece el estilo visual al valor indicado.
            style: AppTextStyles.chip.copyWith(
              // Establece el color al valor indicado. La expresión ? : elige un valor según la condición.
              color: seleccionado ? Colors.white : AppColors.moradoOscuro,
              // Cierra la configuración de copyWith.
            ),
            // Cierra la configuración de Text.
          ),
          // Cierra la configuración de Padding.
        ),
        // Cierra la configuración de InkWell.
      ),
      // Cierra la configuración de Material y termina la instrucción.
    );
    // Cierra el bloque de build.
  }

  // Cierra la clase FilterPill.
}

/// Etiqueta estática usada en el detalle del tutor.
// Define InfoPill, que representa el componente info pill.
class InfoPill extends StatelessWidget {
  // Define cómo se crea InfoPill y qué datos recibe.
  const InfoPill({super.key, required this.texto});

  // Declara el texto que se va a utilizar sin permitir reasignarlo.
  final String texto;

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Devuelve un contenedor con tamaño y decoración con la configuración siguiente.
    return Container(
      // Establece el espacio interior alrededor del contenido al valor indicado.
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
      // Establece la decoración de fondo, bordes o campo al valor indicado.
      decoration: BoxDecoration(
        // Establece el color al valor indicado.
        color: AppColors.superficie,
        // Establece el redondeado de las esquinas al valor indicado.
        borderRadius: BorderRadius.circular(AppRadii.pildora),
        // Establece el borde al valor indicado.
        border: Border.all(color: AppColors.borde),
        // Cierra la configuración de BoxDecoration.
      ),
      // Establece el único componente visual contenido al valor indicado.
      child: Text(texto, style: AppTextStyles.chip),
      // Cierra la configuración de Container y termina la instrucción.
    );
    // Cierra el bloque de build.
  }

  // Cierra la clase InfoPill.
}
