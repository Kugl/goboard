import 'package:flutter/material.dart';

class Cross extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Stack(children: [
          CustomPaint(painter: DrawCross()),
          Divider(
            color: Colors.white,
          ),
        ]),
      ),
    );
  }
}

class DrawCross extends CustomPainter {
  Paint _paint;

  DrawCross() {
    _paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset(-90.0, 10.0), Offset(90.0, 10.0), _paint);
    canvas.drawLine(Offset(10.0, -90.0), Offset(10.0, 90.0), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
