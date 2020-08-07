import 'package:flutter/material.dart';
import 'package:go_board/game/gamelogic.dart';
import 'package:go_board/helpers/coordinateHelper.dart';
import 'package:provider/provider.dart';

enum StoneColor { black, white, none }

class StoneData {
  BoardCoordiante coordinates;
  List<BoardCoordiante> neighbors;
  int liberties;
  StoneColor color;
  Group group;

  StoneData(
      {@required this.coordinates,
      @required this.neighbors,
      @required this.liberties,
      @required this.color});
}

class Stone extends StatelessWidget {
  final BoardCoordiante coordinates;

  Stone({@required this.coordinates});

  @override
  Widget build(BuildContext context) {
    //GameData game = Provider.of<GameData>(context);

    GameData game = Provider.of<GameData>(context);
    //Listens to changes in the stones color
    StoneColor activeColor =
        game.boardState[coordinates.returnMapCoordiante()].color;
    if (activeColor == StoneColor.none) {
      //TODO: Exchange for more elegant sizing
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
          backgroundColor: Colors.white,
          backgroundImage: (activeColor == StoneColor.black)
              ? AssetImage("assets/BlackStone.png")
              : AssetImage("assets/WhiteStone.png"),
        ),
      );
    }
  }
}
