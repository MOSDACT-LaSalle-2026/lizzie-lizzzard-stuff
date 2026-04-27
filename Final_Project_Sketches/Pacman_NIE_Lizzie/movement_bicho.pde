class Bicho {
  float x, y;
  float vx, vy;
  float angle;
  float t1;
  float speed;
  float r = 15;
  color cbicho;
  boolean captured = false;

  Bicho() {
    x = random(width);
    y = random(height);
    t1 = random(1000);
    angle = random(TWO_PI);
    speed = random(2.5, 5.0);
    cbicho = color(255, 220, 0);
  }

  void update() {
    if (captured) return;

    angle += map(noise(t1), 0, 1, -0.06, 0.06);
    t1 += 0.01;

    vx = cos(angle) * speed;
    vy = sin(angle) * speed;

    x += vx;
    y += vy;

    // bounce off edges
    if (x > width - r)  { x = width - r;  vx *= -1; angle = atan2(vy, vx); }
    if (x < r)          { x = r;           vx *= -1; angle = atan2(vy, vx); }
    if (y > height - r) { y = height - r;  vy *= -1; angle = atan2(vy, vx); }
    if (y < r)          { y = r;           vy *= -1; angle = atan2(vy, vx); }
  }

  void display() {
    fill(cbicho);
    noStroke();
    ellipse(x, y, r*2, r*2);
  }

  boolean isCaptured() {
    return dist(mouseX, mouseY, x, y) < r;
  }
}
