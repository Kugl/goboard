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
      expect(testgame.boardState["ab"].freeNeighbors.length, 3);
    });

    test('Stone ab has two liberties', () {
      expect(testgame.boardState["ba"].freeNeighbors.length, 3);
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
      expect(testgame.boardState["ab"].freeNeighbors.length, 3);
    });

    test('Stone ba has two liberties before place', () {
      expect(testgame.boardState["ba"].freeNeighbors.length, 3);
    });

    test('Stone is palced on aa', () {
      testgame.placeStone(BoardCoordiante(0, 0));
      expect(testgame.boardState["aa"].color == StoneColor.black, true);
    });
    test('Stone ab has two liberties after place', () {
      print(testgame.boardState["ab"].freeNeighbors);
      expect(testgame.boardState["ab"].freeNeighbors.length, 2);
    });

    test('Stone ba has two liberties after place', () {
      expect(testgame.boardState["ba"].freeNeighbors.length, 2);
    });
  });

  group('smallGroups', () {
    GameData testgame = GameData();
    testgame.placeStone(BoardCoordiante(0, 0));
    testgame.placeStone(BoardCoordiante(1, 1));
    testgame.placeStone(BoardCoordiante(0, 1));

    test('Stone aa has one liberties after place', () {
      expect(testgame.boardState["aa"].freeNeighbors.length, 1);
    });
    test('Stone ab has one liberties after place', () {
      expect(testgame.boardState["ab"].freeNeighbors.length, 1);
    });

    test('White group length is correct', () {
      Group whitegroup = testgame.boardState["bb"].group;
      expect(whitegroup.stones.length, 1);
    });

    test('Black group length is correct', () {
      Group whitegroup = testgame.boardState["aa"].group;
      expect(whitegroup.stones.length, 2);
    });
  });
  group('Groups', () {
    GameData testgame = GameData();
    testgame.placeStone(BoardCoordiante(0, 0));
    testgame.placeStone(BoardCoordiante(1, 1));
    testgame.placeStone(BoardCoordiante(0, 1));
    testgame.placeStone(BoardCoordiante(1, 2));
    testgame.placeStone(BoardCoordiante(0, 3));
    testgame.placeStone(BoardCoordiante(2, 2));
    testgame.placeStone(BoardCoordiante(0, 2));
    testgame.placeStone(BoardCoordiante(5, 5));

    test('Stone aa has one liberties after place', () {
      expect(testgame.boardState["aa"].freeNeighbors.length, 1);
    });
    test('Stone ab has zero liberties after place', () {
      expect(testgame.boardState["ab"].freeNeighbors.length, 0);
    });
    test('Single stone has a group', () {
      expect(testgame.boardState["ff"].group != null, true);
    });

    test('White group length is correct', () {
      Group whitegroup = testgame.boardState["bb"].group;
      expect(whitegroup.stones.length, 3);
    });

    test('Black group length is correct', () {
      Group blackgroup = testgame.boardState["aa"].group;
      expect(blackgroup.stones.length, 4);
    });
    test('Coordinates are correct', () {
      Group blackgroup = testgame.boardState["aa"].group;
      expect(blackgroup.stones[0].coordinates.returnMapCoordiante(), "aa");
      expect(blackgroup.stones[1].coordinates.returnMapCoordiante(), "ab");
      expect(blackgroup.stones[2].coordinates.returnMapCoordiante(), "ac");
      expect(blackgroup.stones[3].coordinates.returnMapCoordiante(), "ad");
    });

    test('Libertiy sum is correct', () {
      Group blackgroup = testgame.boardState["aa"].group;
      expect(blackgroup.sumLiberties().length, 3);
    });

    test('White Coordinates are correct', () {
      Group whitegroup = testgame.boardState["bb"].group;
      expect(whitegroup.stones[0].coordinates.returnMapCoordiante(), "bb");
      expect(whitegroup.stones[1].coordinates.returnMapCoordiante(), "bc");
      expect(whitegroup.stones[2].coordinates.returnMapCoordiante(), "cc");
    });

    test('White Libertiy sum is correct', () {
      Group whitegroup = testgame.boardState["bb"].group;
      expect(whitegroup.stones[0].freeNeighbors.length, 2);
      expect(whitegroup.stones[1].freeNeighbors.length, 1);
      expect(whitegroup.stones[2].freeNeighbors.length, 3);
      expect(whitegroup.sumLiberties().length, 5);
    });
  });
  group('capturing', () {
    GameData testgame = GameData();
    testgame.placeStone(BoardCoordiante(0, 0));
    testgame.placeStone(BoardCoordiante(1, 0));
    testgame.placeStone(BoardCoordiante(1, 1));
    testgame.placeStone(BoardCoordiante(2, 0));
    testgame.placeStone(BoardCoordiante(2, 1));
    testgame.placeStone(BoardCoordiante(5, 5));
    testgame.placeStone(BoardCoordiante(3, 0));
    testgame.placeStone(BoardCoordiante(0, 1));

    test('Stone aa has one liberties after place', () {
      expect(testgame.boardState["aa"].freeNeighbors.length, 1);
    });
    test('Stone da has three liberties after place', () {
      expect(testgame.boardState["da"].freeNeighbors.length, 3);
    });

    test('Stone bb has two liberties after place', () {
      expect(testgame.boardState["bb"].freeNeighbors.length, 2);
    });

    test('Stone cb has three liberties after place', () {
      expect(testgame.boardState["cb"].freeNeighbors.length, 3);
    });

    test('Stone ab has one liberties after place', () {
      expect(testgame.boardState["ab"].freeNeighbors.length, 1);
    });

    test('Color bb is black', () {
      expect(testgame.boardState["bb"].color == StoneColor.black, true);
    });

    test('Color ba is none', () {
      expect(testgame.boardState["ba"].color == StoneColor.none, true);
    });
    test('Color aa is black', () {
      expect(testgame.boardState["aa"].color == StoneColor.black, true);
    });
  });
  group('More capturing', () {
    GameData testgame = GameData();
    testgame.placeStone(BoardCoordiante(0, 0));
    testgame.placeStone(BoardCoordiante(1, 2));
    testgame.placeStone(BoardCoordiante(1, 1));
    testgame.placeStone(BoardCoordiante(0, 3));
    testgame.placeStone(BoardCoordiante(0, 2));
    testgame.placeStone(BoardCoordiante(0, 1));

    test('Stone aa has one liberties after place', () {
      expect(testgame.boardState["aa"].freeNeighbors.length, 1);
    });
    test('Stone ab has three liberties after place', () {
      expect(testgame.boardState["ab"].freeNeighbors.length, 1);
    });

    test('Stone bc has three liberties after place', () {
      expect(testgame.boardState["bc"].freeNeighbors.length, 3);
    });

    test('Color ab is white', () {
      expect(testgame.boardState["ab"].color == StoneColor.white, true);
    });

    test('Color ac is none', () {
      expect(testgame.boardState["ac"].color == StoneColor.none, true);
    });
  });
}
