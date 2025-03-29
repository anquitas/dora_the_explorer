import 'package:dora_the_explorer/area/board.dart';
import 'package:dora_the_explorer/area/square.dart';
// import 'package:dora_the_explorer/dora_the_explorer.dart' as dora_the_explorer;

void main(List<String> arguments) {
  // print('Hello world: ${dora_the_explorer.calculate()}!m\n');
  // Board lab = Board(5, 8);
  // lab.init();

  // lab.letItSo();

  Maze maze = Maze.ready();
  maze.init();
  Square square = maze.findSquare(2,2) as Square;
  square.content=Content.wall;
  print(square);
  


}
