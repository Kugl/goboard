import 'package:flutter/material.dart';
import 'package:go_board/helpers/coordinateHelper.dart';

import 'cross.dart';
import 'stone.dart';

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
          stoneSpot: Stone(
        coordinates: currentStone.coordinates,
      )));
    }
    return list;
  }
}

class Cell extends StatelessWidget {
  final Stone stoneSpot;
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
