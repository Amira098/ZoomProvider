import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final fillPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.lineTo(size.width * 0.1, size.height * 0.65);
    path.lineTo(size.width * 0.2, size.height * 0.8);
    path.lineTo(size.width * 0.3, size.height * 0.6);
    path.lineTo(size.width * 0.4, size.height * 0.75);
    path.lineTo(size.width * 0.5, size.height * 0.4); // Peak
    path.lineTo(size.width * 0.6, size.height * 0.6);
    path.lineTo(size.width * 0.7, size.height * 0.5);
    path.lineTo(size.width * 0.8, size.height * 0.85);
    path.lineTo(size.width * 0.9, size.height * 0.75);
    path.lineTo(size.width, size.height * 0.8);

    canvas.drawPath(path, paint);

    final fillPath = Path();
    fillPath.moveTo(0, size.height * 0.7);
    fillPath.lineTo(size.width * 0.1, size.height * 0.65);
    fillPath.lineTo(size.width * 0.2, size.height * 0.8);
    fillPath.lineTo(size.width * 0.3, size.height * 0.6);
    fillPath.lineTo(size.width * 0.4, size.height * 0.75);
    fillPath.lineTo(size.width * 0.5, size.height * 0.4); // Peak
    fillPath.lineTo(size.width * 0.6, size.height * 0.6);
    fillPath.lineTo(size.width * 0.7, size.height * 0.5);
    fillPath.lineTo(size.width * 0.8, size.height * 0.85);
    fillPath.lineTo(size.width * 0.9, size.height * 0.75);
    fillPath.lineTo(size.width, size.height * 0.8);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();
    canvas.drawPath(fillPath, fillPaint);

    // Draw the dot at the peak
    final dotPaint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.4), 4, dotPaint);
    final dotStrokePaint = Paint()
      ..color = AppColors.surface
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.4), 4, dotStrokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
