/* Wall class
 
 cell: the cell instance this wall belongs to
 direction: the direction this wall is positioned within the cell
 
 **/

class Wall {
  Cell cell;
  Direction direction;

  Wall(Direction dir, Cell c) {
    direction = dir;
    cell = c;
  }
}
