// === GLOBAL VARIABLES ===

int pos = 350;    // vertical position of the line
float ang = 45;   // rotation angle of the line

// Color for the line
float red_val   = random(0, 255);
float green_val = random(0, 255);
float blue_val  = random(0, 255);


// === SETUP — runs once at the start ===

void setup() {
  size(700, 900);
  frameRate(60);
}


// === DRAW — loops continuously ===

void draw() {

  // --- Fade effect ---
  fill(255, 0, 200, 12);   // last number is the transparency (how quickly it fades) 
  rect(0, 0, 700, 900);    //adds a new pink rect in each frame 

  // --- Rotating line (moves down, spins) ---
  fill(red_val, green_val, blue_val);
  stroke(200, 200, 0);
  strokeWeight(2);
  translate(mouseX, pos);
  rotate(radians(ang));
  line(0, 0, 203, 0);

  // --- Update movement each frame ---
  pos = pos + 4;
  ang = ang + 5;

  // --- Reset when line reaches the bottom ---
  if (pos >= height) {
    pos = 0;
    red_val   = random(0, 255);
    green_val = random(0, 255);
    blue_val  = random(0, 255);
  }
}


// === KEY PRESSED — resets vertical position ===

void keyPressed() {
  pos = 100;
}
