import 'package:flutter/material.dart';

enum CrossOrientation { left, right }

class Cross extends StatelessWidget {
  final Widget child;
  final CrossOrientation orientation;
  Cross({this.orientation, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        CustomPaint(painter: DrawCross(orientation: orientation), child: child),
      ]),
    );
  }
}

class DrawCross extends CustomPainter {
  Paint _paint;
  final CrossOrientation orientation;

  DrawCross({this.orientation}) {
    _paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    switch (this.orientation) {
      case CrossOrientation.right:
        canvas.drawLine(Offset(0, size.height / 2),
            Offset(size.width / 2, size.height / 2), _paint);
        canvas.drawLine(Offset(size.width / 2, 0),
            Offset(size.width / 2, size.height), _paint);
        break;
      case CrossOrientation.left:
        canvas.drawLine(Offset(size.width / 2, size.height / 2),
            Offset(size.width, size.height / 2), _paint);
        canvas.drawLine(Offset(size.width / 2, 0),
            Offset(size.width / 2, size.height), _paint);
        break;
      default:
        canvas.drawLine(Offset(0, size.height / 2),
            Offset(size.width, size.height / 2), _paint);
        canvas.drawLine(Offset(size.width / 2, 0),
            Offset(size.width / 2, size.height), _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
