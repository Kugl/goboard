import 'package:go_board/game/gamelogic.dart';
import 'package:test/test.dart';

void main() {
  group('Game', () {
    GameData testgame = GameData();
    test('Stone with coord cd exists and has a color property', () {
      expect(testgame.boardState["cd"].color != null, true);
    });
    test('Stone with coord zz does not exist', () {
      expect(testgame.boardState["zz"] == null, true);
    });

    //liberties
    test('Stone aa has two neighbors', () {
      expect(testgame.boardState["aa"].neighbors.length == 2, true);
    });
    test('Stone aa has a fist neighbor ab ', () {
      expect(
          testgame.boardState["aa"].neighbors[0].returnMapCoordiante() == "ab",
          true);
    });
    test('Stone aa has a second neighbor ba', () {
      expect(
          testgame.boardState["aa"].neighbors[1].returnMapCoordiante() == "ba",
          true);
    });

    test('Stone ab has two liberties', () {
      expect(testgame.boardState["ab"].liberties == 2, true);
    });

    test('Stone ab has two liberties', () {
      expect(testgame.boardState["ba"].liberties == 2, true);
    });
  });
  //Tests for 9x9
  group('9x9', () {
    GameData testgame = GameData();
    test('Stone with coord ii exists and has a color property', () {
      expect(testgame.boardState["ii"].color != null, true);
    });

    test('Stone ii has a fist neighbor ji ', () {
      print(testgame.boardState["ii"].neighbors[0]);
      expect(
          testgame.boardState["ii"].neighbors[0].returnMapCoordiante() == "hi",
          true);
    });
    test('Stone ii has a second neighbor ij', () {
      expect(
          testgame.boardState["ii"].neighbors[1].returnMapCoordiante() == "ih",
          true);
    });
  });
}
