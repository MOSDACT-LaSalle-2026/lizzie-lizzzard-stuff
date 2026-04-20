float objX, objY;
float vx, vy;
float REPEL_RADIUS = 100;
float REPEL_STRENGTH = 20;
float FRICTION = 0.92;
float RADIUS = 22;

// wandering variables (for autonomous random movement)
float wanderX = 0;          // position in noise space for X force
float wanderY = 10000;      // position in noise space for Y force (offset so they don't match)
float WANDER_STRENGTH = 2.5;

void setup() {
  size(700, 900);
  objX = width / 2;
  objY = height / 2;
}

void draw() {
  background(240);
  
  // repulsion from mouse
  float dx = objX - mouseX;
  float dy = objY - mouseY;
  float dist = sqrt(dx * dx + dy * dy);
  if (dist < REPEL_RADIUS && dist > 0) {
    float force = (1 - dist / REPEL_RADIUS) * REPEL_STRENGTH;
    vx += (dx / dist) * force;
    vy += (dy / dist) * force;
  }
  
  // wandering force: smooth random motion via Perlin noise
  // noise() returns 0 to 1 smoothly; subtract 0.5 to get -0.5 to +0.5
  vx += (noise(wanderX) - 0.5) * WANDER_STRENGTH;
  vy += (noise(wanderY) - 0.5) * WANDER_STRENGTH;
  
  // step through noise space at a VARYING rate (this is what makes speed change)
  wanderX += random(0.005, 0.04);
  wanderY += random(0.005, 0.04);
  
  // friction + movement
  vx *= FRICTION;
  vy *= FRICTION;
  objX += vx;
  objY += vy;
  
  // bounce off walls instead of pinning (keeps the ball always moving)
  if (objX < RADIUS) { objX = RADIUS; vx = -vx; }
  if (objX > width - RADIUS) { objX = width - RADIUS; vx = -vx; }
  if (objY < RADIUS) { objY = RADIUS; vy = -vy; }
  if (objY > height - RADIUS) { objY = height - RADIUS; vy = -vy; }
  
  // draw mouse influence radius
 // noFill();
 // stroke(83, 74, 183, 60);
 // strokeWeight(1.5);
 // ellipse(mouseX, mouseY, REPEL_RADIUS * 2, REPEL_RADIUS * 2);
  
  // draw mouse cursor
  fill(83, 74, 183);
  noStroke();
  ellipse(mouseX, mouseY, 14, 14);
  
  // draw the object (color shifts with speed)
  float speed = sqrt(vx * vx + vy * vy);
  float t = constrain(speed / 10, 0, 1);
  fill(lerpColor(color(83, 74, 183), color(216, 90, 48), t));
  ellipse(objX, objY, RADIUS * 2, RADIUS * 2);
}
