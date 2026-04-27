float fogSpeed = 0.003;
float t = 0;
int cback = 0;
int ctext = 255;

fog myFog;


void setupfog() {
  
  t = 0;
  cback = 0;
  ctext = 255;
  fogSpeed = 0.005;
  myFog = new fog(cback);

}

void drawjustfog() {
  myFog.drawFog(t, 140, 0.3, 0.002);
  t += fogSpeed;
}

void drawfogstring(String message) {

  background(cback);

  fill(ctext, 130);
  textSize(48);
  textAlign(CENTER, CENTER);
  text(message, 90, 70, 600, 400);
  
  myFog.drawFog(t, 140, 0.3, 0.002);

  t += fogSpeed;
}
