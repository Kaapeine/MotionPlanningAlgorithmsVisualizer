float w, h;
int ncols = 30;
int nrows = 30;
Spot[][] grid = new Spot[nrows][ncols];
ArrayList<Spot> OpenSet = new ArrayList<Spot>();
ArrayList<Spot> ClosedSet = new ArrayList<Spot>();
Spot current;
Spot start = new Spot(0, 0);
Spot end = new Spot(29, 29);
int cost = 0;
int obstacle_percentage = 10;

void setup() {
  size(600, 600);
  frameRate(10);
  w = 600/ncols;
  h = 600/nrows;
  color c = #f1f1f1;
  for (int i = 0; i < ncols; i++) {
    for (int j = 0; j < nrows; j++) {
      grid[i][j] = new Spot(i, j);
      grid[i][j].show(c);
    }
  }
  
  // Implement obstacle rules
  for (int i = 0; i < ncols; i++) {
    for (int j = 0; j < nrows; j++) {
      //obstaclerules(grid[i][j]);
    }
  }

  start.obstacle = false;
  end.obstacle = false;
  start.show(#ff0000);
  end.show(#00ff00);

  OpenSet.add(grid[0][0]); // First element in OpenSet is the start position
  grid[0][0].gscore = dist(grid[0][0], end);

  // ------Neighbours function debug-----
  // ArrayList<Spot> neigh = new ArrayList<Spot>();
  // neigh = getneighbours(grid[5][5]);
  // color col = #ffff00;
  // for (int i = 0; i < neigh.size(); i++) {
  //   Spot s = neigh.get(i);
  //   s.c = col;
  //   s.show();
  // }
}


void draw() {
  if (mousePressed == true) {
    if (OpenSet.size() > 0) {
      // Main body of the algorithm
  
      int win_index = getwinner(OpenSet); // Find element in OpenSet with lowest fscore
      Spot current = OpenSet.get(win_index);
      //print(current.i, current.j);
      current.show(#0000ff);
  
      if (current.i == end.i && current.j == end.j) {
        print("\nDestination arrived");
        end.camefrom_i = current.camefrom_i;
        end.camefrom_j = current.camefrom_j;
        recreatepath(current);
        noLoop();
      }
      
      else {
        OpenSet.remove(win_index); // Remove the current element as it will be checked in this interation
        ClosedSet.add(current);
    
        for (int i = 0; i < ClosedSet.size(); i++) {
          Spot s = ClosedSet.get(i);
          s.show(150);
        }
    
        ArrayList<Spot> neighbours = new ArrayList<Spot>();
        neighbours = getneighbours(current);
    
        for (int i = 0; i < neighbours.size(); i++) {
          Spot neighbour = neighbours.get(i);
          neighbour.show(#ffff00);
    
          float tentative_gscore = current.gscore + dist(current, neighbour);
          if (tentative_gscore < neighbour.gscore && neighbour.obstacle == false) {
            neighbour.camefrom_i = current.i;
            neighbour.camefrom_j = current.j;
            neighbour.gscore = tentative_gscore;
            neighbour.fscore = tentative_gscore + dist(neighbour, end);
            if (isinarraylist(OpenSet, neighbour) == false) {
              OpenSet.add(neighbour);
            }          
          }
          current.show(#0000ff);
        }
      }
    } 
    else {
      print("\nPath not found");
      noLoop();
    }
    start.show(#ff0000);
    end.show(#00ff00);
  }
}
