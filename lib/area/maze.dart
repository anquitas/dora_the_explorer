

import 'package:dart_console/dart_console.dart';

import 'Square.dart';

final BLOCK = '\u2588\u2588';
// final EXPLORED = '\u2591\u2591'; // del
final EXPLORED = '\u2593\u2593'; // del
final SPACE = '  ';




class Maze { 
  // NOTE: can be changed to board to diferantiate the {whole area, frame, maze, maybe input or info of some kind}

  // ## CONSTRUCTORS --- --- ---
  Maze (this._verticalLength, this._horizontalLength);

  // ## PROPS --- --- ---
  final int _verticalLength, _horizontalLength;
  late List<List<Square>> board;
  final console = Console();


  // ## METHOD --- --- ---
  void init () {
    // go over creating nodes with right coordinates that also matches data implementation and visual representation
    board = List.generate(_verticalLength, (y) => 
      List.generate(_horizontalLength, (x) => Square(x, y, Content.road), growable: false)
    );
  }
  
  // to the write the frame and the maze
  void letItSo () {
    // for a clean slade
    console.clearScreen(); 
    // upper horizontal bar
    console.write(_horizontalCoordinates());
    console.writeLine(_createHorizontalWall());

    // left vertical bar
    console.write(_createVerticalWall());

    // maze area
    console.cursorPosition = Coordinate(4, 4);
    // console.setForegroundColor(ConsoleColor.blue);
    // console.write(TRACE);
    _coloredWriting(ConsoleColor.blue, EXPLORED);
    console.cursorPosition = Coordinate(_verticalLength+ 1, 1);

    // info on coordinates
    // board.forEach((x) => {x.forEach((s) => {console.write(s.coordinate)})} );
  }

  // ## FRAME ---

  // M: to create the horizontal coordinate numbers
  String _horizontalCoordinates () {
    String res = SPACE;
    for (int i=1; i<=_horizontalLength; i++) {
      res += i<10? '0$i': '$i';
    }
    return '$res\n';
  }
  
  String _createHorizontalWall() => BLOCK*(_horizontalLength + 1);
  
  String _createVerticalWall() => ('$BLOCK\n')*_verticalLength;
  
  // ## UTIL FUNCTIONS ---
  // M: utility method to write text with color
  void _coloredWriting(ConsoleColor color, String text) {
    console.setForegroundColor(color);
    console.write(text);
    console.resetColorAttributes();
  }

}