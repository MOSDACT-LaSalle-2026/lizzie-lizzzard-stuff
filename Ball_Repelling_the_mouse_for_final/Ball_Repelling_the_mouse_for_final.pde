// --- main ball ---
float objX, objY;
float vx, vy;

float AWARENESS_RADIUS = 220;  // mouse ONLY affects ball within this distance
float REPEL_STRENGTH = 25;      // flee strength
float PANIC_DIST = 120;          // if mouse is closer than this, MEGA push
float MAX_SPEED = 14;
float FRICTION = 0.94;
float RADIUS = 22;

// --- wander (free roaming) ---
float wanderNoise = 0;           // noise position for direction
float WANDER_DRIVE = 0.8;        // how hard the ball drives itself forward

// --- oval soft boundary ---
float BOUNDARY_MARGIN = 0.92;

// --- distraction grey balls ---
ArrayList<GreyBall> greys;
int NUM_GREYS = 10;

void setup() {
  size(700, 900);
  objX = width / 2 + 100;
  objY = height / 2;
  
  greys = new ArrayList<GreyBall>();
  for (int i = 0; i < NUM_GREYS; i++) {
    greys.add(new GreyBall());
  }
}

void draw() {
  background(240);
  
  // update and draw grey distractions first (behind main ball)
  for (GreyBall g : greys) {
    g.update();
    g.display();
  }
  
  // --- WANDER ---
  // direction comes from Perlin noise (smoothly changing angle)
  float wanderAngle = noise(wanderNoise) * TWO_PI * 2;
  
  // speed comes from ANOTHER noise channel + occasional random bursts
  float speedFactor = noise(wanderNoise + 500) * 2.5 + 0.3;
  if (random(1) < 0.015) speedFactor *= random(2, 4);
  
  // apply wander force in the current direction
  vx += cos(wanderAngle) * WANDER_DRIVE * speedFactor;
  vy += sin(wanderAngle) * WANDER_DRIVE * speedFactor;
  
  // advance noise so direction and speed keep evolving
  wanderNoise += random(0.003, 0.015);  // variable step = variable pace of change
  
  // --- MOUSE AVOIDANCE (only kicks in when mouse is close) ---
  float dx = objX - mouseX;
  float dy = objY - mouseY;
  float distToMouse = sqrt(dx * dx + dy * dy);
  
  if (distToMouse < AWARENESS_RADIUS && distToMouse > 0) {
    float proximity = 1 - (distToMouse / AWARENESS_RADIUS);  // 0 when far, 1 when on mouse
    float dirX = dx / distToMouse;
    float dirY = dy / distToMouse;
    
    // radial repel
    float repelForce = proximity * REPEL_STRENGTH;
    vx += dirX * repelForce;
    vy += dirY * repelForce;
    
    // tangent (sideways) force so the ball arcs AWAY instead of straight shove
    // this is what prevents the "pinned to corner" bug
    float tangentForce = proximity * 3;
    vx += -dirY * tangentForce;
    vy +=  dirX * tangentForce;
    
    // PANIC: if mouse is very close, hard shove
    if (distToMouse < PANIC_DIST) {
      float panicForce = (1 - distToMouse / PANIC_DIST) * 25;
      vx += dirX * panicForce;
      vy += dirY * panicForce;
    }
  }
  
  // --- OVAL SOFT BOUNDARY ---
  float cx = width / 2.0;
  float cy = height / 2.0;
  float ea = (width / 2.0) * BOUNDARY_MARGIN;
  float eb = (height / 2.0) * BOUNDARY_MARGIN;
  float nx = (objX - cx) / ea;
  float ny = (objY - cy) / eb;
  float ellipseR = sqrt(nx * nx + ny * ny);
  if (ellipseR > 0.65) {
    float pullStrength = (ellipseR - 0.65) * 6;
    vx += -nx * pullStrength;
    vy += -ny * pullStrength;
  }
  
  // --- speed cap ---
  float speed = sqrt(vx * vx + vy * vy);
  if (speed > MAX_SPEED) {
    vx = (vx / speed) * MAX_SPEED;
    vy = (vy / speed) * MAX_SPEED;
  }
  
  // friction + move
  vx *= FRICTION;
  vy *= FRICTION;
  objX += vx;
  objY += vy;
  
  // hard oval clamp (safety)
  nx = (objX - cx) / ea;
  ny = (objY - cy) / eb;
  ellipseR = sqrt(nx * nx + ny * ny);
  if (ellipseR > 1) {
    objX = cx + (nx / ellipseR) * ea;
    objY = cy + (ny / ellipseR) * eb;
    vx *= -0.5;
    vy *= -0.5;
  }
  
  // mouse cursor
  fill(83, 74, 183);
  noStroke();
  ellipse(mouseX, mouseY, 14, 14);
  
  // main ball (color shifts with speed)
  float currentSpeed = sqrt(vx * vx + vy * vy);
  float t = constrain(currentSpeed / MAX_SPEED, 0, 1);
  fill(lerpColor(color(83, 74, 183), color(216, 90, 48), t));
  ellipse(objX, objY, RADIUS * 2, RADIUS * 2);
}


// -------------------------------
// GreyBall class: wandering distractions
// -------------------------------
class GreyBall {
  float x, y;
  float vx, vy;
  float size;
  float greyShade;
  float wx, wy;
  
  GreyBall() {
    x = random(width);
    y = random(height);
    size = random(12, 50);
    greyShade = random(70, 220);
    wx = random(100000);
    wy = random(100000);
  }
  
  void update() {
    vx += (noise(wx) - 0.5) * 1.8;
    vy += (noise(wy) - 0.5) * 1.8;
    wx += random(0.01, 0.04);
    wy += random(0.01, 0.04);
    
    vx *= 0.94;
    vy *= 0.94;
    
    x += vx;
    y += vy;
    
    float half = size / 2;
    if (x < half) { x = half; vx = -vx; }
    if (x > width - half) { x = width - half; vx = -vx; }
    if (y < half) { y = half; vy = -vy; }
    if (y > height - half) { y = height - half; vy = -vy; }
  }
  
  void display() {
    fill(greyShade, 180);
    noStroke();
    ellipse(x, y, size, size);
  }
}
