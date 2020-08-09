import 'package:go_board/BoardVisu/stone.dart';

class Group {
  List<StoneData> stones = [];

  Group.empty();

  Group(StoneData stone) {
    addStone(stone);
  }

//adds stoneto group and palces reference
  addStone(StoneData stone) {
    stones.add(stone);
    stone.group = this;
  }

  Set<String> sumLiberties() {
    Set<String> freeLib = <String>{};
    for (StoneData stone in stones) {
      for (String coord in stone.freeNeighbors) {
        freeLib.add(coord);
      }
    }
    return freeLib;
  }

  //merge the other group int this group and correct stone info
  merge(Group otherGroup) {
    List<StoneData> stonecollector = [];
    for (StoneData stone in otherGroup.stones) {
      //this.stones.add(stone);
      stonecollector.add(stone);
      //addStone(stone);
    }
    for (StoneData stone in stonecollector) {
      addStone(stone);
    }
  }

  List<StoneData> killGroup(Map<String, StoneData> boardState) {
    for (StoneData stone in this.stones) {
      stone.kill(boardState);
    }
    for (StoneData stone in this.stones) {
      stone.recalculateFreeNeigbors(boardState);
    }
    return stones;
  }
}
