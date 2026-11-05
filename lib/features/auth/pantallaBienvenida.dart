// Importa los componentes visuales y estilos Material de Flutter.
import 'package:flutter/material.dart';
// Importa las herramientas de entrada y de las barras del sistema.
import 'package:flutter/services.dart';

// Importa rutasAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/routes/rutasAplicacion.dart';
// Importa temaAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/theme/temaAplicacion.dart';
// Importa constantesAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/utils/constantesAplicacion.dart';

/// Pantalla de bienvenida.
///
/// Mantiene la marca durante 1.5 s y navega al inicio de sesión.
// Define SplashScreen, que representa la pantalla de bienvenida.
class SplashScreen extends StatefulWidget {
  // Define cómo se crea SplashScreen y qué datos recibe.
  const SplashScreen({super.key});

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Crea el objeto que guardará el estado de esta pantalla.
  State<SplashScreen> createState() {
    // Devuelve _SplashScreenState() como resultado de esta función.
    return _SplashScreenState();
    // Cierra el bloque de createState.
  }

  // Cierra la clase SplashScreen.
}

// Guarda los datos y acciones que pueden cambiar en esta pantalla.
class _SplashScreenState extends State<SplashScreen> {
  // Permite consultar el contexto de Flutter de esta pantalla mediante una propiedad de lectura.
  BuildContext get contexto {
    // Entrega el contexto de Flutter asociado a esta pantalla.
    return context;
    // Cierra la propiedad contexto.
  }

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Prepara la pantalla una sola vez al crear su estado.
  void initState() {
    // Ejecuta la preparación básica del estado definida por Flutter.
    super.initState();
    // Ejecuta _irAInicioSesion. Espera el tiempo de bienvenida y abre la inicio de sesión.
    _irAInicioSesion();
    // Cierra el bloque de initState.
  }

