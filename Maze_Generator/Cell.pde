/* Cell class
  
  line: line number in maze matrix
  col: column number in maze matrix
  xpos: horizontal coordinate in screen
  ypos: vertical coordinate in screen
  side: how many pixels has a cell side
  
  maze: the maze instance this cell belongs to
  
  visited: if the cell has been visited by the maze generator or not
  
  walls: hashmap with all the walls that belongs to this cell
  neighbors: hashmap with all adjascent cells
  
**/

class Cell {
  int line, col, xpos, ypos, size;
  Maze maze;
  boolean visited = false;
  HashMap<Direction, Wall> walls = new HashMap<Direction, Wall>();
  HashMap<Direction, Cell> neighbors = new HashMap<Direction, Cell>();
  
  Cell(int matrixLine, int matrixCol, int side, Maze m){
    line = matrixLine;
    col = matrixCol;
    
    size = side;
    xpos = col*size;
    ypos = line*size;
    
    maze = m;
    
    this.createWalls();
  }
  
  void createWalls() {
    walls.put(Direction.North, new Wall(Direction.North, xpos, ypos, size, this));
    walls.put(Direction.South, new Wall(Direction.South, xpos, ypos, size, this));
    walls.put(Direction.East, new Wall(Direction.East, xpos, ypos, size, this));
    walls.put(Direction.West, new Wall(Direction.West, xpos, ypos, size, this));
  }
  
  void addNeighbors() {
    
    int line = this.line;
    int col = this.col;
    
    HashMap<Direction, int[]> possibleNeighbors = new HashMap<Direction, int[]>();
    
    int[] north = { line - 1, col};
    int[] south = { line + 1, col };
    int[] west = { line, col - 1 };
    int[] east = { line, col + 1 };
    
    possibleNeighbors.put(Direction.North, north);
    possibleNeighbors.put(Direction.South, south);
    possibleNeighbors.put(Direction.East, east);
    possibleNeighbors.put(Direction.West, west);
    
    if(line == 0) {
      possibleNeighbors.remove(Direction.North);
    }
    if(col == 0) {
      possibleNeighbors.remove(Direction.West);
    }
    if(line == maze.height-1) {
      possibleNeighbors.remove(Direction.South);  
    }
    if(col == maze.width-1) {
      possibleNeighbors.remove(Direction.East);
    }
    
    for (Map.Entry<Direction, int[]> neighbor : possibleNeighbors.entrySet()) {
      Direction dir = neighbor.getKey();
      int[] coordinates = neighbor.getValue();
      
      neighbors.put(dir, maze.board[coordinates[0]][coordinates[1]]); 
    }
  }
  
  void destroyWall(Direction dir){
    walls.get(dir).erase();
    walls.remove(dir);
  }
}
