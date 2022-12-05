/* Display class
 
 maze: the maze instance to display
 cellSize: the size of each cell to be displayed
 lineColor: cell walls color
 entryColor: entry cell color
 exitColor: exit cell color
 traceColor: solution trace color
 backgrounColor: maze background color
 
 entryOffset: how many pixels to offset the entry and exit cells coloring
 tracePercentage: which percentage of the cell area should the trace cover
 
 drawMaze(): draws the current state of the maze on the screen
 drawSolutionEntry(): draws the entry cell of the maze
 drawSolutionExit(): draws the exit cell of the maze
 drawSolutionTrace(): draws the solution trace between the entry and exit
 
 **/

class Display {
  Maze maze;
  int cellSize;
  color lineColor = color(0, 0, 0);
  color entryColor = color(250, 185, 50);
  color exitColor = color(185, 50, 250);
  color traceColor = color(50, 250, 185);
  color backgroundColor = color(150);

  int entryOffset = 3;
  float tracePercentage = 0.2;

  Cell[] solution = {};

  Display(Maze m, int size) {
    maze = m;
    cellSize = size;
  }

  void drawMaze() {

    background(backgroundColor);
    fill(lineColor);

    for (Cell[] line : maze.cells) {
      for (Cell cell : line) {
        for (Map.Entry<Direction, Wall> wall : cell.walls.entrySet()) {
          Direction direction = wall.getKey();
          if (direction == Direction.North) {
            line(cell.column*cellSize, cell.line*cellSize, (cell.column*cellSize) + cellSize, cell.line*cellSize);
          } else if (direction == Direction.East) {
            line((cell.column*cellSize) + cellSize, cell.line*cellSize, (cell.column*cellSize) + cellSize, (cell.line*cellSize) + cellSize);
          } else if (direction == Direction.South) {
            line((cell.column*cellSize) + cellSize, (cell.line*cellSize) + cellSize, cell.column*cellSize, (cell.line*cellSize) + cellSize);
          } else {
            line(cell.column*cellSize, (cell.line*cellSize) + cellSize, cell.column*cellSize, cell.line*cellSize);
          }
        }
      }
    }
  }

  void drawSolutionEntry(Cell entry) {
    fill(entryColor);
    square((entry.column*cellSize) + entryOffset, (entry.line*cellSize) + entryOffset, cellSize - (entryOffset*2));
  }

  void drawSolutionExit(Cell exit) {
    fill(exitColor);
    square((exit.column*cellSize) + entryOffset, (exit.line*cellSize) + entryOffset, cellSize - (entryOffset*2));
  }

  void drawSolutionTrace(Stack<Cell> path) {
    Cell traceCell = path.pop();

    Cell[] newSolution = new Cell[solution.length + 1];

    for (int i = 0; i < solution.length; i++) {
      newSolution[i] = solution[i];
    }

    newSolution[solution.length] = traceCell;

    solution = newSolution;

    fill(traceColor);

    for (Cell cell : solution) {
      square(cell.column*cellSize + ((cellSize/2) - int(cellSize*(tracePercentage/2))), cell.line*cellSize + ((cellSize/2) - int(cellSize*(tracePercentage/2))), cellSize - (cellSize - int(cellSize*tracePercentage)));
    }
  }
}
