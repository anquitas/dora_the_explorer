// # in square or coordinate
// coordinate length
// horizontal length
// vertical length
// manhattan length

// # int algo
// from selected to Start length // g_cost = 9999
// from selected to end length // h_cost = 0
// f_cost = g_cost + h_cost

import 'package:dora_the_explorer/area/maze.dart';

class PathFinder {
  // ## CONSTRUCTORS --- --- ---
  PathFinder({required this.workingMaze});

  // ## PROPS --- --- ---
  Maze workingMaze;
  // open list
  List<Square> openList = [];
  Set<Square> closedList = {};
  // closed list

  // ## METHODS --- --- ---

  // heuristic cost, estimated cost to goal

  // given cost
  // final cost
  // neighboring  squares
  // explore -- update neighbors' costs, move from open to closed
  List<Square>? discover() {
    // squares selected for exploration
    
    // SET START VALUES
    workingMaze.start.gCost = 0;
    workingMaze.start.hCost = heuristic(workingMaze.start, workingMaze.goal);
    openList.add(workingMaze.start); // add the start for the process to begin

    while (openList.isNotEmpty) {
      // to be able to select the square with the lowest cost
      openList.sort((a, b) => a.fCost.compareTo(b.fCost));
      // get the lowest lowest full cost opened square
      Square current = openList.removeAt(0);

      // if selected square is the goal
      if (current == workingMaze.goal) {
        // to reconstruct the path w backtracking
        List<Square> path = [];
        // backtracking sub algorithm, until path reaches back to the start square
        while (current != workingMaze.start) {
          path.add(current);
          current = current.parent!;
        }
        // add the starting location wo breaking the backracking loop
        path.add(workingMaze.start);
        // reverse direction to be (start -> goal)
        path.forEach((square) => square.setContent = Content.trace); // style update
        return path.reversed.toList();
      }

      // openList.remove(current); // redundent
      current.setContent = Content.explored; // style update
      closedList.add(current); // mark as explored

      // to ... neighbours of the currently selected cell
      for (var neighbor in workingMaze.menhattenNeightbors(current)) {

        // if closed skip it
        if (closedList.contains(neighbor)) continue;

        // forward movement gCost update
        int tentativeGCost = current.gCost + 1;

        // check if the neighbors gCost is lower then forward movement
        // if so and if it is not on opened list and it is not on closed list it means it is not opened yet
        // and forward mowement doesnt make us stray from the goal (gCost is lower then forward movement)
        if (!openList.contains(neighbor) || tentativeGCost < neighbor.gCost) {
          // update the cost values, to compare
          neighbor.gCost = tentativeGCost;
          neighbor.hCost = heuristic(neighbor, workingMaze.goal);
          neighbor.parent = current;

          if (!openList.contains(neighbor)) { // list and style update
            neighbor.setContent = Content.opened; // style update
            openList.add(neighbor); // open new squares to be explored
            }
        }
      }
    } // while

    return null;
  } // discover

  // ## UTIL FUNCTIONS --- --- ---
  static int heuristic(Square a, Square b) => (a.X - b.X).abs() + (a.Y - b.Y).abs();


} // PathFinder
