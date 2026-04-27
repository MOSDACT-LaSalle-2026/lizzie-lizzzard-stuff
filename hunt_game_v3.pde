// =====================================================
// HUNT GAME - the main gameplay tab
// The player has 15 seconds to click the purple ball.
// The ball wanders around and runs away from the mouse.
// Click it to win. Run out of time to lose.
// =====================================================

// --- the purple ball the player needs to catch ---
float ballX, ballY;   // position
float ballVX, ballVY; // velocity
float BALL_RADIUS = 22;

// --- how the ball moves and runs away ---
float MAX_SPEED      = 14;   // top speed
float FRICTION       = 0.94; // slows down each frame (1.0 = no friction)
float FLEE_STRENGTH  = 25;   // how hard it runs from the mouse
float FLEE_RADIUS    = 220;  // how close the mouse has to be before it reacts

// --- the 15 second countdown ---
int huntStartTime = 0;
int TIME_LIMIT    = 15000;  // milliseconds (15000 = 15 seconds)

// --- game state (used by the main tab) ---
boolean gameOver   = false;
boolean catchedbug = false;

// --- distraction balls ---
ArrayList<ChaosBall> chaosBalls;
int NUM_CHAOS = 30;


// -------------------------------------------------
// Called once at the start of each round
// -------------------------------------------------
void initializehunt() {
  gameOver   = false;
  catchedbug = false;

  // place the ball near the center
  ballX  = width / 2.0 + 100;
  ballY  = height / 2.0;
  ballVX = 0;
  ballVY = 0;

  // create the distraction balls
  chaosBalls = new ArrayList<ChaosBall>();
  for (int i = 0; i < NUM_CHAOS; i++) {
    chaosBalls.add(new ChaosBall());
  }

  huntStartTime = millis(); // start the clock
}


// -------------------------------------------------
// Called every frame while phase == 2 (playing)
// -------------------------------------------------
void huntforappointments() {
  background(10); // dark background

  // --- check if time is up ---
  int elapsed   = millis() - huntStartTime;
  int remaining = TIME_LIMIT - elapsed;
  if (elapsed >= TIME_LIMIT) {
    gameOver = true;
    phase    = 5;  // go to "sorry" screen
  }

  // --- draw the distraction balls ---
  for (ChaosBall c : chaosBalls) {
    c.update();
    c.display();
  }

  // --- move the ball: it steers randomly using Perlin noise ---
  float angle = noise(ballX * 0.005, ballY * 0.005, frameCount * 0.01) * TWO_PI * 2;
  ballVX += cos(angle) * 0.8;
  ballVY += sin(angle) * 0.8;

  // --- the ball runs away from the mouse ---
  float d = dist(mouseX, mouseY, ballX, ballY);
  if (d < FLEE_RADIUS && d > 0) {
    float flee = (1 - d / FLEE_RADIUS) * FLEE_STRENGTH;
    ballVX += (ballX - mouseX) / d * flee;
    ballVY += (ballY - mouseY) / d * flee;
  }

  // --- keep speed under control ---
  float speed = sqrt(ballVX * ballVX + ballVY * ballVY);
  if (speed > MAX_SPEED) {
    ballVX = ballVX / speed * MAX_SPEED;
    ballVY = ballVY / speed * MAX_SPEED;
  }

  // --- apply friction and move ---
  ballVX *= FRICTION;
  ballVY *= FRICTION;
  ballX  += ballVX;
  ballY  += ballVY;

  // --- bounce off the edges ---
  if (ballX < BALL_RADIUS)         { ballX = BALL_RADIUS;         ballVX *= -1; }
  if (ballX > width - BALL_RADIUS) { ballX = width - BALL_RADIUS; ballVX *= -1; }
  if (ballY < BALL_RADIUS)         { ballY = BALL_RADIUS;         ballVY *= -1; }
  if (ballY > height - BALL_RADIUS){ ballY = height - BALL_RADIUS;ballVY *= -1; }

  // --- draw the purple ball (turns orange when mouse is near) ---
  noStroke();
  if (d < BALL_RADIUS * 2.5) {
    fill(230, 100, 20);  // orange = you're close enough to click!
  } else {
    fill(130, 60, 220);  // purple normally
  }
  ellipse(ballX, ballY, BALL_RADIUS * 2, BALL_RADIUS * 2);

  // --- countdown in red bottom left ---
  int secsLeft = max(0, ceil(remaining / 1000.0));
  textAlign(LEFT, BOTTOM);
  textSize(56);
  fill(220, 40, 40);
  text(secsLeft + "s", 24, height - 20);

  if (gameOver) noLoop();
}


// -------------------------------------------------
// Called when the player clicks the mouse
// -------------------------------------------------
void revisecatches() {
  float d = dist(mouseX, mouseY, ballX, ballY);
  if (d < BALL_RADIUS) {
    catchedbug = true;
    phase      = 3;    // go to win screen
    gameOver   = true;
    winTime    = millis();
  }
}


// =====================================================
// ChaosBall: grey/green/yellow distraction balls
// =====================================================
class ChaosBall {
  float x, y;    // position
  float vx, vy;  // velocity
  float sz;      // size
  color col;     // colour (grey, green, or yellow)

  ChaosBall() {
    x  = random(width);
    y  = random(height);
    sz = random(8, 40);

    // random starting velocity
    float angle = random(TWO_PI);
    vx = cos(angle) * random(2, 8);
    vy = sin(angle) * random(2, 8);

    // pick grey, green, or yellow so purple target stands out
    int pick = (int)random(3);
    if (pick == 0) {
      float g = random(80, 200);
      col = color(g, g, g);          // grey
    } else if (pick == 1) {
      col = color(random(20, 80), random(140, 220), random(20, 80));  // green
    } else {
      col = color(random(200, 255), random(180, 230), random(0, 50)); // yellow
    }
  }

  void update() {
    // random kicks to keep movement chaotic
    vx += random(-1, 1) * 1.5;
    vy += random(-1, 1) * 1.5;

    // occasional big burst
    if (random(1) < 0.02) {
      vx += random(-10, 10);
      vy += random(-10, 10);
    }

    vx *= 0.97;  // friction
    vy *= 0.97;

    x += vx;
    y += vy;

    // bounce off walls
    float half = sz / 2;
    if (x < half)          { x = half;          vx *= -1; }
    if (x > width - half)  { x = width - half;  vx *= -1; }
    if (y < half)          { y = half;           vy *= -1; }
    if (y > height - half) { y = height - half;  vy *= -1; }
  }

  void display() {
    fill(col, 200);
    noStroke();
    ellipse(x, y, sz, sz);
  }
}
