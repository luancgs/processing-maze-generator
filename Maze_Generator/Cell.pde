/* Cell class
 
 line: line this cell belongs to in maze matrix
 column: column this cell belong to in maze matrix
 maze: the maze instance this cell belongs to
 visited: if the cell has been visited by the maze generator or not
 walls: hashmap with all the walls that belongs to this cell
 neighbors: hashmap with all adjascent cells
 
 createWalls(): generates all cell walls
 addNeighbors(): checks and adds all cell neighbors
 destroyWall(): destroy the cell wall in the given direction
 
 **/

class Cell {
  int line, column;
  Maze maze;
  boolean visited = false;
  HashMap<Direction, Wall> walls = new HashMap<Direction, Wall>();
  HashMap<Direction, Cell> neighbors = new HashMap<Direction, Cell>();

  Cell(int lin, int col, Maze m) {
    line = lin;
    column = col;
    maze = m;

    this.createWalls();
  }

  private void createWalls() {
    walls.put(Direction.North, new Wall(Direction.North, this));
    walls.put(Direction.South, new Wall(Direction.South, this));
    walls.put(Direction.East, new Wall(Direction.East, this));
    walls.put(Direction.West, new Wall(Direction.West, this));
  }

  void addNeighbors() {

    int line = this.line;
    int col = this.column;

    HashMap<Direction, int[]> possibleNeighbors = new HashMap<Direction, int[]>();

    int[] north = { line - 1, col};
    int[] south = { line + 1, col };
    int[] west = { line, col - 1 };
    int[] east = { line, col + 1 };

    possibleNeighbors.put(Direction.North, north);
    possibleNeighbors.put(Direction.South, south);
    possibleNeighbors.put(Direction.East, east);
    possibleNeighbors.put(Direction.West, west);

    if (line == 0) {
      possibleNeighbors.remove(Direction.North);
    }
    if (col == 0) {
      possibleNeighbors.remove(Direction.West);
    }
    if (line == maze.height-1) {
      possibleNeighbors.remove(Direction.South);
    }
    if (col == maze.width-1) {
      possibleNeighbors.remove(Direction.East);
    }

    for (Map.Entry<Direction, int[]> neighbor : possibleNeighbors.entrySet()) {
      Direction dir = neighbor.getKey();
      int[] coordinates = neighbor.getValue();

      neighbors.put(dir, maze.cells[coordinates[0]][coordinates[1]]);
    }
  }

  void destroyWall(Direction dir) {
    walls.remove(dir);
  }
}
