

float x;
float y;
float easing = 0.05;

void setup() {
  size(700, 900);
  noStroke();
  background(0);
}

void draw() {
  // semi-transparent black layer each frame = soft fading trails
  fill(0, 20);
  rect(0, 0, width, height);
  
  // smoothly follow the mouse (classic easing)
  float dx = mouseX - x;
  x += dx * easing;
  float dy = mouseY - y;
  y += dy * easing;
  
  // breathing size: oscillates between ~20 and ~120 over time
  float size = sin(frameCount * 0.03) * 50 + 70;
  
  // color shifts based on where your mouse is on screen
  fill(mouseX / 2, mouseY / 2, 200, 150);
  
  ellipse(x, y, size, size);
}
