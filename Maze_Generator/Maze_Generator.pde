import java.util.Map;
import java.util.Stack;

/* Constants **/

int CELL_SIZE = 50;

color ENTRY_COLOR = color(250, 185, 50);
color EXIT_COLOR = color(185, 50, 250);
color TRACE_COLOR = color(50, 250, 185);
color BACKGROUND_COLOR = color(150);

int ENTRY_OFFSET = 3;
float TRACE_PERCENTAGE = 0.2;

int DELAY = 10;

/* Variables and Objects declaration **/

Maze maze;
Solver solver;

boolean finished = false;
boolean generated = false;
boolean routed = false;

void setup() {
  size(1000, 500);
  background(BACKGROUND_COLOR);

  int mazeWidth = floor(width/CELL_SIZE) > 1 ? floor(width/CELL_SIZE) : 2;
  int mazeHeight = floor(height/CELL_SIZE) > 1? floor(height/CELL_SIZE) : 2;

  maze = new Maze(mazeWidth, mazeHeight, CELL_SIZE);
  solver = new Solver(maze, maze.board[0][0], maze.board[maze.height-1][maze.width-1]);
}

void draw() {
  if (!finished) {
    if (!routed) {
      if (!generated) {      
        maze.generate();
      } else {
        delay(1000);
        solver.solve();
      }
    } else {
      solver.drawEntry();
      solver.drawTrace();
      if (solver.path.empty()) {
        solver.drawExit();
        println("");
        println("");

        println("====================");
        println("FINISHED!");
        println("====================");
        finished = true;
      }
    }
  }
}
