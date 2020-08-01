import 'package:flutter/material.dart';
import 'package:go_board/main.dart';
import 'package:provider/provider.dart';

import 'coordinateHelper.dart';

enum StoneColor { black, white, none }

class Stone extends StatefulWidget {
  final BoardCoordiante coordinates;

  Stone({@required this.coordinates});

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
    //TODO: Exchange for more elegant sizing
    return SizedBox(
      height: 40,
      width: 40,
      child: FloatingActionButton(
        backgroundColor: pickStoneColor(color),
        //TODO: change second 8 to null
        elevation: (color == StoneColor.black) ? 4 : 4,
        onPressed: () {
          print(widget.coordinates.returnMapCoordiante());
          setState(() {
            //if black is to play
            GameData gamedata = Provider.of<GameData>(context, listen: false);
            (gamedata.blackToPlay)
                ? color = StoneColor.black
                : color = StoneColor.white;
            gamedata.changePlayer();
          });
        },
      ),
    );
  }
}
