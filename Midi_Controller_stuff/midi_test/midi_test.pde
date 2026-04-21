import themidibus.*;  // import the library

MidiBus myBus;  // the MidiBus

float bgBrightness = 20;   // background darkness / lightness
float circleSize   = 120;  // size of the shape on screen
float circleX, circleY;    // position of the shape
color circleColor;         // color of the shape


void setup (){
  MidiBus.list();
  size(800,800);
  
  myBus = new MidiBus(this, "LPD8 mk2", -1); // create a new MidiBus 
  // midi = new MidiBus(this, 0, -1);  //this is how to 

  circleX = width / 2;
  circleY = height / 2;
  circleColor = color(255, 100, 150);
  
}

void draw() {
  // clear the screen each frame with the current brightness
  background(bgBrightness);

  // draw the shape
  noStroke();
  fill(circleColor);
  ellipse(circleX, circleY, circleSize, circleSize);
}


void noteOn(int channel, int pitch, int velocity) {
  println("NOTE ON  | channel: " + channel + "  pitch: " + pitch + "  velocity: " + velocity);

  // EXAMPLE: map the pitch of the note to horizontal position,
  // and use how hard you hit the pad (velocity) as the size.
  circleX = map(pitch, 36, 84, 50, width - 50);
  circleSize = map(velocity, 0, 127, 40, 300);

  // EXAMPLE: flash a different color when a pad is hit
  circleColor = color(120, 220, 255);
}
