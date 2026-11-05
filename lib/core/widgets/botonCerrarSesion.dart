// Importa temaAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/theme/temaAplicacion.dart';
// Importa controladorSesion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/providers/controladorSesion.dart';
// Importa los componentes visuales y estilos Material de Flutter.
import 'package:flutter/material.dart';
// Importa Provider para compartir y consultar el estado de la aplicación.
import 'package:provider/provider.dart';
// Importa rutasAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/routes/rutasAplicacion.dart';

/// Botón "Salir ↗" para cerrar la sesión desde cualquier pantalla principal.
///
/// Se usa en la barra superior para que la salida esté siempre visible, incluso
/// cuando el panel tiene muchas solicitudes.
// Define SalirButton, que representa un botón para cerrar la sesión.
class SalirButton extends StatelessWidget {
  // Define cómo se crea SalirButton y qué datos recibe.
  const SalirButton({super.key});

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Devuelve TextButton.icon( como resultado de esta función.
    return TextButton.icon(
      // Define la acción al presionar el botón mediante una función.
      onPressed: () {
        // Ejecuta cerrarSesionYVolverAlInicio. Cierra la sesión y regresa al inicio de sesión sin conservar el historial.
        cerrarSesionYVolverAlInicio(contexto);
        // Cierra el bloque de instrucciones.
      },
      // Establece el icono al valor indicado.
      icon: const Icon(Icons.north_east_rounded, size: 17),
      // Establece la etiqueta del botón al valor indicado.
      label: const Text('Salir'),
      // Establece el estilo visual al valor indicado.
      style: TextButton.styleFrom(
        // Establece el color del texto y los iconos al valor indicado.
        foregroundColor: AppColors.morado,
        // Establece el espacio interior alrededor del contenido al valor indicado.
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        // Establece el estilo del texto del botón al valor indicado.
        textStyle: const TextStyle(
          // Establece la familia tipográfica al valor indicado.
          fontFamily: AppTextStyles.poppins,
          // Establece el tamaño de la letra al valor indicado.
          fontSize: 14.5,
          // Establece el grosor de la letra al valor indicado.
          fontWeight: FontWeight.w600,
          // Cierra la configuración de TextStyle.
        ),
        // Cierra la configuración de styleFrom.
      ),
      // Cierra la configuración de icon y termina la instrucción.
    );
    // Cierra el bloque de build.
  }

  // Cierra la clase SalirButton.
}

/// Cierra la sesión simulada y vuelve al inicio de sesión, limpiando el
/// historial para que no se pueda regresar con el botón "atrás".
// Cierra la sesión y regresa al inicio de sesión sin conservar el historial. async permite esperar operaciones sin bloquear la interfaz.
Future<void> cerrarSesionYVolverAlInicio(BuildContext contexto) async {
  // Prepara el controlador de la sesión sin permitir reasignarlo.
  final sesion = contexto.read<SesionProvider>();
  // Espera a que termine sesion.cerrarSesion() antes de continuar.
  await sesion.cerrarSesion();
  // Detiene la acción si la pantalla ya se eliminó.
  if (!contexto.mounted) return;

  // Conserva la pantalla actual si el cierre de sesión falló.
  if (sesion.autenticado) {
    // Termina la función sin ejecutar las instrucciones siguientes.
    return;
    // Cierra el bloque de instrucciones o la definición.
  }
  // Abre el destino elegido y actualiza el historial de navegación.
  Navigator.of(contexto).pushNamedAndRemoveUntil(AppRoutes.inicioSesion, (
    // Utiliza ruta como parte de la operación actual.
    ruta,
    // Termina los parámetros o la condición y abre el bloque de instrucciones.
  ) {
    // Devuelve false como resultado de la comprobación.
    return false;
    // Cierra el bloque de instrucciones y termina la instrucción.
  });
  // Cierra el bloque de cerrarSesionYVolverAlInicio.
}
