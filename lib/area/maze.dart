
// # CONTENT ENUM --- --- --- --- --- ---
enum Content {
  // ## VALUES --- --- ---
  wall('\u2588\u2588'), // █
  road('  '), // empty space
  explored('\u2022\u2022'), // •
  trace('\u2593\u2593'), // ▓
  start('SS'),
  goal('GG'),
  opened('\u2591\u2591'); // ░
  

  // ## CONSTRUCTOR --- --- ---
  const Content(this.symbol);

  // ## PROPS --- --- ---
  final String symbol;
  

  // ## METHODS --- --- ---
  @override
  String toString() => symbol;
}



// # MAZE CLASS --- --- --- --- --- ---
class Maze {
  // ## CONSTRUCTORS --- --- ---
  Maze.verbose({
    required int startRealX,
    required int startRealY,
    required this.horizontalLength,
    required this.verticalLength,
  }): realBase = RealCoordinate(startRealX, startRealY) ;

  // maze structure should be created by a seperate grid class

  Maze.placed({required this.horizontalLength, required this.verticalLength})
    : realBase = RealCoordinate(2, 2);

  Maze.ready()
    : realBase = RealCoordinate(2, 2),
      horizontalLength = 6,
      verticalLength = 6;

  // ## PROPS --- --- ---
  final int horizontalLength, verticalLength;
  late Square start;
  late Square goal;
  
  final RealCoordinate realBase;
  late List<List<Square>> area;

  


  // ## METHODS --- --- ---
  void init() {
    // go over creating nodes with right coordinates that also matches data implementation and visual representation
    area = List.generate(
      horizontalLength,
      (x) => List.generate(
        verticalLength,
        (y) => Square(x+1, y+1, Content.road,realBase),
        growable: false,
      ),
    );
    assert(area.length == horizontalLength);
  }



  Square findSquare(int X, int Y) {
    Square res = area[X-1][Y-1];
    assert(res.coordinate.check(X, Y));
    return res;
  }


  List<Square> menhattenNeightbors (Square square) {
    // manhatten neighbor list to return
    List<Square> neighbors = [];
    // current square 
    int x = square.X;
    int y = square.Y;

  if (x > 1 && findSquare(x-1,y).notWall()) neighbors.add(findSquare(x-1,y)); // Left
  if (x < horizontalLength  && findSquare(x+1,y).notWall()) neighbors.add(findSquare(x+1,y)); // Right
  if (y > 1 && findSquare(x,y-1).notWall()) neighbors.add(findSquare(x,y-1)); // Up
  if (y < verticalLength && findSquare(x,y+1).notWall()) neighbors.add(findSquare(x,y+1)); // Down

  return neighbors;
  }


  void printMazeCoordinates () {
    for (var row in area) {
    print(row.map((square) => square.coordinate).join());
  }
  }

  // ## OVERRIDEN METHODS --- --- ---

  // ## UTIL METHODS --- --- ---
}



// # SQUARE CLASS --- --- --- --- --- ---
class Square {
  // ## CONSTRUCTORS --- --- ---
  Square(X, Y, this.content, this.realBase) : coordinate = MazeCoordinate(X, Y);
  Square.fromCoordinate(this.coordinate, this.content, this.realBase);
  Square.wall(X, Y, this.realBase) : coordinate = MazeCoordinate(X, Y), content = Content.wall;
  Square.road(X, Y, this.realBase) : coordinate = MazeCoordinate(X, Y), content = Content.road;

  // ## PROPS --- --- ---
  MazeCoordinate coordinate;
  Content content;
  int length = 2;
  RealCoordinate realBase;

  int gCost = 99999;
  int hCost = 0;
  Square? parent;

  // ## GETTERS --- --- ---
  RealCoordinate get real => coordinate.real;

  int get X => coordinate.X;
  int get Y => coordinate.Y;
  int get getRealRow => coordinate.Y;
  int get getRealCol => coordinate.X;

  int get fCost => gCost + hCost;

  // ## SETTERS --- --- ---
    set setContent(Content newContent) {
    if (content != Content.start && content != Content.goal) {
      content = newContent;
    }
  }


  // ## METHODS --- --- ---
  bool notWall () => content != Content.wall;

  

  @override
  String toString() => content.toString();
}





class MazeCoordinate {
  // ## CONSTRUCTORS --- --- ---
  MazeCoordinate(this.X, this.Y): real = RealCoordinate.fromMazeCoordinate(X, Y);
  MazeCoordinate.start() : X = 1, Y = 1, real = RealCoordinate(0, 0);

  // ## PROPERTIES --- --- ---
  final int X, Y;
  final RealCoordinate real;

  // ## METHODS --- --- ---
  bool check(int X, int Y) => X == this.X && Y == this.Y;
  bool isSame(MazeCoordinate mazeCoordinate) => mazeCoordinate.X == X && mazeCoordinate.Y == Y;

  bool isManhattanNeighbor (MazeCoordinate coordinate) {
    int dx = horizontalDistance(coordinate);
    int dy = verticalDistance(coordinate);
    return (dx == 1 && dy == 0) || (dx == 0 && dy == 1);
  }
  // question: why cant i make this required
 
  // distances
  int horizontalDistance(MazeCoordinate destination) => (X - destination.X).abs();

  int verticalDistance(MazeCoordinate destination) => (Y - destination.Y).abs();

  int manhattanDistance(MazeCoordinate destination) => horizontalDistance(destination) + verticalDistance(destination);


  // ## OVERRIDEN METHODS --- --- ---
  @override
  String toString() => '($X, $Y)';
}



class RealCoordinate {
  // ## CONSTRUCTORS --- --- ---
  RealCoordinate(this.X, this.Y);
  RealCoordinate.fromMazeCoordinate(int X, int Y): X=(X-1)*2, Y=(Y-1);
  RealCoordinate.origin() : X = 0, Y = 0;

  // ## PROPERTIES --- --- ---
  int X, Y;
  int get col => X;
  int get row => Y;

  // ## METHODS --- --- ---
  bool check(int X, int Y) => X == this.X && Y == this.Y;
  bool isSame(RealCoordinate realCoordinate) => realCoordinate.X == X && realCoordinate.Y == Y;



  // ## OVERRIDEN METHODS --- --- ---
  @override
  String toString() => '($X, $Y)';
}