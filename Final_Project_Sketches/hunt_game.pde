// --- main ball (the "NIE appointment" to catch) ---
float ballX, ballY;
float ballVX, ballVY;

float AWARENESS_RADIUS = 220;   // mouse ONLY affects ball within this distance
float REPEL_STRENGTH   = 25;    // flee strength
float PANIC_DIST       = 120;   // if mouse is closer than this, MEGA push
float MAX_SPEED        = 14;
float FRICTION         = 0.94;
float BALL_RADIUS      = 22;

// --- wander (free roaming) ---
float wanderNoise  = 0;         // noise position for direction
float WANDER_DRIVE = 0.8;       // how hard the ball drives itself forward

// --- oval soft boundary ---
float BOUNDARY_MARGIN = 0.92;

// --- distraction grey balls ---
ArrayList<GreyBall> greys;
int NUM_GREYS = 10;

// --- game state ---
boolean gameOver    = false;
boolean catchedbug  = false;


void initializehunt() {
  gameOver   = false;
  catchedbug = false;

  ballX  = width / 2.0 + 100;
  ballY  = height / 2.0;
  ballVX = 0;
  ballVY = 0;
  wanderNoise = random(1000);

  greys = new ArrayList<GreyBall>();
  for (int i = 0; i < NUM_GREYS; i++) {
    greys.add(new GreyBall());
  }
}


void huntforappointments() {
  background(10);

  // update and draw grey distractions (behind main ball)
  for (GreyBall g : greys) {
    g.update();
    g.display();
  }

  // --- WANDER ---
  float wanderAngle = noise(wanderNoise) * TWO_PI * 2;
  float speedFactor = noise(wanderNoise + 500) * 2.5 + 0.3;
  if (random(1) < 0.015) speedFactor *= random(2, 4);

  ballVX += cos(wanderAngle) * WANDER_DRIVE * speedFactor;
  ballVY += sin(wanderAngle) * WANDER_DRIVE * speedFactor;
  wanderNoise += random(0.003, 0.015);

  // --- MOUSE AVOIDANCE ---
  float dx          = ballX - mouseX;
  float dy          = ballY - mouseY;
  float distToMouse = sqrt(dx * dx + dy * dy);

  if (distToMouse < AWARENESS_RADIUS && distToMouse > 0) {
    float proximity = 1 - (distToMouse / AWARENESS_RADIUS);
    float dirX      = dx / distToMouse;
    float dirY      = dy / distToMouse;

    float repelForce = proximity * REPEL_STRENGTH;
    ballVX += dirX * repelForce;
    ballVY += dirY * repelForce;

    // tangent force so ball arcs away instead of straight shove
    float tangentForce = proximity * 3;
    ballVX += -dirY * tangentForce;
    ballVY +=  dirX * tangentForce;

    // PANIC: hard shove if mouse gets very close
    if (distToMouse < PANIC_DIST) {
      float panicForce = (1 - distToMouse / PANIC_DIST) * 25;
      ballVX += dirX * panicForce;
      ballVY += dirY * panicForce;
    }
  }

  // --- OVAL SOFT BOUNDARY ---
  float cx = width  / 2.0;
  float cy = height / 2.0;
  float ea = (width  / 2.0) * BOUNDARY_MARGIN;
  float eb = (height / 2.0) * BOUNDARY_MARGIN;
  float nx = (ballX - cx) / ea;
  float ny = (ballY - cy) / eb;
  float ellipseR = sqrt(nx * nx + ny * ny);
  if (ellipseR > 0.65) {
    float pullStrength = (ellipseR - 0.65) * 6;
    ballVX += -nx * pullStrength;
    ballVY += -ny * pullStrength;
  }

  // --- speed cap ---
  float speed = sqrt(ballVX * ballVX + ballVY * ballVY);
  if (speed > MAX_SPEED) {
    ballVX = (ballVX / speed) * MAX_SPEED;
    ballVY = (ballVY / speed) * MAX_SPEED;
  }

  // friction + move
  ballVX *= FRICTION;
  ballVY *= FRICTION;
  ballX  += ballVX;
  ballY  += ballVY;

  // hard oval clamp (safety net)
  nx = (ballX - cx) / ea;
  ny = (ballY - cy) / eb;
  ellipseR = sqrt(nx * nx + ny * ny);
  if (ellipseR > 1) {
    ballX   = cx + (nx / ellipseR) * ea;
    ballY   = cy + (ny / ellipseR) * eb;
    ballVX *= -0.5;
    ballVY *= -0.5;
  }

  // draw mouse cursor
  fill(83, 74, 183);
  noStroke();
  ellipse(mouseX, mouseY, 14, 14);

  // draw main ball (color shifts with speed)
  float currentSpeed = sqrt(ballVX * ballVX + ballVY * ballVY);
  float t = constrain(currentSpeed / MAX_SPEED, 0, 1);
  fill(lerpColor(color(83, 74, 183), color(216, 90, 48), t));
  ellipse(ballX, ballY, BALL_RADIUS * 2, BALL_RADIUS * 2);

  if (gameOver) noLoop();
}


void revisecatches() {
  float dx   = mouseX - ballX;
  float dy   = mouseY - ballY;
  float dist = sqrt(dx * dx + dy * dy);

  if (dist < BALL_RADIUS) {
    catchedbug = true;
    phase      = 3;
    gameOver   = true;
  }
}


// ---------------------------------------------------
// GreyBall class: wandering distractions
// ---------------------------------------------------
class GreyBall {
  float x, y;
  float gvx, gvy;   // prefixed to avoid any shadowing confusion
  float sz;
  float greyShade;
  float wx, wy;

  GreyBall() {
    x         = random(width);
    y         = random(height);
    sz        = random(12, 50);
    greyShade = random(70, 220);
    wx        = random(100000);
    wy        = random(100000);
  }

  void update() {
    gvx += (noise(wx) - 0.5) * 1.8;
    gvy += (noise(wy) - 0.5) * 1.8;
    wx  += random(0.01, 0.04);
    wy  += random(0.01, 0.04);

    gvx *= 0.94;
    gvy *= 0.94;

    x += gvx;
    y += gvy;

    float half = sz / 2;
    if (x < half)           { x = half;           gvx = -gvx; }
    if (x > width  - half)  { x = width  - half;  gvx = -gvx; }
    if (y < half)           { y = half;            gvy = -gvy; }
    if (y > height - half)  { y = height - half;   gvy = -gvy; }
  }

  void display() {
    fill(greyShade, 180);
    noStroke();
    ellipse(x, y, sz, sz);
  }
}
