// Importa los componentes visuales y estilos Material de Flutter.
import 'package:flutter/material.dart';

// Importa temaAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/theme/temaAplicacion.dart';

/// Botón principal de 48 px (44 px en variantes compactas).
///
/// Cuando [cargando] es verdadero muestra un spinner, conserva el color morado
/// y deshabilita la acción.
// Define PrimaryButton, que representa un botón principal reutilizable.
class PrimaryButton extends StatelessWidget {
  // Define cómo se crea PrimaryButton y qué datos recibe.
  const PrimaryButton({
    // Entrega a Flutter la clave opcional que identifica este componente.
    super.key,
    // Solicita el texto que se va a utilizar.
    required this.texto,
    // Recibe como opción la acción al presionar el botón.
    this.alPresionar,
    // Recibe como opción el icono del componente.
    this.icono,
    // Recibe como opción si se muestra el indicador de carga.
    this.cargando = false,
    // Recibe como opción la altura del componente.
    this.altura = 48,
    // Cierra el bloque de PrimaryButton y termina la instrucción.
  });

  // Declara el texto que se va a utilizar sin permitir reasignarlo.
  final String texto;
  // Declara la acción al presionar el botón sin permitir reasignarlo. El signo ? del tipo permite que este dato sea null.
  final VoidCallback? alPresionar;
  // Declara el icono del componente sin permitir reasignarlo. El signo ? del tipo permite que este dato sea null.
  final IconData? icono;
  // Declara si se muestra el indicador de carga sin permitir reasignarlo.
  final bool cargando;
  // Declara la altura del componente sin permitir reasignarlo.
  final double altura;

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Prepara habilitado sin permitir reasignarlo.
    final habilitado = !cargando && alPresionar != null;

    // Devuelve un espacio o caja de tamaño fijo con la configuración siguiente.
    return SizedBox(
      // Establece la altura al valor indicado.
      height: altura,
      // Establece el ancho al valor indicado.
      width: double.infinity,
      // Establece el único componente visual contenido al valor indicado.
      child: FilledButton(
        // Establece la acción al presionar el botón al valor indicado. La expresión ? : elige un valor según la condición.
        onPressed: habilitado ? alPresionar : null,
        // Establece el estilo visual al valor indicado.
        style: FilledButton.styleFrom(
          // Establece el fondo del botón deshabilitado al valor indicado.
          disabledBackgroundColor: cargando
              // Usa esta alternativa cuando la condición anterior es verdadera.
              ? AppColors.morado
              // Usa esta alternativa cuando la condición anterior es falsa.
              : AppColors.deshabilitado,
          // Establece el texto del botón deshabilitado al valor indicado.
          disabledForegroundColor: Colors.white,
          // Establece el espacio interior alrededor del contenido al valor indicado.
          padding: const EdgeInsets.symmetric(horizontal: 16),
          // Cierra la configuración de styleFrom.
        ),
        // Establece el único componente visual contenido al valor indicado.
        child: Row(
          // Establece la distribución de los elementos en el eje principal al valor indicado.
          mainAxisAlignment: MainAxisAlignment.center,
          // Establece la lista de componentes visuales hijos al valor indicado.
          children: [
            // Comprueba (cargando) ...[ para decidir si se ejecuta esta parte. Los puntos ... incorporan los elementos directamente a la lista.
            if (cargando) ...[
              // Crea un espacio o caja de tamaño fijo con valores constantes.
              const SizedBox(
                // Establece el ancho al valor indicado.
                width: 18,
                // Establece la altura al valor indicado.
                height: 18,
                // Establece el único componente visual contenido al valor indicado.
                child: CircularProgressIndicator(
                  // Establece el grosor del trazo al valor indicado.
                  strokeWidth: 2,
                  // Establece el color al valor indicado.
                  color: Colors.white,
                  // Cierra la configuración de CircularProgressIndicator.
                ),
                // Cierra la configuración de SizedBox.
              ),
              // Crea un espacio o caja de tamaño fijo con valores constantes.
              const SizedBox(width: 10),
              // Termina el primer grupo y añade el siguiente si se cumple la nueva condición. Los puntos ... incorporan los elementos directamente a la lista.
            ] else if (icono != null) ...[
              // Crea un icono.
              Icon(icono, size: 20, color: Colors.white),
              // Crea un espacio o caja de tamaño fijo con valores constantes.
              const SizedBox(width: 10),
              // Cierra la lista de elementos.
            ],
            // Utiliza Flexible con los argumentos indicados.
            Flexible(
              // Establece el único componente visual contenido al valor indicado.
              child: Text(
                // Utiliza texto como parte de la operación actual.
                texto,
                // Establece el máximo de líneas al valor indicado.
                maxLines: 1,
                // Establece cómo se muestra un texto que no cabe al valor indicado.
                overflow: TextOverflow.ellipsis,
                // Establece el estilo visual al valor indicado.
                style: AppTextStyles.boton,
                // Cierra la configuración de Text.
              ),
              // Cierra la configuración de Flexible.
            ),
            // Cierra la lista de elementos.
          ],
          // Cierra la configuración de Row.
        ),
        // Cierra la configuración de FilledButton.
      ),
      // Cierra la configuración de SizedBox y termina la instrucción.
    );
    // Cierra el bloque de build.
  }

  // Cierra la clase PrimaryButton.
}

