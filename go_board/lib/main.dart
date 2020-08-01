import 'package:flutter/material.dart';

import 'coordinateHelper.dart';
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

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  int boardSize = 3;
  Map<String, Stone> boardState = Map<String, Stone>();
  @override
  Widget build(BuildContext context) {
    print("I got here");
    for (var x = 0; x < boardSize; x++) {
      for (var y = 0; y < boardSize; y++) {
        BoardCoordiante coord = BoardCoordiante(x, y);
        boardState[coord.returnMapCoordiante()] = Stone(
          initialColor: StoneColor.none,
          coordinates: coord,
        );
      }
    }
    print("State");
    print(boardState);
    return Column(children: [
      Container(
        child: Grid(
          gridSize: boardSize,
          boardState: boardState,
        ),
      ),
      FlatButton(
        onPressed: () {
          print("ShowStone:");
          print(boardState["aa"]);
          print(boardState["aa"].initialColor);
        },
        child: Text("Show Stone"),
      )
    ]);
  }
}

class Grid extends StatelessWidget {
  final int gridSize;
  final Map<String, Stone> boardState;
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
    for (var i = rows - 1; i >= 0; i--) {
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
    for (var i = 0; i <= items - 1; i++) {
      //TODO: Change to dynamic
      list.add(Cell(
          stone:
              boardState[BoardCoordiante(rownumber, i).returnMapCoordiante()]));
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
