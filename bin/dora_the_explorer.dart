import 'package:dart_console/dart_console.dart';
import 'package:dora_the_explorer/area/board.dart';
import 'package:dora_the_explorer/area/maze.dart';
import 'package:dora_the_explorer/pathFinder/path_finder.dart';
import 'package:dora_the_explorer/utils/console_control.dart';
// import 'package:dora_the_explorer/dora_the_explorer.dart' as dora_the_explorer;

void main(List<String> arguments) {
  // print('Hello world: ${dora_the_explorer.calculate()}!m\n');
 
  var c = ConsoleControl();
  Board lab = Board(consoleControl: c, horizontalLength: 10, verticalLength: 7);
  lab.printFrame();
  lab.maze.init();



  // Maze maze = Maze.ready();
  // maze.init();
  // Square square = maze.findSquare(2,2);
  Square squareS = lab.maze.findSquare(1,3);
  Square squareG = lab.maze.findSquare(8,6);
  Square squareW = lab.maze.findSquare(4, 3); // coordinate system
  // square.content=Content.trace;
  Maze maze = lab.maze;
  maze.start = squareS;
  maze.goal = squareG;
  PathFinder pf = PathFinder(workingMaze: lab.maze);
  squareW.setContent = Content.wall;
  var res = pf.discover();
  squareG.content = Content.goal;
  squareS.content = Content.start;
  lab.printMaze();
  // print(square);
  // var frm = Frame(6, 6);
  // c.clean();
  // c.verticalWrite(2, frm.verticalNumBar());
  // lab.maze.printMazeCoordinates();
  lab.consoleControl.setReturnPosition(Coordinate(17, 0));
  lab.consoleControl.writeBottom('PATH: ');
  res?.forEach((elm) {lab.consoleControl.write(elm.coordinate.toString());});

  return ;
}
  
  

