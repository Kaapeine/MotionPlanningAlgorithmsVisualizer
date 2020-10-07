import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class path_finder_gen extends PApplet {

float w, h;
int ncols = 30;
int nrows = 30;
Spot[][] grid = new Spot[nrows][ncols];
ArrayList<Spot> OpenSet = new ArrayList<Spot>();
ArrayList<Spot> ClosedSet = new ArrayList<Spot>();
Spot start, end, current;

public void setup() {
  
  frameRate(5);
  w = 600/ncols;
  h = 600/nrows;
  int c = 0xfff1f1f1;
  for (int i = 0; i < ncols; i++) {
    for (int j = 0; j < nrows; j++) {
      grid[i][j] = new Spot(i, j, c);
      grid[i][j].show();
    }
  }
  
  Spot start = new Spot(0, 0, 0xff0000ff);
  Spot end = new Spot(ncols-1, nrows-1, 0xff00ff00);
  current = new Spot(8, 9, 0xff0000ff);
  start.show();
  end.show();
  current.show();
  print("Initial Values: ", current.i, current.j, current.i+w, current.j+w, "\n");
  print("Count: ", current.count);
  
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


public void draw() {
  if (OpenSet.size() > 0) {
    // Main body of the algorithm
    
    int current = getwinner(OpenSet); // Find element in OpenSet with lowest fscore
    if (OpenSet.get(current) == end) {
      print("Destination arrived");
      noLoop();
    }
    
    OpenSet.remove(current); // Remove the current element as it will be checked in this interation
    
    for (int i = 0; i < OpenSet.size(); i++) {
      Spot neighbour = OpenSet.index(i);
      float tentative_gscore = current.gscore + dist(current, neighbour);
      if (tentative_gscore < neighbour.gscore) {
        neighbour.camefrom_i = current_i;
        neighbour.camefrom_j = current_j;
        neighbour.gscore = tentative_gscore;
        neighbour.fscore = tentative_gscore + dist(neighbour, end);
      }
    }
    
    
    
  }
   
  else {
    print("Path not found");
  }
  
}

class Spot {
  float i; // The co-ordinates of its top-left point
  float j;
  int c;
  float gscore = 0;
  float hscore = 0;
  float fscore = gscore + hscore;
  int count = 0;

  float camefrom_i = 0;
  float camefrom_j = 0;

  Spot(float _i, float _j, int _c) {
    i = _i;
    j = _j;
    c = _c;
  }
  
  public void show() {
    fill(c);
    rect(i*w, j*h, w, h);
    count++;
  }  
}

public float dist(Spot a, Spot b) {
  float d = abs(a.i - b.i) + abs(a.j - b.j); // Taxicab distance
  // float d = sqrt(pow(a.i - b.i, 2) + pow(a.j - b.j, 2)); // Euclidean distance
  return d;
}

public int getwinner(ArrayList<Spot> array) {
  Spot winner = array.get(0);
  int index = 0;
  
  for (int i = 0; i < array.size(); i++) {
    if (array.get(i).fscore > winner.fscore) { 
      winner = array.get(i);
      index = i;
    }
  }
  
  return index;
}

public ArrayList<Spot> getneighbours(Spot curr) {
  ArrayList<Spot> neighbours = new ArrayList<Spot>();
  int i = PApplet.parseInt(curr.i);
  int j = PApplet.parseInt(curr.j);
  
  if (curr.i == 0 && curr.j < ncols-1) { // First row upto last column
    if (curr.j != 0) {
      neighbours.add(grid[i][j-1]); // One left
    }
    neighbours.add(grid[i][j+1]); // One right
    neighbours.add(grid[i+1][j]); // One below
  }
  
  else if (curr.i == nrows-1 && curr.j < ncols-1) { // Last row upto last column
    if (curr.j != 0) {
      neighbours.add(grid[i][j-1]); // One left
    }
    neighbours.add(grid[i][j+1]); // One right
    neighbours.add(grid[i-1][j]); // One above
  }
  
  else if (curr.i < nrows-1 && curr.j == 0) { // First column row upto last row
    if (curr.i != 0) {
      neighbours.add(grid[i-1][j]); // One above
    }
    neighbours.add(grid[i][j+1]); // One right
    neighbours.add(grid[i+1][j]); // One below
  }
  
  else if (curr.i <= nrows-1 && curr.j == ncols-1) { // Last column upto last row
    if (curr.i != 0) {
      neighbours.add(grid[i-1][j]); // One above
    }
    if (curr.i != nrows-1) neighbours.add(grid[i+1][j]); // One below 
    neighbours.add(grid[i][j-1]); // One left
  }
  
  else {
    neighbours.add(grid[i][j+1]); // One right
    neighbours.add(grid[i][j-1]); // One left
    neighbours.add(grid[i+1][j]); // One above
    neighbours.add(grid[i-1][j]); // One below
  }
  
  return neighbours;
}
  public void settings() {  size(600,600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "path_finder_gen" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
