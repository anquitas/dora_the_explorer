enum Content {
  // ## VALUES --- --- ---
  wall('\u2588\u2588'), // █
  road('  '), // empty space
  explored('\u2593\u2593'), // ▓
  trace('\u2022\u2022');
  // explored = '\u2591\u2591'; // ░

  // ## CONSTRUCTOR --- --- ---
  const Content(this.symbol);

  // ## PROPS --- --- ---
  final String symbol;

  // ## METHODS --- --- ---
  @override
  String toString() => symbol;
}

class MazeCoordinate {
  // ## CONSTRUCTORS --- --- ---
  MazeCoordinate(this.X, this.Y);
  MazeCoordinate.origin() : X = 0, Y = 0;

  // ## PROPERTIES --- --- ---
  int X, Y;

  // ## METHODS --- --- ---
  bool check(int X, int Y) => X == this.X && Y == this.Y;
  bool isSame(MazeCoordinate mazeCoordinate) => mazeCoordinate.X == X && mazeCoordinate.Y == Y;
  // question: why cant i make this required
  int horizontalDistance(MazeCoordinate destination) =>
      (X - destination.X).abs();
  int verticalDistance(MazeCoordinate destination) => (Y - destination.Y).abs();
  int manhattanDistance(MazeCoordinate destination) =>
      horizontalDistance(destination) + verticalDistance(destination);

  // ## OVERRIDEN METHODS --- --- ---
  @override
  String toString() => '($X, $Y)';
}

class Square {
  // ## CONSTRUCTORS --- --- ---
  Square(X, Y, this.content) : coordinate = MazeCoordinate(X, Y);
  Square.fromCoordinate(this.coordinate, this.content);
  Square.wall(X, Y) : coordinate = MazeCoordinate(X, Y), content = Content.wall;
  Square.road(X, Y) : coordinate = MazeCoordinate(X, Y), content = Content.road;

  // ## PROPS --- --- ---
  MazeCoordinate coordinate;
  Content content;

  // ## METHODS --- --- ---
  @override
  String toString() => content.toString();
}
