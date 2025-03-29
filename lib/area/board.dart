import 'package:dart_console/dart_console.dart';

import 'square.dart';


class Board {
  // NOTE: can be changed to maze to diferantiate the {whole area, frame, maze, maybe input or info of some kind}

  // ## CONSTANTS --- --- ---
  static  final BLOCK = '\u2588\u2588';
  static final SPACE = '  ';


  // ## CONSTRUCTORS --- --- ---
  Board({required this.consoleControl, required this.maze});
  
  

  // ## PROPS --- --- ---
  late final int _verticalLength, _horizontalLength;

  final ConsoleControl consoleControl;
  final List<List<Square>> maze;
  // injection of the frameS



  // ## METHOD --- --- ---


  // to the write the frame and the maze
  void letItSo() {
    // for a clean slade
    consoleControl.clean();
    // upper horizontal bar
    consoleControl.write(_horizontalCoordinates());
    consoleControl.writeLine(horizontalWallString());

    // left vertical bar
    consoleControl.write(verticalWallString());

    // maze area
    // consoleControl.cursorPosition = Coordinate(_verticalLength + 1, 1);

  }

  // ## FRAME ---

  // M: to create the horizontal coordinate numbers
  String _horizontalCoordinates() {
    String res = SPACE;
    for (int i = 1; i <= _horizontalLength; i++) {
      res += i < 10 ? '0$i' : '$i';
    }
    return '$res\n';
  }



  // ## UTIL FUNCTIONS --- --- ---

  String horizontalWallString () => BLOCK * (_horizontalLength + 1);
  
  String verticalWallString () => ('$BLOCK\n') * _verticalLength;
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
  void print () {
    
  }

}





class ConsoleControl {
  // ## CONSTRUCTOR --- --- ---
  ConsoleControl() : console = Console();



  // ## PROPS --- --- ---
  final Console console;



  // ## METHODS --- --- ---

  void clean () => console.clearScreen();

  void position (int X, int Y) => console.cursorPosition = Coordinate(Y, X);

  void write (String text) => console.write(text);

  void writeLine (String text) => console.writeLine(text);

  void coloredWrite(ConsoleColor color, String text) {
    console.setForegroundColor(color);
    console.write(text);
    console.resetColorAttributes();
  } // M: utility method to write text with color

}



class Frame {
  // ## CONSTANTS --- --- ---

  // ## CONSTRUCTORS --- --- ---
  Frame(this.start);
  
  // ## PROPS --- --- ---
  // final int horizontalLength, verticalLength;
  int start;
  // inner

  // ## METHOD --- --- ---

  // num bars
  String horizontalNumBar () => '';
  String verticalNumBar () => '';

  // walls
  String horizontalTopWall () => '';
  String horizontalBottomWall () => '';
  // BLOCK * (_horizontalLength + 1);
  String verticalLeftWall () => '';
  String verticalRightWall () => '';
  // ('$BLOCK\n') * _verticalLength; // this is not a good design i think cursor movement is required here


  //   String _horizontalCoordinates() {
  //   String res = SPACE;
  //   for (int i = 1; i <= _horizontalLength; i++) {
  //     res += i < 10 ? '0$i' : '$i';
  //   }
  //   return '$res\n';
  // }
}