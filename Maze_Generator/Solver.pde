/* Solver class //<>//
 
 maze: the maze instance this solver has to solve...
 
 start: starting cell for the solving path
 finish: finishing cell for the solving path
 currentCell: current cell in the solving path
 nextCell: cell that is next in the solving path
 
 path: stack to track the cells the solver has visited
 
 heading: direction where the solver is headed to
 rightHand: direction where the solver's right hand is pointing to
 
 solve(): solves the maze to find the path between the start and finish cells
 canPass(): if the solver can pass to the next cell by going the direction it is heading
 isHandOnWall(): if the solver has a wall to its right
 **/

class Solver {
  Maze maze;
  Cell start;
  Cell finish;
  Cell currentCell;
  Cell nextCell;
  Stack<Cell> path;
  Direction heading;
  Direction rightHand;

  Solver(Maze m, Cell s, Cell f) {
    maze = m;
    start = s;
    finish = f;

    path = new Stack<Cell>();
    heading = Direction.South;
    rightHand = Direction.getRight(heading);

    currentCell = null;
    nextCell = null;
  }

  void solve() {

    do {
      currentCell = (currentCell == null) ? start : nextCell;

      int index = path.search(currentCell);

      console.printSolverCurrentCell(currentCell, index);

      if (index == -1) {
        path.push(currentCell);
      } else {
        path.pop();
      }

      console.printSolverPath(heading, rightHand, canPass(), isHandOnWall());

      do {        

        if (canPass() && isHandOnWall()) {
          continue;
        } else if (!canPass() && isHandOnWall()) {
          rightHand = heading;
          heading = Direction.getLeft(heading);
        } else {
          heading = rightHand;
          rightHand = Direction.getRight(rightHand);
        }
        console.printSolverPath(heading, rightHand, canPass(), isHandOnWall());
      } while (!canPass());

      nextCell = currentCell.neighbors.get(heading);
      console.printNextCell(nextCell);
    } while (nextCell != finish);   

    console.printRouted();

    maze.solved = true;
  }

  boolean canPass() {
    return !currentCell.walls.containsKey(heading);
  }

  boolean isHandOnWall() {
    return currentCell.walls.containsKey(Direction.getRight(heading));
  }
}
