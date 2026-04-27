// global variables I define:

int cx, cy; //center x , center y 
int step;   // speed, how many pixels the point moves each frame
int leftX, rightX;
int topY, bottomY;
int strokeAlpha;

void setup() {
  size(700, 700);
  frameRate(30);
  smooth(8);
  cx = width / 2;
  cy = height / 2;
  restart();         //restart is defined at the bottom, restart here to set the points before we draw
} 

void draw() {          // this is the steps it follows to build each star, and then restarts
  drawArms();
  advance();
  if (topY >= cy) {
    restart();
  }
}

void drawArms() {                           // this is where I define the draw amrs step
  stroke(255, 255, 50, strokeAlpha);
  strokeWeight(1);
  line(leftX, cy, cx, topY);
  line(rightX, cy, cx, topY);
  line(leftX, cy, cx, bottomY);
  line(rightX, cy, cx, bottomY);
}

void advance() {              // this is where I define the advance step
  leftX  -= step;
  rightX += step;
  topY   += step;
  bottomY -= step;
}

void restart() {
  background(0);        // ← clears everything completely first
  strokeAlpha = int(random(60, 140));
  noStroke();
  for (int y = 0; y < height; y++) {      //making an ombre background
    float r = map(y, 0, height, 180, 80);
    float b = map(y, 0, height, 255, 150);
    fill(r, 0, b);
    rect(0, y, width, 1);      // filled rectangle, 1px tall, full width
  }
  step = int(random(1, 10));
  leftX   = cx;
  rightX  = cx;
  topY    = 0;
  bottomY = height;
}
