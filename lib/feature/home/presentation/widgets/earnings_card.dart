import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import 'chart_painter.dart';


class _ChartDot extends StatelessWidget {
  const _ChartDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xff2D3142),
        border: Border.all(
          color: Colors.white,
          width: 2.5,
        ),
      ),
    );
  }
}

class BackgroundPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final path1 = Path()
      ..addOval(Rect.fromCircle(center: Offset(size.width * .15, size.height * .2), radius: 18))
      ..addOval(Rect.fromCircle(center: Offset(size.width * .75, size.height * .22), radius: 24))
      ..addOval(Rect.fromCircle(center: Offset(size.width * .65, size.height * .72), radius: 16));

    final path2 = Path()
      ..moveTo(size.width * .08, size.height * .82)
      ..quadraticBezierTo(size.width * .18, size.height * .72, size.width * .28, size.height * .85)
      ..moveTo(size.width * .78, size.height * .38)
      ..quadraticBezierTo(size.width * .88, size.height * .28, size.width * .95, size.height * .42);

    canvas.drawPath(path1, paint);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}