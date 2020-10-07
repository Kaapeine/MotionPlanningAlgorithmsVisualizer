int wew = 0;
void obstaclerules(Spot spot) {
  ArrayList<Spot> neighbours = new ArrayList<Spot>();
  neighbours = getneighbours(spot);
  int cnt = 0;
  for (int i = 0; i < neighbours.size(); i++) {
    if (neighbours.get(i).obstacle == true) cnt++;
  }
  if (cnt >= 3) {
    spot.obstacle = true;
    wew++;
    print("\nWew :", wew);
  }
}


float dist(Spot a, Spot b) {
  //float d = abs(a.i - b.i) + abs(a.j - b.j); // Taxicab distance
  float d = sqrt(pow(a.i - b.i, 2) + pow(a.j - b.j, 2)); // Euclidean distance
  return d;
}

int getwinner(ArrayList<Spot> array) {
  Spot winner = array.get(0);
  int index = 0;

  for (int i = 0; i < array.size(); i++) {
    if (array.get(i).fscore < winner.fscore) { // Reverse inequality to get the worst path :D
      winner = array.get(i);
      index = i;
    }
  }

  return index;
}

boolean isinarraylist(ArrayList<Spot> array, Spot treasure) {
  for (int i = 0; i < array.size(); i++) {
    if (array.get(i) == treasure) return true;
  }
  return false;
}

void recreatepath(Spot spot) {
  color col = #F262E9;
  spot.show(col);
  
  if (spot.i == start.i && spot.j == start.j) {
    print("\nCost: ", cost);
    print("\nStopping");
    return;
  } 
  else {
    int i = int(spot.camefrom_i);
    int j = int(spot.camefrom_j);
    Spot previous = grid[i][j];
    cost += dist(spot, previous);
    recreatepath(previous);
  }
}

ArrayList<Spot> getneighbours(Spot curr) {
  ArrayList<Spot> neighbours = new ArrayList<Spot>();
  int i = int(curr.i);
  int j = int(curr.j);
  // i = 0 means first column

  if (curr.i == 0 && curr.j < ncols-1) { // First column upto last row
    if (curr.j != 0) {
      neighbours.add(grid[i][j-1]); // One above
      neighbours.add(grid[i+1][j+1]); // Top right
    }
    neighbours.add(grid[i][j+1]); // One below
    neighbours.add(grid[i+1][j]); // One right
    neighbours.add(grid[i+1][j+1]); // Bottom right
  } 
  else if (curr.i == nrows-1 && curr.j < ncols-1) { // Last column upto last row
    if (curr.j != 0) {
      neighbours.add(grid[i][j-1]); // One above
      neighbours.add(grid[i-1][j-1]); // Top left
    }
    neighbours.add(grid[i][j+1]); // One below
    neighbours.add(grid[i-1][j]); // One left
    neighbours.add(grid[i-1][j+1]); // Top right
  } 
  else if (curr.i < nrows-1 && curr.j == 0) { // First row upto last column
    if (curr.i != 0) {
      neighbours.add(grid[i-1][j]); // One left
      neighbours.add(grid[i-1][j+1]); // Bottom left
    }
    neighbours.add(grid[i][j+1]); // One below
    neighbours.add(grid[i+1][j]); // One right
    neighbours.add(grid[i+1][j+1]); // Bottom right
  } 
  else if (curr.i <= nrows-1 && curr.j == ncols-1) { // Last row upto last column
    if (curr.i != 0) {
      neighbours.add(grid[i-1][j]); // One left
      neighbours.add(grid[i-1][j-1]); // Top left
    }
    if (curr.i != nrows-1) {
      neighbours.add(grid[i+1][j]); // One right
      neighbours.add(grid[i+1][j-1]); // Top right
    }
    neighbours.add(grid[i][j-1]); // One above
  } 
  else {
    neighbours.add(grid[i][j+1]); // One below
    neighbours.add(grid[i][j-1]); // One above
    neighbours.add(grid[i+1][j]); // One right
    neighbours.add(grid[i-1][j]); // One left
    neighbours.add(grid[i+1][j+1]); //  Bottom right
    neighbours.add(grid[i+1][j-1]); // Top right
    neighbours.add(grid[i-1][j+1]); // Top left
    neighbours.add(grid[i-1][j-1]); // Bottom left
  }

  return neighbours;
}
