import 'package:go_board/BoardVisu/stone.dart';
import 'package:go_board/game/gamelogic.dart';
import 'package:go_board/helpers/coordinateHelper.dart';
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

  group('liberties', () {
    GameData testgame = GameData();

    test('Stone ab has two liberties before place', () {
      expect(testgame.boardState["ab"].liberties, 2);
    });

    test('Stone ba has two liberties before place', () {
      expect(testgame.boardState["ba"].liberties, 2);
    });

    test('Stone is palced on aa', () {
      testgame.placeStone(BoardCoordiante(0, 0));
      expect(testgame.boardState["aa"].color == StoneColor.black, true);
    });
    test('Stone ab has one liberties after place', () {
      expect(testgame.boardState["ab"].liberties, 1);
    });

    test('Stone ba has one liberties after place', () {
      expect(testgame.boardState["ba"].liberties, 1);
    });
  });
}
