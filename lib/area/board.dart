import 'package:dart_console/dart_console.dart';
import 'package:dora_the_explorer/utils/console_control.dart';

import 'square.dart';


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
    consoleControl.writeLine(frame.horizontalNumBar());
    // upper horizontal wall
    consoleControl.writeLine(frame.horizontalWall());
    // left vertical wall
    // consoleControl.verticalWrite(2, frame.verticalWall());
    consoleControl.writeBottom(consoleControl.getReturnPosition());
    
    // consoleControl.writeBottom(consoleControl.getBottomLimit());
    // bottom vertical wall
    // consoleControl.writeRaw('(${consoleControl.returnPosition.col}, ${consoleControl.returnPosition.col})');
    
    // consoleControl.writeBottom(consoleControl.getReturnPosition());
    // consoleControl.write(frame.horizontalWall());
    // consoleControl.ping();

    // right vertical wall
    // consoleControl.verticalWrite(2, frame.verticalWall());



    // upper horizontal bar
    // consoleControl.writeLineRaw(horizontalWallString());




    // maze area
    

  }


}


class Maze {
  // ## CONSTRUCTORS --- --- ---
  Maze.verbose({
    required this.startX,
    required this.startY,
    required this.horizontalLength,
    required this.verticalLength,
  });

  // maze structure should be created by a seperate grid class

  Maze.placed({required this.horizontalLength, required this.verticalLength})
    : startX = 3,
      startY = 3;

  Maze.ready()
    : startX = 3,
      startY = 3,
      horizontalLength = 6,
      verticalLength = 6;

  // ## PROPS --- --- ---
  final int horizontalLength, verticalLength;
  final int startX, startY;
  late List<List<Square>> area;
  late final Console console;


  // ## METHODS --- --- ---
  void init() {
    // go over creating nodes with right coordinates that also matches data implementation and visual representation
    area = List.generate(
      horizontalLength,
      (x) => List.generate(
        verticalLength,
        (y) => Square(x, y, Content.road),
        growable: false,
      ),
    );
    assert(area.length == horizontalLength);
  }

  void inject(Console console) => this.console = console;


  Square findSquare(int X, int Y) {
    Square res = area[X+1][Y+1];
    assert(res.coordinate.check(X, Y));
    return res;
  }

  // ## OVERRIDEN METHODS --- --- ---

  // ## UTIL METHODS --- --- ---
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


  // ## METHOD --- --- ---
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
  String verticalWall () => BLOCK*(verticalLength + 1 );
}


