class Spot {
  float i; // The co-ordinates of its top-left point
  float j;
  
  float gscore = 99999;
  float hscore = 0;
  float fscore = 99999;

  float camefrom_i = 0;
  float camefrom_j = 0;
  
  boolean obstacle = false;

  Spot(float _i, float _j) {
    i = _i;
    j = _j;
    
    if (random(100) < obstacle_percentage) obstacle = true; 
  }

  void show(color c) {
    fill(c);
    if (obstacle == true) {
      fill(50);
    }
    rect(i*w, j*h, w, h);
  }

  void hide() {
    fill(#ffffff);
    rect(i*w, j*h, w, h);
  }
}
