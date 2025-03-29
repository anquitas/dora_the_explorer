import 'package:dart_console/dart_console.dart';
import 'package:dora_the_explorer/area/Square.dart';


final BLOCK = '\u2588\u2588';
final SPACE = '  ';


class Board {
  // NOTE: can be changed to maze to diferantiate the {whole area, frame, maze, maybe input or info of some kind}

  // ## CONSTRUCTORS --- --- ---
  Board(this._verticalLength, this._horizontalLength);

  // ## PROPS --- --- ---
  final int _verticalLength, _horizontalLength;
  late List<List<Square>> maze;
  final console = Console();

  // ## METHOD --- --- ---
  void init() {
    // go over creating nodes with right coordinates that also matches data implementation and visual representation
    maze = List.generate(
      _horizontalLength,
      (x) => List.generate(
        _verticalLength,
        (y) => Square(x, y, Content.road),
        growable: false,
      ),
    );
  }

  // to the write the frame and the maze
  void letItSo() {
    // for a clean slade
    console.clearScreen();
    // upper horizontal bar
    console.write(_horizontalCoordinates());
    console.writeLine(_createHorizontalWall());

    // left vertical bar
    console.write(_createVerticalWall());

    // maze area

    console.cursorPosition = Coordinate(_verticalLength + 1, 1);

    // info on coordinates
    // maze.forEach((x) => {x.forEach((s) => {console.write(s.coordinate)})} );
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

  String _createHorizontalWall() => BLOCK * (_horizontalLength + 1);

  String _createVerticalWall() => ('$BLOCK\n') * _verticalLength;

  // ## UTIL FUNCTIONS ---
  // M: utility method to write text with color
  void coloredWriting(ConsoleColor color, String text) {
    console.setForegroundColor(color);
    console.write(text);
    console.resetColorAttributes();
  }
}
