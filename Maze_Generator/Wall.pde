/* Maze class
  
  xstart: x coordinate where the wall starts
  ystart: y coordinate where the wall starts
  xend: x coordinate where the wall ends
  yend: y coordinate where the wall ends
  size: how long is the wall (in pixels)
  
  cell: the cell this wall belongs to
  
  direction: the direction this wall is positioned within the cell
  
**/

class Wall {
  int xstart, ystart, xend, yend, size;
  Cell cell;
  Direction direction;
  
  Wall(Direction dir, int xpos, int ypos, int s, Cell c){
    direction = dir;
    size = s;
    cell = c;
    
    if(direction == Direction.North){
      xstart = xpos;
      ystart = ypos;
      xend = xpos+size;
      yend = ypos;
    } else if(direction == Direction.South) {
      xstart = xpos+size;
      ystart = ypos+size;
      xend = xpos;
      yend = ypos+size;
    } else if (direction == Direction.East){
      xstart = xpos+size;
      ystart = ypos;
      xend = xpos+size;
      yend = ypos+size;
    } else if (direction == Direction.West) {
      xstart = xpos;
      ystart = ypos+size;
      xend = xpos;
      yend = ypos;
    }

    line(xstart, ystart, xend, yend);
  }
  
  void erase() {
    stroke(BACKGROUND_COLOR);
    line(xstart, ystart, xend, yend);
  }
}
