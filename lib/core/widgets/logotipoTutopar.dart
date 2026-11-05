// Importa los componentes visuales y estilos Material de Flutter.
import 'package:flutter/material.dart';

// Importa temaAplicacion.dart para utilizar sus clases y funciones.
import 'package:app_tutorias/core/theme/temaAplicacion.dart';

/// Símbolo de TutoPar: dos anillos que se cruzan dentro de un cuadrado
/// redondeado. Se dibuja en código para mantenerse nítido en cualquier tamaño.
// Define TutoParMark, que representa el símbolo de TutoPar.
class TutoParMark extends StatelessWidget {
  // Define cómo se crea TutoParMark y qué datos recibe.
  const TutoParMark({
    // Entrega a Flutter la clave opcional que identifica este componente.
    super.key,
    // Recibe como opción el tamaño del componente.
    this.tamano = 48,
    // Recibe como opción el color de fondo.
    this.colorFondo = AppColors.morado,
    // Recibe como opción el color del anillo izquierdo.
    this.colorIzquierdo = Colors.white,
    // Recibe como opción el color del anillo derecho.
    this.colorDerecho = AppColors.ambar,
    // Cierra el bloque de TutoParMark y termina la instrucción.
  });

  // Declara el tamaño del componente sin permitir reasignarlo.
  final double tamano;
  // Declara el color de fondo sin permitir reasignarlo.
  final Color colorFondo;
  // Declara el color del anillo izquierdo sin permitir reasignarlo.
  final Color colorIzquierdo;
  // Declara el color del anillo derecho sin permitir reasignarlo.
  final Color colorDerecho;

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Devuelve un espacio o caja de tamaño fijo con la configuración siguiente.
    return SizedBox(
      // Establece el ancho al valor indicado.
      width: tamano,
      // Establece la altura al valor indicado.
      height: tamano,
      // Establece el único componente visual contenido al valor indicado.
      child: CustomPaint(
        // Establece el objeto que dibuja el logotipo al valor indicado.
        painter: _MarkPainter(
          // Establece el color de fondo al valor indicado.
          colorFondo: colorFondo,
          // Establece el color del anillo izquierdo al valor indicado.
          colorIzquierdo: colorIzquierdo,
          // Establece el color del anillo derecho al valor indicado.
          colorDerecho: colorDerecho,
          // Cierra la configuración de _MarkPainter.
        ),
        // Cierra la configuración de CustomPaint.
      ),
      // Cierra la configuración de SizedBox y termina la instrucción.
    );
    // Cierra el bloque de build.
  }

  // Cierra la clase TutoParMark.
}

// Define _MarkPainter, que representa el componente mark painter.
class _MarkPainter extends CustomPainter {
  // Define cómo se crea _MarkPainter y qué datos recibe.
  const _MarkPainter({
    // Solicita el color de fondo.
    required this.colorFondo,
    // Solicita el color del anillo izquierdo.
    required this.colorIzquierdo,
    // Solicita el color del anillo derecho.
    required this.colorDerecho,
    // Cierra el bloque de _MarkPainter y termina la instrucción.
  });

  // Declara el color de fondo sin permitir reasignarlo.
  final Color colorFondo;
  // Declara el color del anillo izquierdo sin permitir reasignarlo.
  final Color colorIzquierdo;
  // Declara el color del anillo derecho sin permitir reasignarlo.
  final Color colorDerecho;

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Dibuja el símbolo de la aplicación en el lienzo.
  void paint(Canvas lienzo, Size tamano) {
    // Prepara rectangulo sin permitir reasignarlo.
    final rectangulo = Rect.fromLTWH(0, 0, tamano.width, tamano.height);
    // Prepara pintura fondo sin permitir reasignarlo.
    final pinturaFondo = Paint();
    // Actualiza pinturaFondo.color con colorFondo.
    pinturaFondo.color = colorFondo;
    // Dibuja un rectángulo redondeado en lienzo.
    lienzo.drawRRect(
      // Ejecuta fromRectAndRadius sobre RRect.
      RRect.fromRectAndRadius(
        // Utiliza rectangulo como parte de la operación actual.
        rectangulo,
        // Ejecuta circular sobre Radius.
        Radius.circular(tamano.width * 0.235),
        // Cierra la configuración de fromRectAndRadius.
      ),
      // Utiliza pinturaFondo como parte de la operación actual.
      pinturaFondo,
      // Cierra la configuración de drawRRect y termina la instrucción.
    );

    // Prepara grosor sin permitir reasignarlo.
    final grosor = tamano.width * 0.082;
    // Prepara radio sin permitir reasignarlo.
    final radio = tamano.width * 0.2;
    // Prepara centro y sin permitir reasignarlo.
    final centroY = tamano.height * 0.5;
    // Prepara izquierdo sin permitir reasignarlo.
    final izquierdo = Offset(tamano.width * 0.385, centroY);
    // Prepara derecho sin permitir reasignarlo.
    final derecho = Offset(tamano.width * 0.615, centroY);

    // Prepara pintura izquierda sin permitir reasignarlo.
    final pinturaIzquierda = Paint();
    // Actualiza pinturaIzquierda.color con colorIzquierdo.
    pinturaIzquierda.color = colorIzquierdo;
    // Actualiza pinturaIzquierda.style con PaintingStyle.stroke.
    pinturaIzquierda.style = PaintingStyle.stroke;
    // Actualiza pinturaIzquierda.strokeWidth con grosor.
    pinturaIzquierda.strokeWidth = grosor;
    // Actualiza pinturaIzquierda.strokeCap con StrokeCap.round.
    pinturaIzquierda.strokeCap = StrokeCap.round;
    // Prepara pintura derecha sin permitir reasignarlo.
    final pinturaDerecha = Paint();
    // Actualiza pinturaDerecha.color con colorDerecho.
    pinturaDerecha.color = colorDerecho;
    // Actualiza pinturaDerecha.style con PaintingStyle.stroke.
    pinturaDerecha.style = PaintingStyle.stroke;
    // Actualiza pinturaDerecha.strokeWidth con grosor.
    pinturaDerecha.strokeWidth = grosor;
    // Actualiza pinturaDerecha.strokeCap con StrokeCap.round.
    pinturaDerecha.strokeCap = StrokeCap.round;

    // Dibuja un círculo en lienzo.
    lienzo.drawCircle(izquierdo, radio, pinturaIzquierda);
    // Dibuja un círculo en lienzo.
    lienzo.drawCircle(derecho, radio, pinturaDerecha);
    // Cierra el bloque de paint.
  }

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Comprueba si cambiaron los colores y se necesita volver a dibujar.
  bool shouldRepaint(covariant _MarkPainter pintorAnterior) {
    // Devuelve pintorAnterior.colorFondo != colorFondo || como resultado de esta función.
    return pintorAnterior.colorFondo != colorFondo ||
        // Evalúa pintorAnterior.colorIzquierdo != colorIzquierdo || como parte del resultado actual.
        pintorAnterior.colorIzquierdo != colorIzquierdo ||
        // Evalúa pintorAnterior.colorDerecho != colorDerecho como parte del resultado actual.
        pintorAnterior.colorDerecho != colorDerecho;
    // Cierra el bloque de shouldRepaint.
  }

