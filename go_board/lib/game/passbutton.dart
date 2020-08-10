import 'package:flutter/material.dart';
import 'package:go_board/game/gamelogic.dart';
import 'package:provider/provider.dart';

class PassButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GameData game = Provider.of<GameData>(context);
    return Container(
      width: 200,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {},
        child: Text(
          "Pass",
          style:
              TextStyle(color: game.blackToPlay ? Colors.white : Colors.black),
        ),
        color: game.blackToPlay ? Colors.black : Colors.white,
      ),
    );
  }
}
