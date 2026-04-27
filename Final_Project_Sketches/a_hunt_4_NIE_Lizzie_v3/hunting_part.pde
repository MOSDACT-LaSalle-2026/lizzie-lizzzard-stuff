// --- main ball (the "NIE appointment" to catch) ---
float ballX, ballY;
float ballVX, ballVY;

float AWARENESS_RADIUS = 220;
float REPEL_STRENGTH   = 25;
float PANIC_DIST       = 120;
float MAX_SPEED        = 14;
float FRICTION         = 0.94;
float BALL_RADIUS      = 22;

// --- wander ---
float wanderNoise  = 0;
float WANDER_DRIVE = 0.8;

// --- oval soft boundary ---
float BOUNDARY_MARGIN = 0.92;

// --- chaos balls ---
ArrayList<ChaosBall> chaosBalls;
int NUM_CHAOS = 8;

// --- timer ---
int huntStartTime = 0;
int TIME_LIMIT    = 15000;   // 15 seconds

// --- game state ---
boolean gameOver   = false;
boolean catchedbug = false;


void initializehunt() {
  gameOver   = false;
  catchedbug = false;

  ballX  = width / 2.0 + 100;
  ballY  = height / 2.0;
  ballVX = 0;
  ballVY = 0;
  wanderNoise = random(1000);

  chaosBalls = new ArrayList<ChaosBall>();
  for (int i = 0; i < NUM_CHAOS; i++) {
    chaosBalls.add(new ChaosBall());
  }

  huntStartTime = millis();
}


void huntforappointments() {
  background(10);

  int elapsed   = millis() - huntStartTime;
  int remaining = TIME_LIMIT - elapsed;

  if (elapsed >= TIME_LIMIT) {
    gameOver = true;
    phase    = 5;
  }

  boolean tiredMode = (remaining <= 5000);

  // update and draw chaos balls
  for (ChaosBall c : chaosBalls) {
    c.update();
    c.display();
  }

  // --- WANDER ---
  float activeDrive = tiredMode ? 0.15 : WANDER_DRIVE;
  float activeMax   = tiredMode ? 3.0  : MAX_SPEED;

  float wanderAngle = noise(wanderNoise) * TWO_PI * 2;
  float speedFactor = noise(wanderNoise + 500) * 2.5 + 0.3;
  if (!tiredMode && random(1) < 0.015) speedFactor *= random(2, 4);

  ballVX += cos(wanderAngle) * activeDrive * speedFactor;
  ballVY += sin(wanderAngle) * activeDrive * speedFactor;
  wanderNoise += random(0.003, 0.015);

  // --- MOUSE AVOIDANCE: completely off in last 5 seconds ---
  if (!tiredMode) {
    float dx          = ballX - mouseX;
    float dy          = ballY - mouseY;
    float distToMouse = sqrt(dx * dx + dy * dy);

    if (distToMouse < AWARENESS_RADIUS && distToMouse > 0) {
      float proximity = 1 - (distToMouse / AWARENESS_RADIUS);
      float dirX      = dx / distToMouse;
      float dirY      = dy / distToMouse;

      ballVX += dirX * proximity * REPEL_STRENGTH;
      ballVY += dirY * proximity * REPEL_STRENGTH;

      ballVX += -dirY * proximity * 3;
      ballVY +=  dirX * proximity * 3;

      if (distToMouse < PANIC_DIST) {
        float panicForce = (1 - distToMouse / PANIC_DIST) * 25;
        ballVX += dirX * panicForce;
        ballVY += dirY * panicForce;
      }
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
  if (speed > activeMax) {
    ballVX = (ballVX / speed) * activeMax;
    ballVY = (ballVY / speed) * activeMax;
  }

  ballVX *= FRICTION;
  ballVY *= FRICTION;
  ballX  += ballVX;
  ballY  += ballVY;

  // hard oval clamp
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

  // main ball: bright purple, turns orange when mouse hovers over it
  float hoverDist = dist(mouseX, mouseY, ballX, ballY);
  if (hoverDist < BALL_RADIUS * 2.5) {
    fill(230, 100, 20);   // orange on hover
  } else {
    fill(130, 60, 220);   // bright purple normally
  }
  noStroke();
  ellipse(ballX, ballY, BALL_RADIUS * 2, BALL_RADIUS * 2);

  // --- countdown timer: red text bottom left ---
  int secsLeft = max(0, ceil((float)remaining / 1000.0));
  textAlign(LEFT, BOTTOM);
  textSize(56);
  if (remaining > 5000 || (frameCount % 20 < 15)) {
    fill(220, 40, 40);
    text(secsLeft + "s", 24, height - 20);
  }

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
    winTime    = millis();
  }
}


// ---------------------------------------------------
// ChaosBall: colorful, fast, chaotic distractions
// ---------------------------------------------------
class ChaosBall {
  float x, y;
  float vx, vy;
  float sz;
  color col;
  float wx, wy;
  float chaos;   // per-ball chaos level

  ChaosBall() {
    x     = random(width);
    y     = random(height);
    sz    = random(8, 40);
    chaos = random(2.5, 8.0);   // some balls way more chaotic than others
    wx    = random(100000);
    wy    = random(100000);

    // grey, green, or yellow only -- so the purple target stands out
    int pick = (int)random(3);
    if (pick == 0) {
      // grey
      float g = random(80, 200);
      col = color(g, g, g);
    } else if (pick == 1) {
      // green
      col = color(random(20, 80), random(140, 220), random(20, 80));
    } else {
      // yellow
      col = color(random(200, 255), random(180, 230), random(0, 50));
    }

    // start with a random velocity burst
    float angle = random(TWO_PI);
    vx = cos(angle) * random(2, 8);
    vy = sin(angle) * random(2, 8);
  }

  void update() {
    // noisy steering force -- high chaos = big erratic kicks
    vx += (noise(wx) - 0.5) * chaos;
    vy += (noise(wy) - 0.5) * chaos;
    wx += random(0.02, 0.08);
    wy += random(0.02, 0.08);

    // occasional random burst
    if (random(1) < 0.02) {
      float angle = random(TWO_PI);
      vx += cos(angle) * random(5, 12);
      vy += sin(angle) * random(5, 12);
    }

    // friction -- less than main ball so they stay fast
    vx *= 0.97;
    vy *= 0.97;

    x += vx;
    y += vy;

    // bounce off walls hard
    float half = sz / 2;
    if (x < half)          { x = half;          vx = abs(vx) * random(0.8, 1.2); }
    if (x > width - half)  { x = width - half;  vx = -abs(vx) * random(0.8, 1.2); }
    if (y < half)          { y = half;           vy = abs(vy) * random(0.8, 1.2); }
    if (y > height - half) { y = height - half;  vy = -abs(vy) * random(0.8, 1.2); }
  }

  void display() {
    fill(col, 200);
    noStroke();
    ellipse(x, y, sz, sz);
  }
}
