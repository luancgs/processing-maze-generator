import java.util.Map;
import java.util.Stack;

/* Constants **/

int CELL_SIZE = 50;
int DELAY = 10;

/* Variables and Objects declaration **/

Maze maze;
Solver solver;
Display display;
Console console;

Cell startCell;
Cell finishCell;

boolean end = false;

void setup() {
  size(1000, 500);

  int mazeWidth = floor(width/CELL_SIZE) > 1 ? floor(width/CELL_SIZE) : 2;
  int mazeHeight = floor(height/CELL_SIZE) > 1? floor(height/CELL_SIZE) : 2;

  maze = new Maze(mazeWidth, mazeHeight);

  startCell = maze.cells[0][0];
  finishCell = maze.cells[maze.height-1][maze.width-1];

  solver = new Solver(maze, startCell, finishCell);
  console = new Console();
  display = new Display(maze, CELL_SIZE);
}

void draw() {
  if (!end) {
    display.drawMaze();
    if (!maze.solved) {
      if (!maze.generated) {      
        maze.generate();
      } else {
        delay(1000);
        solver.solve();
      }
    } else {
      display.drawSolutionEntry(maze.cells[maze.height-1][maze.width-1]);
      display.drawSolutionExit(maze.cells[0][0]);
      display.drawSolutionTrace(solver.path);
      if (solver.path.empty()) {
        display.drawSolutionExit(maze.cells[0][0]);
        console.printFinish();
        finished = true;
      }
    }
  }
}
