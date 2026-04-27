int phase = 1;  // 1 = intro, 2 = play, 3 = win, 4 = appointment gone, 5 = lose

PImage bg;
PImage pacmanCursor;

void settings() {
  pixelDensity(1);
  fullScreen(JAVA2D);
}

void setup() {
  bg = loadImage("PacmanBackground3.png");
  pacmanCursor = loadImage("pacman.mouse.png");
  noCursor();
  initializehunt();
}

void draw() {
  if (phase == 1) {
    drawIntro();
  }
  if (phase == 2) {
    huntforappointments();
  }
  if (phase == 3) {
    loop();
    drawOverlayText("Congratulations! You were able to get an appointment.\n\nPress ENTER to continue.");
  }
  if (phase == 4) {
    loop();
    drawOverlayText("We are sorry. The appointment is no longer available...\n\nPress SPACE to try again.");
  }
  if (phase == 5) {
    loop();
    drawOverlayText("Sorry you were not able to get an appointment.\n\nPress SPACE to try again.");
  }
  drawCursor();
}

void drawBackground() {
  background(0);
  float bgW = width * 0.9;
  float bgH = height * 0.9;
  float bgX = (width - bgW) / 2.0;
  float bgY = (height - bgH) / 2.0;
  image(bg, bgX, bgY, bgW, bgH);
}

void drawIntro() {
  drawBackground();
  if (frameCount % 10 < 5) {
    fill(255, 220, 0);
    textAlign(CENTER, CENTER);
    textSize(int(width * 0.022));
    text("PRESS <SPACE> TO START", width / 2, height * 0.24);
  }
}

void drawOverlayText(String message) {
  drawBackground();
  fill(0, 0, 0, 200);
  rect(0, 0, width, height);
  fill(255, 220, 0);
  textSize(int(width * 0.032));
  textAlign(CENTER, CENTER);
  text(message, width * 0.1, height * 0.35, width * 0.8, height * 0.35);
}

void drawCursor() {
  image(pacmanCursor, mouseX - 10, mouseY - 10, 40, 40);
}

void mousePressed() {
  if (gameOver) return;
  revisecatches();
}

void keyPressed() {
  if (key == ' ' && phase == 1) { phase = 2; loop(); }
  if (key == ENTER && phase == 3) phase = 4;
  if (key == ' ' && phase == 4) phase = 1;
  if (key == ' ' && phase == 5) phase = 1;
}
