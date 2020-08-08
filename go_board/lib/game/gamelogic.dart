import 'package:flutter/material.dart';
import 'package:go_board/BoardVisu/stone.dart';
import 'package:go_board/helpers/coordinateHelper.dart';

class Group {
  List<StoneData> stones = [];

  Group.empty();

  Group(StoneData stone) {
    addStone(stone);
  }

//adds stoneto group and palces reference
  addStone(StoneData stone) {
    stones.add(stone);
    stone.group = this;
  }

  Set<String> sumLiberties() {
    Set<String> freeLib = <String>{};
    for (StoneData stone in stones) {
      for (BoardCoordiante coord in stone.freeNeighbors) {
        freeLib.add(coord.returnMapCoordiante());
      }
    }
    return freeLib;
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

class StoneStruct {
  StoneData aStone;
  String stoneCoord;

  StoneStruct(this.stoneCoord, this.aStone);
}

class GameData extends ChangeNotifier {
  Map<String, StoneData> boardState = Map<String, StoneData>();
  var oldBoardState = [];

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
        //Move gets legal if the stone can link up to a group with liberties
        if (targetCol == currentNeighbor.color) {
          if (currentNeighbor.group.sumLiberties().length > 1) {
            moveLegal = true;
            return moveLegal;
          }
        }
        // It also gets legal if capture is possible
        if (targetCol != currentNeighbor.color &&
            currentNeighbor.color != StoneColor.none) {
          if (currentNeighbor.group.sumLiberties().length <= 1) {
            moveLegal = true;
            return moveLegal;
          }
        }
      } // for

    }
    return moveLegal;
  }

  placeStone(BoardCoordiante coord) {
    StoneData theCurrentStone = boardState[coord.returnMapCoordiante()];
    //Stores the old state in case a fallback is necessary e.g. for Ko
    //Map<String, StoneBackup> oldBoardState = _createBackup();

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

    //falls back to old state if move ended up illegal
/*     if (theCurrentStone.liberties == 0) {
      _replayBackup(oldBoardState);
      notifyListeners();
      return;
    } */

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

  Map<String, StoneBackup> _createBackup() {
    Map<String, StoneBackup> backup = Map<String, StoneBackup>();
    boardState.forEach((key, value) {
      backup[key] = StoneBackup(
          color: value.color,
          liberties: value.liberties,
          groupStones: value.group.stones);
    });
    return backup;
  }

  _replayBackup(Map<String, StoneBackup> backup) {
    boardState.forEach((key, value) {
      boardState[key].color = backup[key].color;
      boardState[key].liberties = backup[key].liberties;
      boardState[key].group.stones = backup[key].groupStones;
    });
  }
}
