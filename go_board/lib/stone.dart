import 'package:flutter/material.dart';
import 'package:go_board/main.dart';
import 'package:provider/provider.dart';

import 'coordinateHelper.dart';

enum StoneColor { black, white, none }

class StoneData {
  BoardCoordiante coordinates;
  List<BoardCoordiante> neighbors;
  int liberties;
  StoneColor color;

  StoneData(
      {@required this.coordinates,
      @required this.neighbors,
      @required this.liberties,
      @required this.color});
}

class TheStone extends StatelessWidget {
  final BoardCoordiante coordinates;

  TheStone({@required this.coordinates});

  @override
  Widget build(BuildContext context) {
    //GameData game = Provider.of<GameData>(context);
    //TODO: Exchange for more elegant sizing
    GameData game = Provider.of<GameData>(context);
    StoneColor activeColor =
        game.newBoardState[coordinates.returnMapCoordiante()].color;
    if (activeColor == StoneColor.none) {
      return SizedBox(
        height: 40,
        width: 40,
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          //TODO: change to null
          elevation: 4,
          onPressed: () {
            print(coordinates.returnMapCoordiante());
            //if black is to play
            GameData gamedata = Provider.of<GameData>(context, listen: false);
            gamedata.placeStone(coordinates);
          },
        ),
      );
    } else {
      return SizedBox(
        height: 40,
        width: 40,
        child: CircleAvatar(
          backgroundImage: (activeColor == StoneColor.black)
              ? AssetImage("assets/BlackStone.png")
              : AssetImage("assets/WhiteStone.png"),
        ),
      );
    }
  }
}
