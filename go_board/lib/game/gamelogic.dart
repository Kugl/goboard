import 'package:flutter/material.dart';
import 'package:go_board/BoardVisu/stone.dart';
import 'package:go_board/game/group.dart';
import 'package:go_board/helpers/coordinateHelper.dart';

enum Stage { ungrouped, grouped }

class StoneStruct {
  StoneData aStone;
  String stoneCoord;

  StoneStruct(this.stoneCoord, this.aStone);
}

class GameData extends ChangeNotifier {
  Map<String, StoneData> boardState = Map<String, StoneData>();
  //Old coordinate for Ko check. Coord outside the board as 0. (Biggest GoBoard is 19x19)
  BoardCoordiante oldcoord = BoardCoordiante(20, 20);

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
          color: StoneColor.none,
          neighbors: neibs,
        );
      }
    }
  }

  bool _checkIfPlacementIsLegal(
      StoneData theCurrentStone, BoardCoordiante oldcoord) {
    bool moveLegal = true;
    if (theCurrentStone.freeNeighbors.length == 0) {
      moveLegal = false;
      //Ko!
      if (theCurrentStone.coordinates.returnMapCoordiante() ==
          oldcoord.returnMapCoordiante()) {
        return moveLegal;
      }
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
    if (!_checkIfPlacementIsLegal(theCurrentStone, oldcoord)) {
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
      currentNeighbor.freeNeighbors
          .remove(theCurrentStone.coordinates.returnMapCoordiante());
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

    oldcoord = BoardCoordiante(20, 20);
    List<StoneData> deadstones = [];
    for (BoardCoordiante badNeighbor in theCurrentStone.neighbors) {
      StoneData currentNeighbor = boardState[badNeighbor.returnMapCoordiante()];
      //deal with enenmies
      if (theCurrentStone.color != currentNeighbor.color &&
          currentNeighbor.color != StoneColor.none) {
        if (currentNeighbor.group.sumLiberties().length == 0) {
          deadstones.addAll(currentNeighbor.group.killGroup(boardState));
        }
      }
    } // for

    //KO rules
    if (deadstones.length == 1) {
      oldcoord = deadstones[0].coordinates;
    }

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

/*   Map<String, StoneBackup> _createBackup() {
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
  } */
}
