void setup() {
  size(700, 700);
  background(0);
  frameRate(60);
}

void draw() {
  float speed = abs(mouseX - pmouseX) + abs(mouseY - pmouseY);
  
  noStroke();
  fill(speed * 2, 0, 10, 255);  // red channel reacts to speed
  circle(mouseX, mouseY, speed);
}

// slay 

void keyPressed() {
  if (key == 'r') { background(0); }   // reset black
  if (key == 'w') { background(255); } // reset white
  if (key == 's') {                    //press s to save screenshot
    save("screenshot" + int(random(9999)) + ".jpeg");   
  }
}
