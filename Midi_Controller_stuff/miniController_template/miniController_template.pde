// ============================================================
// MINI CONTROLLER TEMPLATE - Processing + The MidiBus
// ============================================================
// A blank starter for sketches that use a MIDI mini controller
// (Korg nanoKONTROL2, Akai LPD8, Arturia MiniLab, etc.)
//
// HOW TO USE THIS FILE:
// 1. Plug your mini controller into your computer BEFORE opening Processing.
// 2. Open this sketch in Processing.
// 3. Make sure "The MidiBus" library is installed
//    (Sketch > Import Library > Add Library > search "MidiBus").
// 4. Click the Run button (top).
// 5. Look in the black console at the bottom of Processing.
//    It prints a list of every MIDI device your computer can see.
//    Find your controller's name in that list.
// 6. If your device is NOT the first one in the list, scroll down
//    to the setup() function and change the line marked "STEP 1"
//    so the name matches yours exactly (or use its index number).
// 7. Move a knob / press a pad on your controller.
//    The console will print out the channel, CC number, and value.
//    Write those numbers down - that's your controller's "map".
// 8. Use those numbers in the controllerChange() and noteOn()
//    functions below to hook knobs/pads up to whatever you want.
// ============================================================

import themidibus.*; // pulls in the MIDI library

MidiBus midi; // the object that listens to your controller

// ---- variables you can play with visually ----
// These hold values that your knobs/pads will change.
// Add or remove as needed for your own sketch.
float bgBrightness = 20;   // background darkness / lightness
float circleSize   = 120;  // size of the shape on screen
float circleX, circleY;    // position of the shape
color circleColor;         // color of the shape


void setup() {
  size(800, 600);

  // starting values
  circleX = width / 2;
  circleY = height / 2;
  circleColor = color(255, 100, 150);

  // ---- STEP 1: connect to your MIDI controller ----
  // This prints every MIDI device available. Read the console!
  MidiBus.list();

  // Pick ONE of the three lines below. Comment out the other two
  // by putting // at the start of the line.

  // Option A (easy default): use the first input device found
  midi = new MidiBus(this, 0, -1);

  // Option B: use a device by name (safer - works even if device order changes)
  // midi = new MidiBus(this, "nanoKONTROL2", -1);

  // Option C: use a specific index number from the MidiBus.list() output
  // midi = new MidiBus(this, 2, -1);
}


void draw() {
  // clear the screen each frame with the current brightness
  background(bgBrightness);

  // draw the shape
  noStroke();
  fill(circleColor);
  ellipse(circleX, circleY, circleSize, circleSize);
}


// ============================================================
// MIDI EVENT HANDLERS
// These functions run AUTOMATICALLY whenever your controller
// sends a message. You do not call them yourself.
// ============================================================

// ---- runs when a pad or key is PRESSED ----
void noteOn(int channel, int pitch, int velocity) {
  println("NOTE ON  | channel: " + channel + "  pitch: " + pitch + "  velocity: " + velocity);

  // EXAMPLE: map the pitch of the note to horizontal position,
  // and use how hard you hit the pad (velocity) as the size.
  circleX = map(pitch, 36, 84, 50, width - 50);
  circleSize = map(velocity, 0, 127, 40, 300);

  // EXAMPLE: flash a different color when a pad is hit
  circleColor = color(120, 220, 255);
}


// ---- runs when a pad or key is RELEASED ----
void noteOff(int channel, int pitch, int velocity) {
  println("NOTE OFF | channel: " + channel + "  pitch: " + pitch);

  // reset to the resting color when the pad is let go
  circleColor = color(255, 100, 150);
}


// ---- runs when a KNOB or FADER moves ----
// 'number' = which knob/fader (CC number), 'value' = where it is (0 to 127)
void controllerChange(int channel, int number, int value) {
  println("CC       | channel: " + channel + "  cc#: " + number + "  value: " + value);

  // Use switch-case to cleanly handle each knob / fader.
  // Replace the case numbers with the CC numbers YOUR controller prints.
  switch (number) {

    case 0:  // first fader - controls background brightness
      bgBrightness = map(value, 0, 127, 0, 255);
      break;

    case 1:  // second fader - controls circle size
      circleSize = map(value, 0, 127, 20, 400);
      break;

    case 2:  // third fader - controls vertical position
      circleY = map(value, 0, 127, 50, height - 50);
      break;

    case 16: // first knob - red channel of color
      circleColor = color(map(value, 0, 127, 0, 255), green(circleColor), blue(circleColor));
      break;

    case 17: // second knob - green channel of color
      circleColor = color(red(circleColor), map(value, 0, 127, 0, 255), blue(circleColor));
      break;

    case 18: // third knob - blue channel of color
      circleColor = color(red(circleColor), green(circleColor), map(value, 0, 127, 0, 255));
      break;

    // ADD MORE CASES HERE for extra knobs, faders, or buttons.
    // Move a control, look at the console to find its CC number,
    // then add a new "case <number>:" block.

    default:
      // ignore anything we haven't mapped yet
      break;
  }
}


// ============================================================
// OPTIONAL: uncomment these if you want to catch more stuff
// ============================================================

// void programChange(int channel, int number) {
//   println("PROGRAM CHANGE | channel: " + channel + "  number: " + number);
// }

// void pitchBend(int channel, int value) {
//   println("PITCH BEND | channel: " + channel + "  value: " + value);
// }
