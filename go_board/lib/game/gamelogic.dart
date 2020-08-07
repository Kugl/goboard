import 'package:flutter/material.dart';
import 'package:go_board/BoardVisu/stone.dart';
import 'package:go_board/helpers/coordinateHelper.dart';

class Group {
  List<StoneData> stones = [];
  int number;

  Group(StoneData stone) {
    addStone(stone);
  }

  addStone(StoneData stone) {
    stones.add(stone);
  }

  sumLiberties() {}

  //merge the other group int this group and correct stone info
  merge(Group otherGroup) {}

  updateLiberties() {}
}

class GameData extends ChangeNotifier {
  Map<String, StoneData> boardState = Map<String, StoneData>();
  //List<List<StoneData>> groups = [];

  bool blackToPlay = true;
  int boardSize = 9;

  GameData() {
    _populateBoard();
  }

  _populateBoard() {
    for (var x = 0; x < this.boardSize; x++) {
      for (var y = 0; y < this.boardSize; y++) {
        BoardCoordiante coord = BoardCoordiante(x, y);
        List<BoardCoordiante> neibs =
            CoordHelper.determineNeighbors(coord, this.boardSize);
        this.boardState[coord.returnMapCoordiante()] = StoneData(
          coordinates: coord,
          liberties: neibs.length,
          color: StoneColor.none,
          neighbors: neibs,
        );
      }
    }
  }

  //TODO: place stone method
  placeStone(BoardCoordiante coord) {
    StoneData theCurrentStone = boardState[coord.returnMapCoordiante()];
    // Change board state to reflect presence of new stone
    if (blackToPlay) {
      theCurrentStone.color = StoneColor.black;
    } else {
      theCurrentStone.color = StoneColor.white;
    }

    // reduce liberties for all neighbours by 1
    bool merge = false;
    //TODO: Change to enum & switch
    bool noGroupableNeig = true;
    Group currentGroup;
    for (BoardCoordiante badNeighbor in theCurrentStone.neighbors) {
      StoneData currentNeighbor = boardState[badNeighbor.returnMapCoordiante()];
      currentNeighbor.liberties--;

      if (theCurrentStone.color == currentNeighbor.color) {
        if (merge == false) {
          currentGroup = currentNeighbor.group;
          currentGroup.addStone(theCurrentStone);
          merge = true;
          noGroupableNeig = false;
        }
        if (merge == true) {
          currentGroup.merge(currentNeighbor.group);
        }
      }
      //no neigbour
    }

    if (noGroupableNeig == true) {
      currentGroup = Group(theCurrentStone);
    }

    theCurrentStone.group = currentGroup;
    merge = false;

    //check for groups and add if possible
    // form groups with all neighbours that are of same color
    // adjust group liberties

    // remove all groups with zero liberties of opposite color

    changePlayer();
    notifyListeners();
  }

  void changePlayer() {
    blackToPlay = !blackToPlay;
  }
}
