
 
float x;
float y;
float easing = 0.05;

void setup() {
  size(640, 360); 
  noStroke();  
}

void draw() { 
  background(51);
  
  float targetX = mouseX;
  float dx = targetX - x;
  x -= dx * easing;
  x = constrain(x, 0, width);
  
  float targetY = mouseY;
  float dy = targetY - y;
  y -= dy * easing;
  y = constrain(y, 0, height);
  fill(sin(frameCount * 0.02) * 127 + 127, 100, 200);
  
  ellipse(x, y, 66, 66);
}
