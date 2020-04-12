import 'package:flutter/material.dart';

class LightPainter extends CustomPainter {
  AnimationController animation;
  Color color;

  LightPainter({this.animation , this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = LinearGradient(colors: [
        color.withOpacity(0.5 - animation.value / 2),
        color.withOpacity(0.0)
      ], stops: [
        0.0,
        1.0
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
          .createShader(
              Rect.fromLTWH(size.width * 0.5, 0.0, size.width, size.height));

    Path path = Path()
      ..moveTo(size.width * 0.25, 0.0)
      ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width * 0.75, 0.0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(LightPainter oldDelegate) => true;
}