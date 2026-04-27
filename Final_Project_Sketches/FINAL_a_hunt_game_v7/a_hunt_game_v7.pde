// main block for program

int phase = 1;      // phase == 1 --> intro text and setting up stage
                    // phase == 2 --> setup the game with background and ready everything
                    // phase == 3 --> play the game
                    // phase == 4 --> we have a winner
                    // phase == 5 --> oops... system error...
                    // phase == 6 --> sorry you did not ge the appointment

PImage bg;
PImage initbg;
PImage pacmanCursor;

int time = 0;


void setup() {
  size(1024, 720);
  imageMode(CENTER);

  bg = loadImage("PacmanBackground3.png");
  initbg = loadImage("initialscreen.png");
  pacmanCursor = loadImage("pacman.mouse.png");
  noCursor();

  bgW = width * 0.9;
  bgH = height * 0.9;
  bgX = width / 2.0;
  bgY = height / 2.0;


  phase = 1;
  time = 0;
  initializehunt();
}

void draw() {
  if (phase == 1) {
    loop();
    drawinitialscreen();
    initializehunt();
  }
  if (phase == 2) {
    drawIntro();
    initialdrawingcharacters();
  }
  if (phase == 3) {
    huntforappointments();
  }
  if (phase == 4) {
    loop();
    drawOverlayText("Congratulations! You were able to get an appointment.\n\nPress ENTER to continue.");
  }
  if (phase == 5) {
    loop();
    drawsystemglitch();
    gtime++;
    if (gtime > 50) phase = 6;
  }
  if (phase == 6) {
    loop();
    drawOverlayText("Sorry you were not able to get an appointment.\n\nPress SPACE to try again.");
  }

  drawCursor();

}

void mousePressed() {

  if (gameOver) return;
  if (phase == 1) phase = 2;
  if (phase == 2) phase = 3;

  revisecatches();
}

void keyPressed() {
  if (key == ' ' && phase == 1) phase = 2;
  if (key == ENTER && phase == 4) phase = 5;
  if (key == ' ' && phase == 5) phase = 1;
  if (key == ' ' && phase == 6) phase = 1;
}
