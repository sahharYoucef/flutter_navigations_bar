import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  Color color;
  CirclePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    Path path = Path();
    path.addOval(Rect.fromLTRB(0.0, 0.0, size.width - 10, size.width - 10));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(CirclePainter oldDelegate) => false;
}

class BottomBarClipper extends CustomClipper<Path> {
  double position;
  BottomBarClipper(this.position);
  @override
  Path getClip(Size size) {
     final path = Path()
      ..moveTo(0, 0)
      ..lineTo( position - 10 , 0.0)
      ..arcToPoint(
        Offset( position + 70, 0),
        clockwise: false,
        radius: Radius.circular(40),
      )
      ..lineTo(size.width, 0.0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, size.height);

    path.lineTo(0.0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}