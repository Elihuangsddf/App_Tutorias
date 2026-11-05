// Importa package:flutter/material.dart para utilizar sus componentes y clases.
import 'package:flutter/material.dart';
// Importa package:provider/provider.dart para utilizar sus componentes y clases.
import 'package:provider/provider.dart';
// Importa botonCerrarSesion.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/core/widgets/botonCerrarSesion.dart';
// Importa controladorSesion.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/providers/controladorSesion.dart';
// Importa temaAplicacion.dart para utilizar sus componentes y clases.
import 'package:app_tutorias/core/theme/temaAplicacion.dart';

// Panel inicial propio: todavía no implementa gestión de usuarios o permisos.
class PantallaAdministrador extends StatelessWidget {
  // Crea el panel inicial del administrador con los valores indicados.
  const PantallaAdministrador({super.key});

  // Implementa un método definido por Flutter o por el contrato del repositorio.
  @override
  // Construye el contenido visual de esta pantalla.
  Widget build(BuildContext contexto) {
    // Prepara el usuario autenticado.
    final usuario = contexto.watch<SesionProvider>().usuario;
    // Devuelve la estructura de la pantalla con la configuración siguiente.
    return Scaffold(
      // Configura la barra superior.
      appBar: AppBar(
        // Configura el título visible.
        title: const Text('Panel de administración'),
        // Configura si Flutter añade automáticamente un botón para regresar.
        automaticallyImplyLeading: false,
        // Configura los botones de la barra superior.
        actions: const [SalirButton()],
        // Cierra los argumentos de la operación actual.
      ),
      // Configura el contenido principal.
      body: ListView(
        // Configura el espacio alrededor del contenido.
        padding: const EdgeInsets.all(20),
        // Configura la lista de componentes hijos.
        children: [
          // Crea un texto visible.
          Text(
            // Aporta el texto indicado a la operación actual.
            'Bienvenido, ${usuario?.nombre ?? ""}',
            // Configura style.
            style: AppTextStyles.tituloPantalla,
            // Cierra los argumentos de la operación actual.
          ),
          // Crea un espacio de tamaño fijo con los valores indicados.
          const SizedBox(height: 16),
          // Crea un texto visible con los valores indicados.
          const Text('Sesión de Administrador'),
          // Crea un espacio de tamaño fijo con los valores indicados.
          const SizedBox(height: 8),
          // Crea un texto visible.
          Text(usuario?.correo ?? ''),
          // Cierra la lista de elementos.
        ],
        // Cierra los argumentos de la operación actual.
      ),
      // Cierra los argumentos de la operación actual.
    );
    // Cierra el bloque de instrucciones o la definición.
  }

  // Cierra el bloque de instrucciones o la definición.
}