  // Cierra la clase _MarkPainter.
}

/// Wordmark "TutoPar".
// Define TutoParWordmark, que representa el nombre visual de TutoPar.
class TutoParWordmark extends StatelessWidget {
  // Define cómo se crea TutoParWordmark y qué datos recibe.
  const TutoParWordmark({
    // Entrega a Flutter la clave opcional que identifica este componente.
    super.key,
    // Recibe como opción tamano fuente.
    this.tamanoFuente = 24,
    // Recibe como opción el color.
    this.color = AppColors.moradoOscuro,
    // Cierra el bloque de TutoParWordmark y termina la instrucción.
  });

  // Declara tamano fuente sin permitir reasignarlo.
  final double tamanoFuente;
  // Declara el color sin permitir reasignarlo.
  final Color color;

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Devuelve un texto visible con la configuración siguiente.
    return Text(
      // Proporciona este texto al la configuración de Text.
      'TutoPar',
      // Establece el estilo visual al valor indicado.
      style: AppTextStyles.marca.copyWith(fontSize: tamanoFuente, color: color),
      // Cierra la configuración de Text y termina la instrucción.
    );
    // Cierra el bloque de build.
  }

  // Cierra la clase TutoParWordmark.
}

/// Marca completa: símbolo + wordmark, alineados horizontalmente.
// Define TutoParBrand, que representa el símbolo y nombre de TutoPar.
class TutoParBrand extends StatelessWidget {
  // Define cómo se crea TutoParBrand y qué datos recibe.
  const TutoParBrand({
    // Entrega a Flutter la clave opcional que identifica este componente.
    super.key,
    // Recibe como opción el tamaño del componente.
    this.tamano = 44,
    // Recibe como opción tamano fuente.
    this.tamanoFuente = 22,
    // Recibe como opción el color.
    this.color = AppColors.moradoOscuro,
    // Cierra el bloque de TutoParBrand y termina la instrucción.
  });

  // Declara el tamaño del componente sin permitir reasignarlo.
  final double tamano;
  // Declara tamano fuente sin permitir reasignarlo.
  final double tamanoFuente;
  // Declara el color sin permitir reasignarlo.
  final Color color;

  // Indica que se implementa un método definido por la clase de Flutter o el contrato.
  @override
  // Construye los componentes que Flutter mostrará en pantalla.
  Widget build(BuildContext contexto) {
    // Devuelve una fila de componentes con la configuración siguiente.
    return Row(
      // Establece el espacio que ocupa el eje principal al valor indicado.
      mainAxisSize: MainAxisSize.min,
      // Establece la lista de componentes visuales hijos al valor indicado.
      children: [
        // Crea el símbolo de TutoPar.
        TutoParMark(tamano: tamano),
        // Crea un espacio o caja de tamaño fijo con valores constantes.
        const SizedBox(width: 12),
        // Crea el nombre visual de TutoPar.
        TutoParWordmark(tamanoFuente: tamanoFuente, color: color),
        // Cierra la lista de elementos.
      ],
      // Cierra la configuración de Row y termina la instrucción.
    );
    // Cierra el bloque de build.
  }

  // Cierra la clase TutoParBrand.
}
