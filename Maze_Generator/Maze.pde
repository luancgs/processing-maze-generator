/* Maze class
 
 width: number of columns in the maze matrix
 height: number of lines in the maze matrix
 cellSize: how many pixels has a cell side
 board: maze matrix with all the cells
 path: stack to track the cells the generator has visited
 
 **/

class Maze {
  int width;
  int height;
  int cellSize;
  Cell[][] board;
  Stack<Cell> path;

  Cell currentCell;
  Cell nextCell;

  Maze(int w, int h, int cSize) {
    this.width = w;
    this.height = h;
    cellSize = cSize;

    board = new Cell[this.height][this.width];
    path = new Stack();

    currentCell = null;
    nextCell = null;

    createCells();
  }

  void createCells() {
    for (int i = 0; i < this.height; i++) {
      for (int j = 0; j < this.width; j++) {
        board[i][j] = new Cell(i, j, cellSize, this);
      }
    }

    createNeighbors();
  }

  void createNeighbors() {
    for (int i = 0; i < this.height; i++) {
      for (int j = 0; j < this.width; j++) {
        board[i][j].addNeighbors();
      }
    }
  }

  Cell getFirstCell() {
    int cellLine = int(random(this.height));
    int cellCol = int(random(this.width));

    return board[cellLine][cellCol];
  }

  void generate() {
    boolean hasUnvisitedNeighbor = checkUnvisitedNeighbor();

    if (hasUnvisitedNeighbor) {
      getNextCell();
      path.push(currentCell);
      delay(DELAY);
    }
  }

  boolean checkUnvisitedNeighbor() {
    println("-----==========-----");
    boolean noUnvisitedNeighbor = true;

    do {
      currentCell = (nextCell == null) ? maze.getFirstCell() : nextCell;
      currentCell.visited = true;

      println("Current Cell: [ " + currentCell.line + " , " + currentCell.col + " ]");

      for (Map.Entry<Direction, Cell> entry : currentCell.neighbors.entrySet()) {
        Cell neighbor = entry.getValue();

        if (neighbor.visited == false) {
          noUnvisitedNeighbor = false;
        }
      }

      if (noUnvisitedNeighbor) {
        if (path.empty()) {
          generated = true;
          println("====================");
          println("MAZE GENERATED!");
          println("====================");
          break;
        }
        nextCell = maze.path.pop();
        println("No unvisited neighbor. Going back to [ " + nextCell.line + " , " + nextCell.col + " ]");
        break;
      }
    } while (noUnvisitedNeighbor);

    return !noUnvisitedNeighbor;
  }

  void getNextCell() {
    Direction direction;
    boolean foundDirection = false;

    do {
      direction = Direction.values()[int(random(Direction.values().length))];

      for (Map.Entry<Direction, Cell> entry : currentCell.neighbors.entrySet()) {
        Direction dir = entry.getKey();
        Cell neighbor = entry.getValue();

        if (dir == direction) {
          if (!neighbor.visited) {
            nextCell = neighbor;
            foundDirection = true;

            currentCell.destroyWall(direction);
            nextCell.destroyWall(Direction.opposite(direction));

            println("Next Cell: [ " + nextCell.line + " , " + nextCell.col + " ]");
            println("Destroy Wall: " + direction);
            break;
          }
        }
      }
    } while (!foundDirection);
  }
}
