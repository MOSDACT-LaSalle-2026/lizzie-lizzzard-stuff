// digital glitch
// to be used when a bug is catched

PFont f;
int gtime = 0;

//void setup() {
//  size(800, 600);
//  f = createFont("Courier", 32);
//  textFont(f);
//}

void drawsystemglitch() {
  background(0);

  // background noise to simulate a glitch
  loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    float n = random(255);
    pixels[i] = color(n * 0.1, n * 0.3, n * 0.6); // cold blue glitch
  }
  updatePixels();

  // horizontal glitch lines
  for (int i = 0; i < 20; i++) {
    float y = random(height);
    float h = random(2, 10);
    fill(random(50, 255), random(50, 255), random(255));
    noStroke();
    rect(0, y, width, h);
  }

  // text with the fatal error
  String msg = "SYSTEM ERROR 0x0F2A\nILLEGAL APPOINTMENT\naddress ED87FA";
  float x = width/2;
  float y = height/2;

  textAlign(CENTER, CENTER);
  textSize(40);

  // red glitch shadow
  fill(255, 0, 0, 150);
  text(msg, x + random(-5, 5), y + random(-5, 5));

  // blue glitch shadow
  fill(0, 150, 255, 150);
  text(msg, x + random(-5, 5), y + random(-5, 5));

  // main text in white
  fill(255);
  text(msg, x, y);

  // random flash
  if (random(1) < 0.05) {
    fill(255, 255, 255, 40);
    rect(0, 0, width, height);
  }
}
