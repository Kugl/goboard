import 'package:flutter/material.dart';
import 'package:go_board/BoardVisu/gridAndCell.dart';
import 'package:go_board/game/passbutton.dart';
import 'package:provider/provider.dart';

import 'gamelogic.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    //The Game Data object is where the logic is rooted
    GameData game = GameData();
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
        PassButton(),
      ]),
    );
  }
}
