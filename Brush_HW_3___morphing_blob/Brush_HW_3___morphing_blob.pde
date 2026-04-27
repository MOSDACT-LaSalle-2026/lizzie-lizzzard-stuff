// Brush HW 3 - morphing blob
// remix of P_2_2_3_01 (Generative Gestaltung)
// click       : drop a new blob at mouse
// r           : reset black
// e           : reset white
// q / w       : pause / resume
// space       : save screenshot

color col1 = #ff9de2;   // pink
color col2 = #c9b8ff;   // lavender
color col3 = #8ff0ff;   // light blue

// --- blob settings ---
int   formResolution = 45;     // how many points make up the blob
float stepSize       = 1;      // how much each point wanders per frame
float initRadius     = 120;    // starting circle radius

float[] x = new float[formResolution];
float[] y = new float[formResolution];

float centerX, centerY;
float breathPhase = 0;

int screenshotCount = 1;


void setup() {
  size(700, 700);
  background(0);
  frameRate(60);

  centerX = width / 2;
  centerY = height / 2;
  initBlob(centerX, centerY);
}


void draw() {

  // soft fading trails -- same trick as easing remix
  fill(0, 0.2);
  noStroke();
  rect(0, 0, width, height);

  // easing: center slowly follows mouse
  centerX += (mouseX - centerX) * 0.01;
  centerY += (mouseY - centerY) * 0.01;

  // each point wanders randomly
  for (int i = 0; i < formResolution; i++) {
    x[i] += random(-stepSize, stepSize);
    y[i] += random(-stepSize, stepSize);
  }

  // breathing scale -- sin() from Brush HW 2
  breathPhase += 0.018;
  float breathScale = 1 + sin(breathPhase) * 0.5;

  // lerpColor palette cycling -- same as Brush HW 2
  float t  = (sin(frameCount * 0.015) + 1) / 2.0;
  float t2 = (sin(frameCount * 0.015 + 2.0) + 1) / 2.0;
  color ca = lerpColor(col1, col2, t);
  color cb = lerpColor(col2, col3, t2);
  color c  = lerpColor(ca, cb, t);

  stroke(c);
  strokeWeight(0.75);
  noFill();

  // beginShape() + curveVertex() draws a smooth closed curve
  // through all the moving points -- first and last vertices are control points
  beginShape();
  curveVertex(x[formResolution-1] * breathScale + centerX,  y[formResolution-1] * breathScale + centerY);
  for (int i = 0; i < formResolution; i++) {
    curveVertex(x[i] * breathScale + centerX,  y[i] * breathScale + centerY);
  }
  curveVertex(x[0] * breathScale + centerX,  y[0] * breathScale + centerY);
  curveVertex(x[1] * breathScale + centerX,  y[1] * breathScale + centerY);
  endShape();
}


void mousePressed() {
  initBlob(mouseX, mouseY);
}


// puts the points back in a circle around a given center
void initBlob(float cx, float cy) {
  centerX = cx;
  centerY = cy;
  float angle = radians(360.0 / formResolution);
  for (int i = 0; i < formResolution; i++) {
    x[i] = cos(angle * i) * initRadius;
    y[i] = sin(angle * i) * initRadius;
  }
}


void keyPressed() {
  if (key == 'r') { background(0); }
  if (key == 'e') { background(255); }
  if (key == 'q') { noLoop(); }
  if (key == 'w') { loop(); }
  if (key == ' ') {
    save("screenshotB" + screenshotCount + ".jpeg");
    screenshotCount = screenshotCount + 1;
  }
}
