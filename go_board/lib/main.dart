import 'package:flutter/material.dart';

import 'cross.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoBoard',
      home: Scaffold(
        appBar: AppBar(
          title: Text("GoBoard"),
        ),
        body: Stack(children: [
          Game(),
        ]),
      ),
    );
  }
}

enum StoneColor { black, white, none }

class Stone extends StatelessWidget {
  StoneColor color;
  BoardCoordiante coordinates;
  List<BoardCoordiante> neighbors;
  Stone({this.color = StoneColor.none, @required this.coordinates});
  defineNeighbors() {}
  Color pickStoneColor(StoneColor col) {
    switch (col) {
      case StoneColor.black:
        return Colors.black;
        break;
      case StoneColor.white:
        return Colors.white;
        break;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: pickStoneColor(color),
      //TODO: change first 8 to null
      elevation: (color == StoneColor.none) ? 8 : 8,
      onPressed: () {},
    );
  }
}

class BoardCoordiante {
  int xcoordinate;
  int ycoordinate;
  BoardCoordiante(this.xcoordinate, this.ycoordinate);
}

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  int boardSize = 9;
  Map<BoardCoordiante, Stone> boardState = Map<BoardCoordiante, Stone>();
  @override
  Widget build(BuildContext context) {
    print("I got here");
    for (var x = 0; x < boardSize; x++) {
      for (var y = 0; y < boardSize; y++) {
        BoardCoordiante coord = BoardCoordiante(x, y);
        boardState[coord] = Stone(
          color: StoneColor.none,
          coordinates: coord,
        );
      }
    }
    print("State");
    print(boardState);
    return Grid();
  }
}

class Cell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Cross(
        //TODO: fix
        //orientation: CrossOrientation.right,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stone(
            coordinates: null,
            color: StoneColor.none,
          ),
        ),
      ),
    );
  }
}

class Grid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: generateGrid(rows: 5, columns: 5),
      ),
    );
  }

  List<Widget> generateGrid({int rows = 1, int columns = 1}) {
    List<Widget> list = new List();
    for (var i = rows; i >= 1; i--) {
      list.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: generateRow(items: columns),
        ),
      );
    }
    return list;
  }

  List<Widget> generateRow({int items = 0}) {
    List<Widget> list = new List();
    for (var i = items; i >= 1; i--) {
      //TODO: Change to dynamic
      list.add(Cell());
    }
    return list;
  }
}
