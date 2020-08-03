import 'package:flutter/material.dart';
import 'package:go_board/BoardVisu/gridAndCell.dart';
import 'package:go_board/BoardVisu/stone.dart';
import 'package:go_board/helpers/coordinateHelper.dart';
import 'package:provider/provider.dart';

import 'gamelogic.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  //The Game Data object is where the logic is rooted
  GameData game = GameData();

  @override
  Widget build(BuildContext context) {
    for (var x = 0; x < game.boardSize; x++) {
      for (var y = 0; y < game.boardSize; y++) {
        BoardCoordiante coord = BoardCoordiante(x, y);
        List<BoardCoordiante> neibs =
            CoordHelper.determineNeighbors(coord, game.boardSize);
        game.boardState[coord.returnMapCoordiante()] = StoneData(
          coordinates: coord,
          liberties: neibs.length,
          color: StoneColor.none,
          neighbors: neibs,
        );
      }
    }
    print("State:");
    print(game.boardState);
    //TODO: Container and column can be removed after testing
    //Provides the Game data down the tree
    return ChangeNotifierProvider<GameData>(
      create: (context) => game,
      child: Column(children: [
        Container(
          child: Grid(
            gridSize: game.boardSize,
            boardState: game.boardState,
          ),
        ),
      ]),
    );
  }
}
