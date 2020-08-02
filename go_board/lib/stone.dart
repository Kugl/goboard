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

class OldStoneSpot extends StatelessWidget {
  final BoardCoordiante coordinates;
  final List<BoardCoordiante> neighbors;
  final int liberties;
  final StoneColor color;

  OldStoneSpot(
      {@required this.coordinates,
      @required this.neighbors,
      @required this.liberties,
      @required this.color});

  @override
  Widget build(BuildContext context) {
    GameData gamedat = Provider.of<GameData>(context);
    return SizedBox(
      height: 40,
      width: 40,
      child: FloatingActionButton(
        backgroundColor: Colors.transparent,
        //TODO: change second to null
        elevation: 4,
        onPressed: () {
          print(coordinates.returnMapCoordiante());
          //if black is to play
          GameData gamedata = Provider.of<GameData>(context, listen: false);
          gamedata.placeStone(coordinates);
        },
      ),
    );
  }
}

class OldNewStone extends OldStoneSpot {
  final BoardCoordiante coordinates;
  final List<BoardCoordiante> neighbors;
  final int liberties;
  final StoneColor color;

  OldNewStone(
      {@required this.coordinates,
      @required this.neighbors,
      @required this.liberties,
      @required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundImage: (color == StoneColor.black)
            ? AssetImage("assets/BlackStone.png")
            : AssetImage("assets/WhiteStone.png"),
      ),
    );
  }
}

class TheStone extends StatelessWidget {
  final BoardCoordiante coordinates;
  final StoneColor color;

  TheStone({@required this.coordinates, @required this.color});

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
          //TODO: change second number to null
          elevation: (color == StoneColor.black) ? 4 : 4,
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

class OldStone extends StatefulWidget {
  final BoardCoordiante coordinates;
  final List<BoardCoordiante> neighbors;

  OldStone({@required this.coordinates, @required this.neighbors});

  @override
  _StoneState createState() => _StoneState();
}

class _StoneState extends State<OldStone> {
  int liberties;
  StoneColor color;
  //List<BoardCoordiante> neighbors;

  reduceLiberties() {}

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
        //TODO: change second number to null
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
