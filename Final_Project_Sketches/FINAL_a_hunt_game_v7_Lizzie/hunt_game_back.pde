// section for background and mouse
float bgW = width * 0.9;
float bgH = height * 0.9;
float bgX = width / 2.0;
float bgY = height / 2.0;

void drawinitialscreen() {
  background(0);
  image(initbg, bgX, bgY, width, height);
}


void drawBackground() {
  background(0);
  image(bg, bgX, bgY, bgW, bgH);
}

void drawIntro() {
  drawBackground();
  if (frameCount % 10 < 5) {
    fill(255, 220, 0);
    textAlign(CENTER, CENTER);
    textSize(int(width * 0.022));
    text("CLICK MOUSE TO START", width / 2, height * 0.23);
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
  image(pacmanCursor, mouseX, mouseY, 40, 40);
}
