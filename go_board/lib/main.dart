import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

class GameData extends ChangeNotifier {
  Map<String, StoneData> newBoardState = Map<String, StoneData>();

  bool blackToPlay = true;
  int boardSize = 9;
  Map<String, TheStone> boardState = Map<String, TheStone>();

  //TODO: place stone method
  placeStone(BoardCoordiante coord) {
    newBoardState[coord.returnMapCoordiante()].color = StoneColor.black;

    //boardState[neig.returnMapCoordiante()]
    //do this

    // Change board state to reflect presence of new stone
    // reduce liberties for all neighbours by 1
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

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  GameData game = GameData();

  @override
  Widget build(BuildContext context) {
    for (var x = 0; x < game.boardSize; x++) {
      for (var y = 0; y < game.boardSize; y++) {
        BoardCoordiante coord = BoardCoordiante(x, y);
        List<BoardCoordiante> neibs =
            CoordHelper.determineNeighbors(coord, game.boardSize);
        game.newBoardState[coord.returnMapCoordiante()] = StoneData(
          coordinates: coord,
          liberties: neibs.length,
          color: StoneColor.none,
          neighbors: neibs,
        );
      }
    }
    print("State:");
    print(game.newBoardState);
    //TODO: Container and column can be removed after testing
    return ChangeNotifierProvider<GameData>(
      create: (context) => game,
      child: Column(children: [
        Container(
          child: Grid(
            gridSize: game.boardSize,
            boardState: game.newBoardState,
          ),
        ),
      ]),
    );
  }
}

class Grid extends StatelessWidget {
  final int gridSize;
  final Map<String, StoneData> boardState;
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
    StoneData currentStone;
    for (var i = 0; i <= items - 1; i++) {
      currentStone =
          boardState[BoardCoordiante(rownumber, i).returnMapCoordiante()];
      list.add(Cell(
          stoneSpot: TheStone(
              coordinates: currentStone.coordinates,
              color: currentStone.color)));
    }
    return list;
  }
}

class Cell extends StatelessWidget {
  final TheStone stoneSpot;
  Cell({this.stoneSpot});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Cross(
        //TODO: fix
        //orientation: CrossOrientation.right,
        child: Padding(padding: const EdgeInsets.all(1.0), child: stoneSpot),
      ),
    );
  }
}
