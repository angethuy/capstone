import 'package:flutter/material.dart';
import 'package:pagotometer/style/styles.dart';

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = AppColor.mildPurple;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 6;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
