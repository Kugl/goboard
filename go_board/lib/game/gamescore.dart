import 'package:go_board/BoardVisu/stone.dart';
import 'package:go_board/game/group.dart';
import 'package:go_board/helpers/coordinateHelper.dart';

//TODO: implement Area Scoring
// https://www.wikihow.com/Score-a-Game-of-Go
// https://senseis.xmp.net/?Scoring
// https://senseis.xmp.net/?ChineseCounting

//TODO: USe existing group logic for free groups in scoring
class Scorer {
  Map<String, StoneData> boardState;
  Scorer({this.boardState});

  scoreGame() {
    Group freegroup = Group.empty();
    for (StoneData stone in boardState.values) {
      if (stone.color == StoneColor.none) {
        freegroup.addStone(stone);
        _completeFreegroup(freegroup);
      }
    }
  }

  _completeFreegroup(Group freegroup) {
    List<StoneColor> borderstones = [];
    freegroup.stones.forEach((stone) {
      //Check neibor
      //add if free
      //store color if not free to borderstones
      //check off whole group to counted
      //turn all black or white if only on color in borderstones
    });
  }

// TODO: Fix to avoid infinite loop
  List<StoneColor> _completeStone(StoneData stone, Group freegroup) {
    List<StoneColor> colorstones = [];
    for (BoardCoordiante badNeighbor in stone.neighbors) {
      StoneData theNeighborStone = boardState[badNeighbor.toString()];
      if (theNeighborStone.color == StoneColor.none) {
        freegroup.addStone(theNeighborStone);
      } else if (theNeighborStone.color == StoneColor.black ||
          theNeighborStone.color == StoneColor.white) {
        colorstones.add(theNeighborStone.color);
      }
    }
    return colorstones;
  }

  _countSurrounded() {}

  //changes color
  _checkFieldForSurrounded(StoneData stone) {
    if (stone.color == StoneColor.none) {}
  }

  _countStones() {}
}
