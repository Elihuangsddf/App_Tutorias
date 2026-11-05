import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Símbolo de TutoPar: dos anillos que se cruzan dentro de un cuadrado
/// redondeado. Se dibuja en código para mantenerse nítido en cualquier tamaño.
class TutoParMark extends StatelessWidget {
  const TutoParMark({
    super.key,
    this.size = 48,
    this.backgroundColor = AppColors.morado,
    this.leftColor = Colors.white,
    this.rightColor = AppColors.ambar,
  });

  final double size;
  final Color backgroundColor;
  final Color leftColor;
  final Color rightColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _MarkPainter(
          backgroundColor: backgroundColor,
          leftColor: leftColor,
          rightColor: rightColor,
        ),
      ),
    );
  }
}

class _MarkPainter extends CustomPainter {
  const _MarkPainter({
    required this.backgroundColor,
    required this.leftColor,
    required this.rightColor,
  });

  final Color backgroundColor;
  final Color leftColor;
  final Color rightColor;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(size.width * 0.235)),
      Paint()..color = backgroundColor,
    );

    final stroke = size.width * 0.082;
    final radius = size.width * 0.2;
    final centroY = size.height * 0.5;
    final izquierdo = Offset(size.width * 0.385, centroY);
    final derecho = Offset(size.width * 0.615, centroY);

    final paintIzquierdo = Paint()
      ..color = leftColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    final paintDerecho = Paint()
      ..color = rightColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(izquierdo, radius, paintIzquierdo);
    canvas.drawCircle(derecho, radius, paintDerecho);
  }

  @override
  bool shouldRepaint(covariant _MarkPainter oldDelegate) {
    return oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.leftColor != leftColor ||
        oldDelegate.rightColor != rightColor;
  }
}

/// Wordmark "TutoPar".
class TutoParWordmark extends StatelessWidget {
  const TutoParWordmark({
    super.key,
    this.fontSize = 24,
    this.color = AppColors.moradoOscuro,
  });

  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      'TutoPar',
      style: AppTextStyles.marca.copyWith(fontSize: fontSize, color: color),
    );
  }
}

/// Marca completa: símbolo + wordmark, alineados horizontalmente.
class TutoParBrand extends StatelessWidget {
  const TutoParBrand({
    super.key,
    this.size = 44,
    this.fontSize = 22,
    this.color = AppColors.moradoOscuro,
  });

  final double size;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TutoParMark(size: size),
        const SizedBox(width: 12),
        TutoParWordmark(fontSize: fontSize, color: color),
      ],
    );
  }
}
