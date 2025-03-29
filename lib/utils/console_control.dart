

import 'package:dart_console/dart_console.dart';


class ConsoleControl {
  
  // ## CONSTANTS --- --- ---
  static Coordinate ORIJIN = Coordinate(0, 0);


  // ## CONSTRUCTOR --- --- ---
  ConsoleControl() : console = Console();



  // ## PROPS --- --- ---
  final Console console;
  Coordinate returnPosition = ORIJIN;
  Coordinate bottomLimit = ORIJIN;
  // Coordinate tagPosition;




  // ## METHODS --- --- ---

  void clean () => console.clearScreen();

  void position (int X, int Y) => console.cursorPosition = Coordinate(Y, X);

  void positionToCoordinate(Coordinate coordinate) => console.cursorPosition = coordinate;

  void ping ()  {
    moveToReturnPosition();
    coloredWrite(ConsoleColor.blue, 'x');
    moveToBottomLimit();
  }
  
  void writeBottom (String text) {
    moveToBottomLimit();
    setBottomLimit(console.cursorPosition?? bottomLimit);
    console.write(text);
  }

  void writeRaw (String text) => console.write(text);

  void write (String text)  {
    // move to last valid coordinate
    moveToReturnPosition();
    // write the value
    console.write(text);
    // move to bottom limit
    setBottomLimit(console.cursorPosition?? bottomLimit);
    setReturnPosition(console.cursorPosition?? returnPosition);
    moveToBottomLimit();
  }

  void writeLineRaw (String text) => console.writeLine(text);

  void writeLine (String text)  {
    // move to last valid coordinate
    moveToReturnPosition();
    // write the value
    console.write(text);

    // set new return value 
    int newCol = returnPosition.row + 1 < 1 ? 5 : returnPosition.row + 1;
    Coordinate newLine = Coordinate(newCol, 0);
    console.writeLine(newCol);
    
    setReturnPosition(newLine);
    // returnPosition = newLine;

    // move to bottom limit
    setBottomLimit(newLine);
    moveToBottomLimit();
  }

  void coloredWrite(ConsoleColor color, String text) {
    console.setForegroundColor(color);
    console.write(text);
    console.resetColorAttributes();
  } // M: utility method to write text with color

  void verticalWrite (int horizontalLength, String text) {
    // move to last valid position
    moveToReturnPosition();
    // calc vertical length based on horizontal length
    int verticalLength = (text.length / horizontalLength).ceil();
    // save start postion
    Coordinate startPosition = console.cursorPosition ?? Coordinate(0, 0);
    for (int i = 0; i < verticalLength; i++) {
      // get horizontal line indexes
      int startIdx = i * horizontalLength;
      int endIdx = (i + 1) * horizontalLength;
      // get the horizontal line
      String line = text.substring(startIdx, endIdx > text.length ? text.length : endIdx);
      // change the console position to required position
      console.cursorPosition = Coordinate(startPosition.row + i, startPosition.col);
      // write the console
      console.write(line);
  }

    // get the most bottom position
    Coordinate lastPosition = Coordinate(startPosition.row + verticalLength, startPosition.col);
    // get the new return position
    Coordinate newReturnPosition = Coordinate(startPosition.row, startPosition.col + verticalLength);
    // update the return position and bottom limit
    returnPosition = startPosition;
    setReturnPosition(newReturnPosition);
    // bottomLimit= lastPosition.row > bottomLimit.row ? lastPosition : bottomLimit;
    setBottomLimit(lastPosition);
    // set cursor position
    moveToBottomLimit();
  }

  // ## CURSOR FUNCTIONS --- --- ---
  void moveToBottomLimit()  {positionToCoordinate(bottomLimit);}
  void moveToReturnPosition() {positionToCoordinate(returnPosition);}
  void setBottomLimit(Coordinate coordinate) {bottomLimit = coordinate.row > bottomLimit.row ? coordinate : bottomLimit;}

  void setReturnPosition (Coordinate coordinate)  {
    // console.setForegroundColor(ConsoleColor.blue);
    returnPosition = coordinate;
  }

  void setCursor(int X, int Y)  {positionToCoordinate(Coordinate(Y, X));}

  Coordinate getCoordinate (int X, int Y) => Coordinate(Y, X);
  
  String getReturnPosition () => '(${returnPosition.col}, ${returnPosition.col})';

  String getBottomLimit () => '(${bottomLimit.col}, ${bottomLimit.col})';

}