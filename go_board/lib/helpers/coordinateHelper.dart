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
  bool isEqual(BoardCoordiante coord1, BoardCoordiante coord2) {
    return (coord1.xcoordinate == coord2.ycoordinate &&
            coord1.ycoordinate == coord2.ycoordinate)
        ? true
        : false;
  }
}

class CoordHelper {
  static String nubmerToLetter(int number) {
    return letters[number];
  }

  static List<BoardCoordiante> determineNeighbors(
      BoardCoordiante coord, int boardSize) {
    List<BoardCoordiante> list = List<BoardCoordiante>();
    if (coord.xcoordinate > 1) {
      list.add(BoardCoordiante(coord.xcoordinate - 1, coord.ycoordinate));
    }
    if (coord.ycoordinate > 1) {
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
