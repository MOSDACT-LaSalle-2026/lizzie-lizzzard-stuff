int phase = 1;      // phase == 1 --> intro, fog, text to start
                    // phase == 2 --> play the game
                    // phase == 3 --> we have a winner
                    // phase == 4 --> sorry you did not ge the appointment

void settings() {
  pixelDensity(1);     
  size(800, 600, JAVA2D);
}


void setup() {
  phase = 1;
  setupfog();
  initializehunt();
}

void draw() {
  if (phase == 1) {
    drawfog("This is the most effective way to get an appointment and process your NIE.  Press <space> to start...");
  }
  if (phase == 2) {
    huntforappointments();
  }
  if (phase == 3) {
    drawfog("Congratulations!  You were able to get an appointment.");
  }
  if (phase == 4) {
    drawfog("Sorry you were not able to get an appointment.  Please try again next sunday at 8pm");
  }
}

void mousePressed() {

  if (gameOver) return;   // no permitir más capturas

  revisecatches();
}

void keyPressed() {
  if (key == ' ' && phase == 1) phase = 2;
}
