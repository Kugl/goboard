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
    rowList.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: generateLabels(items: columns),
      ),
    );
    return rowList;
  }

  List<Widget> generateRow({int items = 0, int rownumber = 0}) {
    List<Widget> list = new List();
    StoneData currentStone;
    for (var i = 0; i <= items - 1; i++) {
      currentStone =
          boardState[BoardCoordiante(rownumber, i).returnMapCoordiante()];
      list.add(Cell(
          orientation: determineOrientation(i, rownumber, items),
          stone: Stone(
            coordinates: currentStone.coordinates,
          )));
    }
    list.add(Text((rownumber + 1).toString()));
    return list;
  }
}

CrossOrientation determineOrientation(int i, int rownumber, int items) {
  CrossOrientation orientation;
  if (i == 0 && rownumber == 0) {
    orientation = CrossOrientation.leftbottom;
  } else if (i == 0 && rownumber == items - 1) {
    orientation = CrossOrientation.lefttop;
  } else if (i == items - 1 && rownumber == items - 1) {
    orientation = CrossOrientation.righttop;
  } else if (i == items - 1 && rownumber == 0) {
    orientation = CrossOrientation.rightbottom;
  } else if (i == 0) {
    orientation = CrossOrientation.left;
  } else if (i == items - 1) {
    orientation = CrossOrientation.right;
  } else {
    if (rownumber == 0) {
      orientation = CrossOrientation.bottom;
      //only works for square boards
    } else if (rownumber == items - 1) {
      orientation = CrossOrientation.top;
    } else {
      orientation = null;
    }
  }
  return orientation;
}

List<Widget> generateLabels({int items = 0}) {
  List<Widget> list = new List();
  for (var i = 0; i <= items - 1; i++) {
    list.add(SizedBox(
        height: 40,
        width: 40,
        child: Center(child: Text(letters[i].toUpperCase()))));
  }
  return list;
}

class Cell extends StatelessWidget {
  final Stone stone;
  final CrossOrientation orientation;
  Cell({this.stone, this.orientation});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      //the Cross Widget draws the crosses on the board
      child: Cross(
        orientation: orientation,
        child: Padding(padding: const EdgeInsets.all(1.0), child: stone),
      ),
    );
  }
}
