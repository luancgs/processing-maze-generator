/* Solver class //<>//
 
 maze: the maze this solver has to solve...
 
 start: the starting cell for the solving path
 finish: the finishing cell for the solving path
 currentCell: the current cell in the solving path
 nextCell: the cell that is next in the solving path
 
 path: stack to track the cells the solver has visited
 
 heading: direction where the solver is headed to
 rightHand: direction where the solver's right hand is pointing to
 
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
    println("");
    println("");

    do {
      currentCell = (currentCell == null) ? start : nextCell;

      int index = path.search(currentCell);

      println("-----==========-----");
      println("Current Cell: [ " + currentCell.line + " , " + currentCell.col + " ]");
      println("Index: " + index);

      if (index == -1) {
        path.push(currentCell);
      } else {
        path.pop();
      }

      println("Heading: " + heading);
      println("Right Hand: " + rightHand);
      println("Can pass? " + canPass());
      println("Is Hand on Wall? " + isHandOnWall());

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
        println("Heading: " + heading);
        println("Right Hand: " + rightHand);
        println("Can pass? " + canPass());
        println("Is Hand on Wall? " + isHandOnWall());
      } while (!canPass());

      nextCell = currentCell.neighbors.get(heading);

      println("Next Cell: [ " + nextCell.line + " , " + nextCell.col + " ]");
    } while (nextCell != finish);   

    println("====================");
    println("FOUND PATH!");
    println("====================");

    println("");
    println("");

    println("====================");
    println("DRAWING ROUTE...");
    println("====================");

    routed = true;
  }

  boolean canPass() {
    return !currentCell.walls.containsKey(heading);
  }

  boolean isHandOnWall() {
    return currentCell.walls.containsKey(Direction.getRight(heading));
  }

  void drawEntry() {
    Cell entry = finish;

    stroke(ENTRY_COLOR);
    fill(ENTRY_COLOR);
    square((entry.col*entry.size) + ENTRY_OFFSET, (entry.line*entry.size) + ENTRY_OFFSET, entry.size - (ENTRY_OFFSET*2));
  }

  void drawExit() {
    Cell exit = start;

    stroke(EXIT_COLOR);
    fill(EXIT_COLOR);
    square((exit.col*exit.size) + ENTRY_OFFSET, (exit.line*exit.size) + ENTRY_OFFSET, exit.size - (ENTRY_OFFSET*2));
  }

  void drawTrace() {
    Cell traceCell = path.pop();

    stroke(TRACE_COLOR);
    fill(TRACE_COLOR);
    square(traceCell.col*traceCell.size + ((traceCell.size/2) - int(traceCell.size*(TRACE_PERCENTAGE/2))), traceCell.line*traceCell.size + ((traceCell.size/2) - int(traceCell.size*(TRACE_PERCENTAGE/2))), traceCell.size - (traceCell.size - int(traceCell.size*TRACE_PERCENTAGE)));
  }
}
