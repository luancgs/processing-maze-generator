/* Maze class
 
 width: number of columns in the maze matrix
 height: number of lines in the maze matrix
 cells: maze matrix with all the cells
 path: stack to track which cells the generator has visited
 
 currentCell: which cell the generator is currently in
 nextCell: which cell the generator is going in the next iteration
 
 generated: if the maze has been totally generated
 solved: if the maze has been solved
 
 createCells(): populates the cells matrix
 createNeighbors(): adds the neighbors to all cells
 getFirstCell(): randomly selects a cell to start the maze generation
 generate(): starts the maze generation
 checkUnvisitedNeighbor(): checks if the current cell has any unvisited neighbor
 getNextCell(): selects the next cell to go from the current cell's neighbors
 
 **/

class Maze {
  int width;
  int height;
  Cell[][] cells;
  Stack<Cell> path;

  private Cell currentCell;
  private Cell nextCell;

  boolean generated = false;
  boolean solved = false;

  Maze(int w, int h) {
    this.width = w;
    this.height = h;

    cells = new Cell[this.height][this.width];
    path = new Stack();

    currentCell = null;
    nextCell = null;

    createCells();
  }

  private void createCells() {
    for (int i = 0; i < this.height; i++) {
      for (int j = 0; j < this.width; j++) {
        cells[i][j] = new Cell(i, j, this);
      }
    }

    createNeighbors();
  }

  private void createNeighbors() {
    for (int i = 0; i < this.height; i++) {
      for (int j = 0; j < this.width; j++) {
        cells[i][j].addNeighbors();
      }
    }
  }

  private Cell getFirstCell() {
    int cellLine = int(random(this.height));
    int cellCol = int(random(this.width));

    return cells[cellLine][cellCol];
  }

  void generate() {
    boolean hasUnvisitedNeighbor = checkUnvisitedNeighbor();

    if (hasUnvisitedNeighbor) {
      getNextCell();
      path.push(currentCell);
      delay(DELAY);
    }
  }

  private boolean checkUnvisitedNeighbor() {
    console.printSeparator();
    boolean noUnvisitedNeighbor = true;

    do {
      currentCell = (currentCell == null) ? maze.getFirstCell() : nextCell;
      currentCell.visited = true;
      console.printCurrentCell(currentCell);

      for (Map.Entry<Direction, Cell> entry : currentCell.neighbors.entrySet()) {
        Cell neighbor = entry.getValue();

        if (neighbor.visited == false) {
          noUnvisitedNeighbor = false;
          break;
        }
      }

      if (noUnvisitedNeighbor) {
        if (path.empty()) {
          generated = true;
          console.printGenerated();
          break;
        }
        nextCell = maze.path.pop();
        console.printGoingBack(nextCell);
        break;
      }
    } while (noUnvisitedNeighbor);

    return !noUnvisitedNeighbor;
  }

  private void getNextCell() {
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

            console.printGoingFoward(nextCell, direction);
            break;
          }
        }
      }
    } while (!foundDirection);
  }
}