  // Espera el tiempo de bienvenida y abre la inicio de sesión. async permite esperar operaciones sin bloquear la interfaz.
  Future<void> _irAInicioSesion() async {
    // Espera el intervalo indicado para simular una operación de carga.
    await Future<void>.delayed(AppConstants.duracionSplash);
    // Detiene la acción si la pantalla ya se eliminó.
    if (!mounted) return;
    // Accede a la navegación para abrir o reemplazar una pantalla.
    Navigator.of(contexto).pushReplacementNamed(AppRoutes.inicioSesion);
    // Cierra el bloque de _irAInicioSesion.
  }

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Devuelve AnnotatedRegion<SystemUiOverlayStyle>( como resultado de esta función.
    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Establece el valor utilizado por el componente al valor indicado.
      value: SystemUiOverlayStyle.light,
      // Establece el único componente visual contenido al valor indicado.
      child: Scaffold(
        // Establece el color de fondo al valor indicado.
        backgroundColor: AppColors.morado,
        // Establece el contenido principal de la pantalla al valor indicado.
        body: SafeArea(
          // Establece el único componente visual contenido al valor indicado.
          child: Column(
            // Establece la lista de componentes visuales hijos al valor indicado.
            children: [
              // Crea un componente que ocupa el espacio restante.
              Expanded(
                // Establece el único componente visual contenido al valor indicado.
                child: Center(
                  // Establece el único componente visual contenido al valor indicado.
                  child: Padding(
                    // Establece el espacio interior alrededor del contenido al valor indicado.
                    padding: const EdgeInsets.only(top: 56),
                    // Establece el único componente visual contenido al valor indicado.
                    child: Column(
                      // Establece el espacio que ocupa el eje principal al valor indicado.
                      mainAxisSize: MainAxisSize.min,
                      // Establece la lista de componentes visuales hijos al valor indicado.
                      children: [
                        // Muestra el logotipo propio desde los assets de la aplicación.
                        Image.asset(
                          // Carga el logotipo del proyecto declarado en pubspec.yaml.
                          'assets/images/logoTutopar.png',
                          // Define el ancho de la marca en la pantalla de bienvenida.
                          width: 112,
                          // Define la altura sin deformar la proporción original.
                          height: 112,
                          // Describe el símbolo para lectores de pantalla.
                          semanticLabel: 'Logotipo de TutoPar',
                          // Cierra la configuración de la imagen.
                        ),
                        // Crea un espacio o caja de tamaño fijo con valores constantes.
                        const SizedBox(height: 34),
                        // Crea un texto visible.
                        Text(
                          // Utiliza AppConstants.nombreApp como parte de la operación actual.
                          AppConstants.nombreApp,
                          // Establece el estilo visual al valor indicado.
                          style: AppTextStyles.marca.copyWith(
                            // Establece el tamaño de la letra al valor indicado.
                            fontSize: 38,
                            // Establece el color al valor indicado.
                            color: Colors.white,
                            // Cierra la configuración de copyWith.
                          ),
                          // Cierra la configuración de Text.
                        ),
                        // Crea un espacio o caja de tamaño fijo con valores constantes.
                        const SizedBox(height: 10),
                        // Crea un texto visible.
                        Text(
                          // Utiliza AppConstants.descripcionApp como parte de la operación actual.
                          AppConstants.descripcionApp,
                          // Establece el estilo visual al valor indicado.
                          style: const TextStyle(
                            // Establece la familia tipográfica al valor indicado.
                            fontFamily: AppTextStyles.inter,
                            // Establece el tamaño de la letra al valor indicado.
                            fontSize: 16,
                            // Establece el color al valor indicado.
                            color: Color(0xD9FFFFFF),
                            // Cierra la configuración de TextStyle.
                          ),
                          // Cierra la configuración de Text.
                        ),
                        // Cierra la lista de elementos.
                      ],
                      // Cierra la configuración de Column.
                    ),
                    // Cierra la configuración de Padding.
                  ),
                  // Cierra la configuración de Center.
                ),
                // Cierra la configuración de Expanded.
              ),
              // Crea un espacio interior alrededor del contenido con valores constantes.
              const Padding(
                // Establece el espacio interior alrededor del contenido al valor indicado.
                padding: EdgeInsets.only(bottom: 56),
                // Establece el único componente visual contenido al valor indicado.
                child: Column(
                  // Establece la lista de componentes visuales hijos al valor indicado.
                  children: [
                    // Crea un espacio o caja de tamaño fijo.
                    SizedBox(
                      // Establece el ancho al valor indicado.
                      width: 22,
                      // Establece la altura al valor indicado.
                      height: 22,
                      // Establece el único componente visual contenido al valor indicado.
                      child: CircularProgressIndicator(
                        // Establece el grosor del trazo al valor indicado.
                        strokeWidth: 2,
                        // Establece el color al valor indicado.
                        color: Color(0xB3FFFFFF),
                        // Cierra la configuración de CircularProgressIndicator.
                      ),
                      // Cierra la configuración de SizedBox.
                    ),
                    // Crea un espacio o caja de tamaño fijo.
                    SizedBox(height: 14),
                    // Crea un texto visible.
                    Text(
                      // Proporciona este texto al la configuración de Text.
                      'Etapa 1 · MVP local',
                      // Establece el estilo visual al valor indicado.
                      style: TextStyle(
                        // Establece la familia tipográfica al valor indicado.
                        fontFamily: AppTextStyles.inter,
                        // Establece el tamaño de la letra al valor indicado.
                        fontSize: 13,
                        // Establece el color al valor indicado.
                        color: Color(0x99FFFFFF),
                        // Cierra la configuración de TextStyle.
                      ),
                      // Cierra la configuración de Text.
                    ),
                    // Cierra la lista de elementos.
                  ],
                  // Cierra la configuración de Column.
                ),
                // Cierra la configuración de Padding.
              ),
              // Cierra la lista de elementos.
            ],
            // Cierra la configuración de Column.
          ),
          // Cierra la configuración de SafeArea.
        ),
        // Cierra la configuración de Scaffold.
      ),
      // Cierra los argumentos y termina la instrucción.
    );
    // Cierra el bloque de build.
  }

  // Cierra la clase _SplashScreenState.
}
