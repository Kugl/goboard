const List<String> letters = [
  "a",
  "b",
  "c",
  "d",
  "e",
  "f",
  "g",
  "h",
  "i",
  "j",
  "k",
  "l",
  "m",
  "n",
  "o",
  "p",
  "q",
  "r",
  "s",
  "t",
  "u",
  "v",
  "w",
  "x",
  "y",
  "z"
];

class BoardCoordiante {
  int xcoordinate;
  int ycoordinate;

  BoardCoordiante(this.xcoordinate, this.ycoordinate);

  String returnMapCoordiante() {
    String coord = CoordHelper.nubmerToLetter(xcoordinate) +
        CoordHelper.nubmerToLetter(ycoordinate);
    return coord;
  }

//TODO: add a variety to check this vs. others
  bool isEqual(BoardCoordiante coord2) {
    return (this.xcoordinate == coord2.ycoordinate &&
            this.ycoordinate == coord2.ycoordinate)
        ? true
        : false;
  }

  printCoord() {
    print(
        "Coordiantes " + xcoordinate.toString() + " " + ycoordinate.toString());
  }
}

class CoordHelper {
  static String nubmerToLetter(int number) {
    return letters[number];
  }

  static List<BoardCoordiante> determineNeighbors(
      BoardCoordiante coord, int boardSize) {
    List<BoardCoordiante> list = List<BoardCoordiante>();
    if (coord.xcoordinate >= 1) {
      list.add(BoardCoordiante(coord.xcoordinate - 1, coord.ycoordinate));
    }
    if (coord.ycoordinate >= 1) {
      list.add(BoardCoordiante(coord.xcoordinate, coord.ycoordinate - 1));
    }
    if (coord.ycoordinate < boardSize - 1) {
      list.add(BoardCoordiante(coord.xcoordinate, coord.ycoordinate + 1));
    }
    if (coord.xcoordinate < boardSize - 1) {
      list.add(BoardCoordiante(coord.xcoordinate + 1, coord.ycoordinate));
    }

    return list;
  }
}
