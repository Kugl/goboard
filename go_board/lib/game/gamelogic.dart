import 'package:flutter/material.dart';
import 'package:go_board/BoardVisu/stone.dart';
import 'package:go_board/helpers/coordinateHelper.dart';

class Group {
  List<StoneData> stones = [];

  Group(StoneData stone) {
    addStone(stone);
  }

//adds stoneto group and palces reference
  addStone(StoneData stone) {
    stones.add(stone);
    stone.group = this;
  }

  int sumLiberties() {
    int sumLib = 0;
    for (StoneData stone in stones) {
      sumLib += stone.liberties;
    }
    return sumLib;
  }

  //merge the other group int this group and correct stone info
  merge(Group otherGroup) {
    List<StoneData> stonecollector = [];
    for (StoneData stone in otherGroup.stones) {
      //this.stones.add(stone);
      stonecollector.add(stone);
      //addStone(stone);
    }
    for (StoneData stone in stonecollector) {
      addStone(stone);
    }
  }

  killGroup(Map<String, StoneData> boardState) {
    for (StoneData stone in this.stones) {
      stone.kill(boardState);
    }
    for (StoneData stone in this.stones) {
      stone.recalculateLiberties(boardState);
    }
  }
}

enum Stage { ungrouped, grouped }

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

  bool _checkIfPlacementIsLegal(StoneData theCurrentStone) {
    bool moveLegal = true;
    if (theCurrentStone.liberties == 0) {
      moveLegal = false;
      StoneColor targetCol = _calculateTargetcolor();
      for (BoardCoordiante badNeighbor in theCurrentStone.neighbors) {
        StoneData currentNeighbor =
            boardState[badNeighbor.returnMapCoordiante()];
        if (targetCol == currentNeighbor.color) {
          if (currentNeighbor.group.sumLiberties() > 1) {
            moveLegal = true;
          }
        }
      } // for
    }
    return moveLegal;
  }

  placeStone(BoardCoordiante coord) {
    StoneData theCurrentStone = boardState[coord.returnMapCoordiante()];

    //prevent sucidal moves
    if (!_checkIfPlacementIsLegal(theCurrentStone)) {
      return;
    }

    // Change board state to reflect presence of new stone
    _colorStone(theCurrentStone);

    Group currentGroup;
    Stage stage = Stage.ungrouped;
    //iterate neighbours
    for (BoardCoordiante badNeighbor in theCurrentStone.neighbors) {
      StoneData currentNeighbor = boardState[badNeighbor.returnMapCoordiante()];
      // reduce liberties for all neighbours by 1
      currentNeighbor.liberties--;
      // check for friendlies group up if possible
      if (theCurrentStone.color == currentNeighbor.color) {
        switch (stage) {
          case Stage.ungrouped:
            {
              currentGroup = currentNeighbor.group;
              currentGroup.addStone(theCurrentStone);
              stage = Stage.grouped;
            }
            break;
          case Stage.grouped:
            {
              currentGroup.merge(currentNeighbor.group);
            }
            break;
        }
      }
    } // for
    //If tehstone wasent grouped up it is a gtoup of one
    if (stage != Stage.grouped) {
      currentGroup = Group(theCurrentStone);
    }

    for (BoardCoordiante badNeighbor in theCurrentStone.neighbors) {
      StoneData currentNeighbor = boardState[badNeighbor.returnMapCoordiante()];
      //deal with enenmies
      if (theCurrentStone.color != currentNeighbor.color &&
          currentNeighbor.color != StoneColor.none) {
        if (currentNeighbor.group.sumLiberties() == 0) {
          currentNeighbor.group.killGroup(boardState);
        }
      }
    } // for

    //check for groups and add if possible
    // form groups with all neighbours that are of same color
    // adjust group liberties

    // remove all groups with zero liberties of opposite color

    _changePlayer();
    notifyListeners();
  }

  void _changePlayer() {
    blackToPlay = !blackToPlay;
  }

  StoneColor _calculateTargetcolor() {
    if (blackToPlay) {
      return StoneColor.black;
    } else {
      return StoneColor.white;
    }
  }

  void _colorStone(StoneData theCurrentStone) {
    theCurrentStone.fillOut(_calculateTargetcolor());
  }
}
