int phase   = 1;    // 1 = intro
                    // 2 = play
                    // 3 = win (got the appointment)
                    // 4 = appointment no longer available
                    // 5 = timer ran out

int winTime = 0;    // tracks when phase 3 started, for auto-advance

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
    loop();
    drawfog("This is the most effective way to get an appointment and process your NIE. \n\nPress <space> to start...");
    initializehunt();
  }
  if (phase == 2) {
    huntforappointments();
  }
  if (phase == 3) {
    loop();
    drawfog("Congratulations!  You've got an appointment to register your NIE. \n\nPress ENTER to continue to setup your appointment.");
    // auto-advance to phase 4 after 5 seconds
    if (millis() - winTime > 5000) {
      phase = 4;
    }
  }
  if (phase == 4) {
    loop();
    drawfog("We are sorry.  The appointment is no longer available... \n\nPlease try again next sunday at 8pm. \n\nPress <space>.");
  }
  if (phase == 5) {
    loop();
    drawfog("Sorry you were not able to get an appointment.  \n\nPlease try again next sunday at 8pm. \n\nPress <space>.");
  }
}

void mousePressed() {
  if (gameOver) return;
  revisecatches();
}

void keyPressed() {
  if (key == ' '   && phase == 1) phase = 2;
  if (key == ENTER && phase == 3) phase = 4;
  if (key == ' '   && phase == 4) phase = 1;
  if (key == ' '   && phase == 5) phase = 1;
}
