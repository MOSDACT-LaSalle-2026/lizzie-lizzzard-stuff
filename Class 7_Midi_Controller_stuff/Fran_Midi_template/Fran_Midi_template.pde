import themidibus.*;

final String MIDI_DEVICE_NAME = "Arturia MiniLab mkII";

// ── Plug in your CC numbers here after discovering them ──
final int KNOB_X_CC = 70;  // replace with your knob 1 CC number
final int KNOB_Y_CC = 71;  // replace with your knob 2 CC number

MidiBus myBus;

// Circle state — CC values come in as 0–127, we'll map to canvas coords
float circleX;
float circleY;
float circleSize = 40;

void setup() {
  size(600, 600);
  
  // Start circle in the center
  circleX = width / 2;
  circleY = height / 2;
  
  MidiBus.list();
  myBus = new MidiBus(this, MIDI_DEVICE_NAME, -1);
  println("Ready. Twist your knobs.");
}

void draw() {
  background(30);
  
  noStroke();
  fill(255, 80, 120);
  circle(circleX, circleY, circleSize);
}

void controllerChange(int channel, int number, int value) {
  // map() rescales 0–127 → 0–width (or height)
  // Python equivalent: np.interp(value, [0, 127], [0, width])
  
  if (number == KNOB_X_CC) {
    circleX = map(value, 0, 127, 0, width);
    println("Knob X → CC" + number + " val:" + value + " → x:" + circleX);
  }
  
  if (number == KNOB_Y_CC) {
    circleY = map(value, 0, 127, 0, height);
    println("Knob Y → CC" + number + " val:" + value + " → y:" + circleY);
  }
}

// Keep these for debugging — you can remove once everything works
void noteOn(int channel, int pitch, int velocity) {
  println("noteOn | pitch:" + pitch + " vel:" + velocity);
}

void noteOff(int channel, int pitch, int velocity) {
  println("noteOff | pitch:" + pitch);
}
