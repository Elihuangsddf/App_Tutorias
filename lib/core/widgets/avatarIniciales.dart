// Importa los componentes visuales y estilos Material de Flutter.
import 'package:flutter/material.dart';

// Importa temaAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/theme/temaAplicacion.dart';
// Importa formatoTextos.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/utils/formatoTextos.dart';

/// Avatar circular con las iniciales del usuario sobre un tinte morado.
///
/// Los diseños de Figma no usan fotografías: todos los avatares son iniciales.
// Define InitialsAvatar, que representa un avatar con las iniciales del nombre.
class InitialsAvatar extends StatelessWidget {
  // Define cómo se crea InitialsAvatar y qué datos recibe.
  const InitialsAvatar({
    // Entrega a Flutter la clave opcional que identifica este componente.
    super.key,
    // Solicita el nombre.
    required this.nombre,
    // Recibe como opción el tamaño del componente.
    this.tamano = 56,
    // Recibe como opción el color de fondo.
    this.colorFondo = AppColors.moradoTinte,
    // Recibe como opción el color del texto.
    this.colorTexto = AppColors.morado,
    // Cierra el bloque de InitialsAvatar y termina la instrucción.
  });

  // Declara el nombre sin permitir reasignarlo.
  final String nombre;
  // Declara el tamaño del componente sin permitir reasignarlo.
  final double tamano;
  // Declara el color de fondo sin permitir reasignarlo.
  final Color colorFondo;
  // Declara el color del texto sin permitir reasignarlo.
  final Color colorTexto;

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Devuelve un contenedor con tamaño y decoración con la configuración siguiente.
    return Container(
      // Establece el ancho al valor indicado.
      width: tamano,
      // Establece la altura al valor indicado.
      height: tamano,
      // Establece la alineación del contenido al valor indicado.
      alignment: Alignment.center,
      // Establece la decoración de fondo, bordes o campo al valor indicado.
      decoration: BoxDecoration(color: colorFondo, shape: BoxShape.circle),
      // Establece el único componente visual contenido al valor indicado.
      child: Text(
        // Ejecuta iniciales sobre Formato.
        Formato.iniciales(nombre),
        // Establece el estilo visual al valor indicado.
        style: TextStyle(
          // Establece la familia tipográfica al valor indicado.
          fontFamily: AppTextStyles.poppins,
          // Establece el tamaño de la letra al valor indicado.
          fontSize: tamano * 0.34,
          // Establece la altura al valor indicado.
          height: 1,
          // Establece el grosor de la letra al valor indicado.
          fontWeight: FontWeight.w600,
          // Establece el espacio entre letras al valor indicado.
          letterSpacing: 0.2,
          // Establece el color al valor indicado.
          color: colorTexto,
          // Cierra la configuración de TextStyle.
        ),
        // Cierra la configuración de Text.
      ),
      // Cierra la configuración de Container y termina la instrucción.
    );
    // Cierra el bloque de build.
  }

  // Cierra la clase InitialsAvatar.
}
