import 'package:dart_console/dart_console.dart';
import 'package:dora_the_explorer/utils/console_control.dart';
import 'maze.dart';


class Board {
  // NOTE: can be changed to maze to diferantiate the {whole area, frame, maze, maybe input or info of some kind}

  // ## CONSTANTS --- --- ---
  static  final BLOCK = '\u2588\u2588';
  static final SPACE = '  ';


  // ## CONSTRUCTORS --- --- ---
  Board({
    required this.consoleControl, 
    required this.horizontalLength, 
    required this.verticalLength,
    }): 
      frame = Frame(horizontalLength, verticalLength),
      maze = Maze.placed(horizontalLength: horizontalLength,verticalLength: verticalLength);
  
  

  // ## PROPS --- --- ---
  late final int verticalLength, horizontalLength;
  final ConsoleControl consoleControl;
  final Maze maze;
  final Frame frame;
  // injection of the frameS



  // ## METHOD --- --- ---


  // to the write the frame and the maze
  void printFrame() {
    // for a clean slade
    consoleControl.clean();

    // upper horizontal numbar
    consoleControl.setReturnPosition(frame.base);
    consoleControl.writeLine(frame.horizontalNumBar());
    consoleControl.writeLine(frame.horizontalNumBar());
    // upper horizontal wall
    consoleControl.setReturnPosition(frame.wallBase);
    consoleControl.write(frame.horizontalWall());

    // right vertical wall
    consoleControl.setReturnPosition(frame.upperRightCorner());
    consoleControl.verticalWrite(2, frame.verticalWall());
    
    // left vertical wall
    consoleControl.setReturnPosition(frame.wallBase);
    consoleControl.verticalWrite(2, frame.verticalWall());

    // bottom horizontal wall
    // consoleControl.ping();
    consoleControl.setReturnPosition(frame.bottomLeftCorner());
    consoleControl.write(frame.horizontalWall());
  }

  void printMaze () {
    int i = 0;
    // consoleControl.ping();
      int realCol = maze.realBase.col;
      int realRow = maze.realBase.row;
    // for (var row in maze.area) {
    //   // consoleControl.setReturnPosition(Coordinate(2 + i, 2));
    //   // consoleControl.setReturnPosition(Coordinate(realRow +i, realCol));
    //   // consoleControl.write(row.map((square) => square.toString()).join(''));
    // }
      for (var mazeCol in maze.area) {
        for (var sqr in mazeCol ) {
          consoleControl.setReturnPosition(Coordinate(realRow + sqr.real.row, realCol + sqr.real.col));
          consoleControl.write(sqr.toString());
        }
      }
      i++;
    
    // consoleControl.ping();
  }



}









class Frame {
  // ## CONSTANTS --- --- ---
  static final BLOCK = '\u2588\u2588';
  static final SPACE = '  ';


  // ## CONSTRUCTORS --- --- ---
  Frame(this.horizontalLength, this.verticalLength, {this.base = const Coordinate(0, 0)});
  

  // ## PROPS --- --- ---
  final int horizontalLength, verticalLength;
  final Coordinate base; // for improvement later
  late final wallBase = Coordinate(base.row + 1, base.col);


  // ## METHOD --- --- ---

  Coordinate upperRightCorner () => Coordinate(wallBase.row, wallBase.col + horizontalLength*2 + 2);
  Coordinate bottomLeftCorner () => Coordinate(wallBase.row + 1 + verticalLength, wallBase.col);


  String numBar (int length) {
    String result = '';

    for (int i = 1; i <= length; i++) {
      result += i.toString().padLeft(2, '0');  // pad with 0 to ensure two digits
    }
    return result;
  }

  // num bars
  String horizontalNumBar () => '  ${numBar(horizontalLength)}' ;
  String verticalNumBar () => ' ${numBar(verticalLength)}';

  // walls
  String horizontalWall () => BLOCK*(horizontalLength + 2);
  String verticalWall () => BLOCK*(verticalLength+1);
}


