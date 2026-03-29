import 'package:flutter/material.dart';

class ToolsPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintStroke = Paint()
      ..color = const Color(0xffE8E8E8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    final paintFill = Paint()
      ..color = const Color(0xffECECEC).withOpacity(.35)
      ..style = PaintingStyle.fill;

    void drawCircle(double x, double y, double r) {
      canvas.drawCircle(Offset(x, y), r, paintStroke);
    }

    void drawRoundedRect(double x, double y, double w, double h) {
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, w, h),
        const Radius.circular(8),
      );
      canvas.drawRRect(rect, paintStroke);
    }

    void drawWrench(double x, double y, double scale) {
      final path = Path();
      path.moveTo(x, y);
      path.lineTo(x + 18 * scale, y + 18 * scale);
      path.lineTo(x + 14 * scale, y + 22 * scale);
      path.lineTo(x - 4 * scale, y + 4 * scale);
      path.close();
      canvas.drawPath(path, paintFill);
      canvas.drawPath(path, paintStroke);
      drawCircle(x + 22 * scale, y + 22 * scale, 6 * scale);
    }

    void drawBottle(double x, double y, double scale) {
      drawRoundedRect(x, y + 8 * scale, 14 * scale, 26 * scale);
      drawRoundedRect(x + 3 * scale, y, 8 * scale, 10 * scale);
    }

    void drawDrop(double x, double y, double scale) {
      final path = Path();
      path.moveTo(x, y);
      path.quadraticBezierTo(x - 8 * scale, y + 10 * scale, x, y + 18 * scale);
      path.quadraticBezierTo(x + 8 * scale, y + 10 * scale, x, y);
      canvas.drawPath(path, paintStroke);
    }

    void drawGear(double x, double y, double scale) {
      drawCircle(x, y, 12 * scale);
      drawCircle(x, y, 4 * scale);
    }

    final items = <void Function()>[
          () => drawRoundedRect(45, 25, 28, 16),
          () => drawBottle(150, 48, 1),
          () => drawDrop(230, 35, 1),
          () => drawWrench(275, 70, 1),
          () => drawCircle(335, 30, 10),
          () => drawGear(75, 150, 1),
          () => drawWrench(165, 145, 1),
          () => drawBottle(280, 150, 1),
          () => drawRoundedRect(330, 125, 24, 16),
          () => drawDrop(50, 255, 1),
          () => drawBottle(120, 250, 1),
          () => drawCircle(200, 250, 9),
          () => drawWrench(280, 245, 1),
          () => drawGear(340, 260, 1),
          () => drawRoundedRect(35, 385, 32, 16),
          () => drawWrench(120, 390, 1),
          () => drawBottle(220, 375, 1),
          () => drawDrop(325, 380, 1),
          () => drawCircle(85, 520, 10),
          () => drawGear(180, 520, 1),
          () => drawBottle(290, 505, 1),
          () => drawWrench(330, 545, 1),
          () => drawDrop(60, 640, 1),
          () => drawRoundedRect(150, 650, 28, 16),
          () => drawGear(300, 655, 1),
    ];

    for (final draw in items) {
      draw();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
