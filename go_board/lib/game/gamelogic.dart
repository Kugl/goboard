import 'package:flutter/material.dart';
import 'package:go_board/BoardVisu/stone.dart';
import 'package:go_board/helpers/coordinateHelper.dart';

class GameData extends ChangeNotifier {
  Map<String, StoneData> boardState = Map<String, StoneData>();

  bool blackToPlay = true;
  int boardSize = 9;

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
    for (BoardCoordiante badNeighbor in theCurrentStone.neighbors) {
      StoneData currentNeighbor = boardState[badNeighbor.returnMapCoordiante()];
      print(currentNeighbor.liberties);

      if (currentNeighbor.color != StoneColor.none) {
        currentNeighbor.liberties--;
      }
      print(currentNeighbor.liberties);
    }

    // reduce own liberties for each placed stone on neighbour

    //check for groups and add if possible
    // form groups with all neighbours that are of same color
    // adjust group liberties

    // remove all groups with zero liberties of opposite color

    changePlayer();
    notifyListeners();
  }

  void changePlayer() {
    blackToPlay = !blackToPlay;
    notifyListeners();
  }
}
