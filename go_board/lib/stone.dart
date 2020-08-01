import 'package:flutter/material.dart';

import 'main.dart';

enum StoneColor { black, white, none }

class Stone extends StatefulWidget {
  final StoneColor initialColor;
  final BoardCoordiante coordinates;

  Stone({this.initialColor = StoneColor.none, @required this.coordinates});

  @override
  _StoneState createState() => _StoneState();
}

class _StoneState extends State<Stone> {
  StoneColor color;
  List<BoardCoordiante> neighbors;

  defineNeighbors() {}

  Color pickStoneColor(StoneColor col) {
    switch (col) {
      case StoneColor.black:
        return Colors.black;
        break;
      case StoneColor.white:
        return Colors.white;
        break;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    color = widget.initialColor;
    return FloatingActionButton(
      backgroundColor: pickStoneColor(color),
      //TODO: change first 8 to null
      elevation: (color == StoneColor.none) ? 8 : 8,
      onPressed: () {},
    );
  }
}
