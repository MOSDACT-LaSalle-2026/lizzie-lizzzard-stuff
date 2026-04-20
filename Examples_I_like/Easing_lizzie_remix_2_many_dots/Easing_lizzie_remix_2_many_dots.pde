ArrayList<Follower> followers;
float x, y;
float easing = 0.05;

void setup() {
  size(700, 900);
  noStroke();
  background(0);
  followers = new ArrayList<Follower>();
}

void draw() {
  // soft trails
  fill(0, 20);
  rect(0, 0, width, height);
  
  // main ball follows the mouse smoothly
  float dx = mouseX - x;
  x += dx * easing;
  float dy = mouseY - y;
  y += dy * easing;
  
  // breathing size
  float size = sin(frameCount * 0.02) * 20 + 20;
  
  // main ball color shifts with mouse position
  fill(mouseX / 2, mouseY / 2, 200, 150);
  ellipse(x, y, size, size);
  
  // update and draw every follower
  for (Follower f : followers) {
    f.update();
    f.display();
  }
}

// when I CLICK, spawn 6 baby circles at the mouse position
void mousePressed() {
  for (int i = 0; i < 6; i++) {
    followers.add(new Follower(mouseX, mouseY));
  }
}


// Follower class
// a little circle that has its own position, color, size, and easing speed

 class Follower {
  float x, y;       // position
  float easing;     // its own follow speed
  float r, g, b;    // its own color
  float size;       // its own size
  
  // constructor: this runs when a new Follower is born
  Follower(float startX, float startY) {
    x = startX;
    y = startY;
    easing = random(0.01, 0.15);   // random follow speed
    r = random(100, 255);
    g = random(100, 255);
    b = random(100, 255);
    size = random(3, 27);
  }
  
  // move toward the mouse at my own easing speed
  void update() {
    float dx = mouseX - x;
    x += dx * easing;
    float dy = mouseY - y;
    y += dy * easing;
  }
  
  // draw me
  void display() {
    fill(r, g, b, 180);
    ellipse(x, y, size, size);
  }
}
