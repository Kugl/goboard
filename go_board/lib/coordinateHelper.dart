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
}

class CoordHelper {
  static String nubmerToLetter(int number) {
    return letters[number];
  }
}
