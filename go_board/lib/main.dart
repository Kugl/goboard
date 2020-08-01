import 'package:flutter/material.dart';

import 'cross.dart';
import 'stone.dart';

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
  int boardSize = 3;
  Map<BoardCoordiante, Stone> boardState = Map<BoardCoordiante, Stone>();
  @override
  Widget build(BuildContext context) {
    print("I got here");
    for (var x = 0; x < boardSize; x++) {
      for (var y = 0; y < boardSize; y++) {
        BoardCoordiante coord = BoardCoordiante(x, y);
        boardState[coord] = Stone(
          initialColor: StoneColor.none,
          coordinates: coord,
        );
      }
    }
    print("State");
    print(boardState);
    return Grid(
      gridSize: boardSize,
      boardState: boardState,
    );
  }
}

class Grid extends StatelessWidget {
  final int gridSize;
  final Map<BoardCoordiante, Stone> boardState;
  Grid({@required this.gridSize, @required this.boardState});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: generateGrid(rows: gridSize, columns: gridSize),
      ),
    );
  }

  List<Widget> generateGrid({int rows = 1, int columns = 1}) {
    List<Widget> rowList = new List();
    for (var i = rows; i >= 1; i--) {
      rowList.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: generateRow(items: columns, rownumber: i),
        ),
      );
    }
    return rowList;
  }

  List<Widget> generateRow({int items = 0, int rownumber = 0}) {
    List<Widget> list = new List();
    for (var i = items; i >= 1; i--) {
      //TODO: Change to dynamic
      list.add(Cell(stone: boardState[BoardCoordiante(rownumber, i)]));
    }
    return list;
  }
}

class Cell extends StatelessWidget {
  final Stone stone;
  Cell({this.stone});
  @override
  Widget build(BuildContext context) {
    print("Stone:");
    print(stone);
    return Container(
      decoration: BoxDecoration(),
      child: Cross(
        //TODO: fix
        //orientation: CrossOrientation.right,
        child: Padding(padding: const EdgeInsets.all(8.0), child: stone),
      ),
    );
  }
}