/// Botón secundario. Con [peligro] usa el rojo de "rechazada".
// Define SecondaryButton, que representa un botón secundario reutilizable.
class SecondaryButton extends StatelessWidget {
  // Define cómo se crea SecondaryButton y qué datos recibe.
  const SecondaryButton({
    // Entrega a Flutter la clave opcional que identifica este componente.
    super.key,
    // Solicita el texto que se va a utilizar.
    required this.texto,
    // Recibe como opción la acción al presionar el botón.
    this.alPresionar,
    // Recibe como opción el icono del componente.
    this.icono,
    // Recibe como opción si el botón representa una acción de rechazo.
    this.peligro = false,
    // Recibe como opción si se muestra el indicador de carga.
    this.cargando = false,
    // Recibe como opción la altura del componente.
    this.altura = 48,
    // Cierra el bloque de SecondaryButton y termina la instrucción.
  });

  // Declara el texto que se va a utilizar sin permitir reasignarlo.
  final String texto;
  // Declara la acción al presionar el botón sin permitir reasignarlo. El signo ? del tipo permite que este dato sea null.
  final VoidCallback? alPresionar;
  // Declara el icono del componente sin permitir reasignarlo. El signo ? del tipo permite que este dato sea null.
  final IconData? icono;
  // Declara si el botón representa una acción de rechazo sin permitir reasignarlo.
  final bool peligro;
  // Declara si se muestra el indicador de carga sin permitir reasignarlo.
  final bool cargando;
  // Declara la altura del componente sin permitir reasignarlo.
  final double altura;

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Prepara el color sin permitir reasignarlo. La expresión ? : elige un valor según la condición.
    final color = peligro ? AppColors.rechazada : AppColors.morado;
    // Prepara habilitado sin permitir reasignarlo.
    final habilitado = !cargando && alPresionar != null;

    // Devuelve un espacio o caja de tamaño fijo con la configuración siguiente.
    return SizedBox(
      // Establece la altura al valor indicado.
      height: altura,
      // Establece el ancho al valor indicado.
      width: double.infinity,
      // Establece el único componente visual contenido al valor indicado.
      child: OutlinedButton(
        // Establece la acción al presionar el botón al valor indicado. La expresión ? : elige un valor según la condición.
        onPressed: habilitado ? alPresionar : null,
        // Establece el estilo visual al valor indicado.
        style: OutlinedButton.styleFrom(
          // Establece el color del texto y los iconos al valor indicado.
          foregroundColor: color,
          // Establece el color de fondo al valor indicado.
          backgroundColor: AppColors.superficie,
          // Establece el texto del botón deshabilitado al valor indicado.
          disabledForegroundColor: AppColors.deshabilitado,
          // Establece el borde de la forma o del botón al valor indicado.
          side: BorderSide(
            // Establece el color al valor indicado. La expresión ? : elige un valor según la condición.
            color: habilitado || cargando ? color : AppColors.deshabilitado,
            // Establece el ancho al valor indicado.
            width: 1.2,
            // Cierra la configuración de BorderSide.
          ),
          // Establece el espacio interior alrededor del contenido al valor indicado.
          padding: const EdgeInsets.symmetric(horizontal: 12),
          // Cierra la configuración de styleFrom.
        ),
        // Establece el único componente visual contenido al valor indicado.
        child: Row(
          // Establece la distribución de los elementos en el eje principal al valor indicado.
          mainAxisAlignment: MainAxisAlignment.center,
          // Establece la lista de componentes visuales hijos al valor indicado.
          children: [
            // Comprueba (cargando) ...[ para decidir si se ejecuta esta parte. Los puntos ... incorporan los elementos directamente a la lista.
            if (cargando) ...[
              // Crea un espacio o caja de tamaño fijo.
              SizedBox(
                // Establece el ancho al valor indicado.
                width: 17,
                // Establece la altura al valor indicado.
                height: 17,
                // Establece el único componente visual contenido al valor indicado.
                child: CircularProgressIndicator(strokeWidth: 2, color: color),
                // Cierra la configuración de SizedBox.
              ),
              // Crea un espacio o caja de tamaño fijo con valores constantes.
              const SizedBox(width: 8),
              // Termina el primer grupo y añade el siguiente si se cumple la nueva condición. Los puntos ... incorporan los elementos directamente a la lista.
            ] else if (icono != null) ...[
              // Crea un icono.
              Icon(icono, size: 19, color: color),
              // Crea un espacio o caja de tamaño fijo con valores constantes.
              const SizedBox(width: 8),
              // Cierra la lista de elementos.
            ],
            // Utiliza Flexible con los argumentos indicados.
            Flexible(
              // Establece el único componente visual contenido al valor indicado.
              child: Text(
                // Utiliza texto como parte de la operación actual.
                texto,
                // Establece el máximo de líneas al valor indicado.
                maxLines: 1,
                // Establece cómo se muestra un texto que no cabe al valor indicado.
                overflow: TextOverflow.ellipsis,
                // Establece el estilo visual al valor indicado.
                style: TextStyle(
                  // Establece la familia tipográfica al valor indicado.
                  fontFamily: AppTextStyles.poppins,
                  // Establece el tamaño de la letra al valor indicado.
                  fontSize: 15,
                  // Establece el grosor de la letra al valor indicado.
                  fontWeight: FontWeight.w600,
                  // Establece el color al valor indicado.
                  color: habilitado || cargando
                      // Recibe el color con tipo ?.
                      ? color
                      // Usa esta alternativa cuando la condición anterior es falsa.
                      : AppColors.deshabilitado,
                  // Cierra la configuración de TextStyle.
                ),
                // Cierra la configuración de Text.
              ),
              // Cierra la configuración de Flexible.
            ),
            // Cierra la lista de elementos.
          ],
          // Cierra la configuración de Row.
        ),
        // Cierra la configuración de OutlinedButton.
      ),
      // Cierra la configuración de SizedBox y termina la instrucción.
    );
    // Cierra el bloque de build.
  }

  // Cierra la clase SecondaryButton.
}
