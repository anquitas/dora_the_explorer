import 'package:dora_the_explorer/area/board.dart';
import 'package:dora_the_explorer/area/maze.dart';
import 'package:dora_the_explorer/pathFinder/path_finder.dart';
import 'package:dora_the_explorer/utils/console_control.dart';
// import 'package:dora_the_explorer/dora_the_explorer.dart' as dora_the_explorer;

void main(List<String> arguments) {
  // print('Hello world: ${dora_the_explorer.calculate()}!m\n');
 
  var c = ConsoleControl();
  Board lab = Board(consoleControl: c, horizontalLength: 6, verticalLength: 5);
  lab.printFrame();
  lab.maze.init();



  // Maze maze = Maze.ready();
  // maze.init();
  // Square square = maze.findSquare(2,2);
  Square squareS = lab.maze.findSquare(1,2);
  Square squareG = lab.maze.findSquare(4,4);
  // square.content=Content.trace;
  Maze maze = lab.maze;
  maze.start = squareS;
  maze.goal = squareG;
  PathFinder pf = PathFinder(workingMaze: lab.maze);
  pf.discover();
  squareG.content = Content.explored;
  squareS.content = Content.explored;
  lab.printMaze();
  // print(square);
  // var frm = Frame(6, 6);
  // c.clean();
  // c.verticalWrite(2, frm.verticalNumBar());

}
