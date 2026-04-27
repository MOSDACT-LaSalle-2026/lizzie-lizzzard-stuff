float fogSpeed = 0.003;
float t = 0;
int cback = 0;

fog myFog;


void setupfog() {
  t = 0;
  cback = 70;
  fogSpeed = 0.005;
  myFog = new fog(cback);
}

void drawfog(String message) {
  background(cback);

  // red text, centered, sized to fit any canvas
  fill(220, 40, 40, 180);
  textSize(52);
  textAlign(CENTER, CENTER);
  text(message, width * 0.1, height * 0.08, width * 0.8, height * 0.78);

  myFog.drawFog(t, 140, 0.3, 0.002);

  t += fogSpeed;
}
