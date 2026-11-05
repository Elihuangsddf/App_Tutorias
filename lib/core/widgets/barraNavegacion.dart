// Importa los componentes visuales y estilos Material de Flutter.
import 'package:flutter/material.dart';

// Importa temaAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/theme/temaAplicacion.dart';

// Define las opciones permitidas para los destinos de la barra inferior.
enum DestinoInferior { tutores, solicitudes }

/// Barra inferior de dos destinos, solo para el rol alumno.
///
/// Figma usa círculos (lleno = activo, contorno = inactivo) en lugar de iconos.
// Define AppBottomNav, que representa la navegación inferior.
class AppBottomNav extends StatelessWidget {
  // Define cómo se crea AppBottomNav y qué datos recibe.
  const AppBottomNav({super.key, required this.activo, required this.alTocar});

  // Declara el destino o estado activo sin permitir reasignarlo.
  final DestinoInferior activo;
  // Declara la acción al tocar el componente sin permitir reasignarlo.
  final ValueChanged<DestinoInferior> alTocar;

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Devuelve un contenedor con tamaño y decoración con la configuración siguiente.
    return Container(
      // Establece la decoración de fondo, bordes o campo al valor indicado.
      decoration: const BoxDecoration(
        // Establece el color al valor indicado.
        color: AppColors.superficie,
        // Establece el borde al valor indicado.
        border: Border(top: BorderSide(color: AppColors.borde)),
        // Cierra la configuración de BoxDecoration.
      ),
      // Establece el único componente visual contenido al valor indicado.
      child: SafeArea(
        // Establece el tratamiento del borde superior al valor indicado.
        top: false,
        // Establece el único componente visual contenido al valor indicado.
        child: SizedBox(
          // Establece la altura al valor indicado.
          height: 64,
          // Establece el único componente visual contenido al valor indicado.
          child: Row(
            // Establece la lista de componentes visuales hijos al valor indicado.
            children: [
              // Utiliza _Item con los argumentos indicados.
              _Item(
                // Establece la etiqueta visible al valor indicado.
                etiqueta: 'Tutores',
                // Establece el destino o estado activo al valor indicado.
                activo: activo == DestinoInferior.tutores,
                // Define la acción al tocar el componente mediante una función.
                alTocar: () {
                  // Devuelve alTocar(DestinoInferior.tutores) como resultado de esta función.
                  return alTocar(DestinoInferior.tutores);
                  // Cierra el bloque de instrucciones.
                },
                // Cierra la configuración de _Item.
              ),
              // Utiliza _Item con los argumentos indicados.
              _Item(
                // Establece la etiqueta visible al valor indicado.
                etiqueta: 'Solicitudes',
                // Establece el destino o estado activo al valor indicado.
                activo: activo == DestinoInferior.solicitudes,
                // Define la acción al tocar el componente mediante una función.
                alTocar: () {
                  // Devuelve alTocar(DestinoInferior.solicitudes) como resultado de esta función.
                  return alTocar(DestinoInferior.solicitudes);
                  // Cierra el bloque de instrucciones.
                },
                // Cierra la configuración de _Item.
              ),
              // Cierra la lista de elementos.
            ],
            // Cierra la configuración de Row.
          ),
          // Cierra la configuración de SizedBox.
        ),
        // Cierra la configuración de SafeArea.
      ),
      // Cierra la configuración de Container y termina la instrucción.
    );
    // Cierra el bloque de build.
  }

  // Cierra la clase AppBottomNav.
}

// Define _Item, que representa el componente item.
class _Item extends StatelessWidget {
  // Define cómo se crea _Item y qué datos recibe.
  const _Item({
    // Solicita la etiqueta visible.
    required this.etiqueta,
    // Solicita el destino o estado activo.
    required this.activo,
    // Solicita la acción al tocar el componente.
    required this.alTocar,
    // Cierra el bloque de _Item y termina la instrucción.
  });

  // Declara la etiqueta visible sin permitir reasignarlo.
  final String etiqueta;
  // Declara el destino o estado activo sin permitir reasignarlo.
  final bool activo;
  // Declara la acción al tocar el componente sin permitir reasignarlo.
  final VoidCallback alTocar;

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Devuelve un componente que ocupa el espacio restante con la configuración siguiente.
    return Expanded(
      // Establece el único componente visual contenido al valor indicado.
      child: InkWell(
        // Establece la acción al tocar el componente al valor indicado.
        onTap: alTocar,
        // Establece el único componente visual contenido al valor indicado.
        child: Column(
          // Establece la distribución de los elementos en el eje principal al valor indicado.
          mainAxisAlignment: MainAxisAlignment.center,
          // Establece la lista de componentes visuales hijos al valor indicado.
          children: [
            // Crea un contenedor con tamaño y decoración.
            Container(
              // Establece el ancho al valor indicado.
              width: 18,
              // Establece la altura al valor indicado.
              height: 18,
              // Establece la decoración de fondo, bordes o campo al valor indicado.
              decoration: BoxDecoration(
                // Establece la forma del componente al valor indicado.
                shape: BoxShape.circle,
                // Establece el color al valor indicado. La expresión ? : elige un valor según la condición.
                color: activo ? AppColors.morado : Colors.transparent,
                // Establece el borde al valor indicado.
                border: activo
                    // Recibe null con tipo ?.
                    ? null
                    // Usa esta alternativa cuando la condición anterior es falsa.
                    : Border.all(color: AppColors.textoSecundario, width: 1.8),
                // Cierra la configuración de BoxDecoration.
              ),
              // Cierra la configuración de Container.
            ),
            // Crea un espacio o caja de tamaño fijo con valores constantes.
            const SizedBox(height: 8),
            // Crea un texto visible.
            Text(
              // Utiliza etiqueta como parte de la operación actual.
              etiqueta,
              // Establece el estilo visual al valor indicado.
              style: TextStyle(
                // Establece la familia tipográfica al valor indicado.
                fontFamily: AppTextStyles.inter,
                // Establece el tamaño de la letra al valor indicado.
                fontSize: 13,
                // Establece la altura al valor indicado.
                height: 1,
                // Establece el grosor de la letra al valor indicado. La expresión ? : elige un valor según la condición.
                fontWeight: activo ? FontWeight.w600 : FontWeight.w500,
                // Establece el color al valor indicado. La expresión ? : elige un valor según la condición.
                color: activo ? AppColors.morado : AppColors.textoSecundario,
                // Cierra la configuración de TextStyle.
              ),
              // Cierra la configuración de Text.
            ),
            // Cierra la lista de elementos.
          ],
          // Cierra la configuración de Column.
        ),
        // Cierra la configuración de InkWell.
      ),
      // Cierra la configuración de Expanded y termina la instrucción.
    );
    // Cierra el bloque de build.
  }

  // Cierra la clase _Item.
}
