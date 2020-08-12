import 'package:flutter/material.dart';
import 'package:go_board/BoardVisu/snackbar.dart';
import 'package:go_board/game/gamelogic.dart';
import 'package:provider/provider.dart';

class PassButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> _showGameOverDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Game Over'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Both players passed. The game is over'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Approve'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    GameData game = Provider.of<GameData>(context);
    return Container(
      width: 200,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {
          SnackWrap.createSnackBar(context, text: "Passed");
          bool gameover = game.passTurn();
          if (gameover == true) {
            _showGameOverDialog();
          }
        },
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
