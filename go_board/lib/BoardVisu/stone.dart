import 'package:flutter/material.dart';
import 'package:go_board/BoardVisu/snackbar.dart';
import 'package:go_board/game/gamelogic.dart';
import 'package:go_board/game/group.dart';
import 'package:go_board/helpers/coordinateHelper.dart';
import 'package:provider/provider.dart';

enum StoneColor { black, white, none }

class StoneBackup {
  int liberties;
  StoneColor color;
  List<StoneData> groupStones;

  StoneBackup(
      {@required this.color,
      @required this.groupStones,
      @required this.liberties});
}

class StoneData {
  final BoardCoordiante coordinates;
  final List<BoardCoordiante> neighbors;
  Set<String> freeNeighbors = {};
  StoneColor color;
  //is only manipulated  via the Group object
  Group group = Group.empty();

  //for scoring
  bool counted = false;

  StoneData(
      {@required this.coordinates,
      @required this.neighbors,
      @required this.color}) {
    for (BoardCoordiante free in neighbors) {
      freeNeighbors.add(free.returnMapCoordiante());
    }
  }

  fillOut(StoneColor col) {
    switch (col) {
      case StoneColor.white:
        {
          this.color = StoneColor.white;
        }
        break;
      case StoneColor.black:
        {
          this.color = StoneColor.black;
        }
        break;
      default:
        return;
    }
  }

  bool surroundedByFriends(Map<String, StoneData> boardState) {
    int friendcount;
    for (BoardCoordiante coord in neighbors) {
      if (boardState[coord.returnMapCoordiante()].color == this.color) {
        friendcount++;
      }
    }
    if (friendcount > 0) {
      return true;
    } else {
      return false;
    }
  }

/*   _recalculateLiberties(Map<String, StoneData> boardState) {
    this._liberties = 0;
    for (BoardCoordiante coord in neighbors) {
      if (boardState[coord.returnMapCoordiante()].color == StoneColor.none) {
        this._liberties++;
      }
    }
    recalculateFreeNeigbors(boardState);
  } */

  recalculateFreeNeigbors(Map<String, StoneData> boardState) {
    this.freeNeighbors = {};
    for (BoardCoordiante coord in neighbors) {
      StoneData neib = boardState[coord.returnMapCoordiante()];
      if (neib.color == StoneColor.none) {
        this.freeNeighbors.add(neib.coordinates.returnMapCoordiante());
      }
    }
    //_recalculateLiberties(boardState);
  }

  kill(Map<String, StoneData> boardState) {
    _uncolor();
    _resetGroup();
    _addLibertiesforNeighbors(boardState);
  }

  _uncolor() {
    this.color = StoneColor.none;
  }

  _resetGroup() {
    this.group = null;
  }

  _addLibertiesforNeighbors(Map<String, StoneData> boardState) {
    for (BoardCoordiante coord in neighbors) {
      boardState[coord.returnMapCoordiante()]
          .freeNeighbors
          .add(this.coordinates.returnMapCoordiante());
    }
  }
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
            //Dismiss old snackbars when stone is palced
            SnackWrap.dismissSnackbar(context);
            print(coordinates.returnMapCoordiante());
            //if black is to play
            GameData gamedata = Provider.of<GameData>(context, listen: false);
            String error = gamedata.placeStone(coordinates);
            SnackWrap.createSnackBar(context, text: error);
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
