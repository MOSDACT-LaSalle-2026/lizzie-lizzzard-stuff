
class Bicho {
  float x, y;
  float t1, t2;
  float r = 15;
  color cbicho;

  boolean captured = false;
  boolean dead     = false;

  Bicho() {
    x = random(width);
    y = random(height);
    t1 = random(1000);
    t2 = random(2000);
    cbicho = color(100, 200, 255);
    captured = false;
    dead = false;
  }

  void update() {
    if (captured) return;  // no se mueve si está capturado

    x = map(noise(t1), 0, 1, -width*0.2, width*1.2);
    y = map(noise(t2), 0, 1, -height*0.2, height*1.2);

    t1 += 0.03;
    t2 += 0.03;

    if (x > width || x < 0 || y > height || y < 0) {
      dead = true;
    }
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
