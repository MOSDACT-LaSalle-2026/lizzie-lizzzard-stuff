color brushColor = #FFFFFF;  // white to start
color col1 = #ff4d6d;        //  pink
color col2 = #9bf6ff;        //  blue
color col3 = #ff6b35;        //  orange
int screenshotCount = 1;


void setup() {
  size(600, 900);
  background(0);
  frameRate(30);
}

void draw() {
  
   // --- Fade effect (semi-transparent white overlay instead of clearing background) ---
  //fill(0, 2);
  //rect(0, 0, 700, 900);



  translate(mouseX, mouseY);        // move anchor to mouse
  rotate(radians(frameCount * 3));  // spin a little each frame
  
float t = (sin(frameCount * 0.02) + 1) / 2.0;
float t2 = (sin(frameCount * 0.02 + 2.0) + 1) / 2.0;  // offset by 2.0
color ca = lerpColor(col1, col2, t);
color cb = lerpColor(col2, col3, t2);  // t2 instead of t
color c = lerpColor(ca, cb, t);
stroke(c);
  strokeWeight(2);
  line(0, 0, 70, 0);                // line FROM center outward
}


void keyPressed() {
  if (key == 'q') { noLoop(); }   // pause   
  if (key == 'w') { loop(); }     // resume
                                  // or press alt to keep the loop 
                                  // going but stop following the mouse
  if (key == 'r') { background(0); }    // reset black
  if (key == 'e') { background(255); }  // reset white
  

 if (key == ' ') {
  save("screenshot" + screenshotCount + ".jpeg");
  screenshotCount = screenshotCount + 1;
 }
}
