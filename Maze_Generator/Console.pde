/* Console class
 
 printSeparator(): prints the default 
 printTitleSeparator(): prints a special separator
 printCurrentCell(): prints the coordinates of the current cell
 printNextCell(): prints the coordinates of the next cell
 printGoingFoward(): prints the maze generator going foward text
 printGoingBack(): prints the maze generator going back text
 printSolverCurrentCell(): prints the solver current cell coordinates and path index
 printSolverPath(): prints solver info about its current state on the path
 printGenerated(): prints a message to show the end of maze generation
 printRouted(): prints a message to show the end of solver path finding
 printFinish(): prints a message to show that the program has ended
 
 **/

class Console {

  void printSeparator() {
    println("-----==========-----");
  }

  void printTitleSeparator() {
    println("====================");
  }

  void printCurrentCell(Cell cell) {
    println("Current Cell: [ " + cell.line + " , " + cell.column + " ]");
  }

  void printNextCell(Cell cell) {
    println("Next Cell: [ " + cell.line + " , " + cell.column + " ]");
  }

  void printGoingFoward(Cell cell, Direction direction) {
    printNextCell(cell);
    println("Destroy Wall: " + direction);
  }

  void printGoingBack(Cell cell) {
    println("No unvisited neighbor. Going back to [ " + cell.line + " , " + cell.column + " ]");
  }

  void printSolverCurrentCell(Cell cell, int index) {
    printSeparator();
    printCurrentCell(cell);
    println("Index: " + index);
  }

  void printSolverPath(Direction heading, Direction rightHand, boolean canPass, boolean handOnWall) {
    println("Heading: " + heading);
    println("Right Hand: " + rightHand);
    println("Can pass? " + canPass);
    println("Is Hand on Wall? " + handOnWall);
  }

  void printGenerated() {
    printTitleSeparator();
    println("MAZE GENERATED!");
    printTitleSeparator();
    println("");
    println("");
  }

  void printRouted() {
    printTitleSeparator();
    println("FOUND PATH!");
    printTitleSeparator();
    println("");
    println("");
    printTitleSeparator();
    println("DRAWING ROUTE...");
    printTitleSeparator();
  }

  void printFinish() {
    println("");
    println("");
    printTitleSeparator();
    println("FINISHED!");
    printTitleSeparator();
  }
}
