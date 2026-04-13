
void mousePressed() { noLoop(); }
void mouseReleased() { loop(); }
void keyPressed() {
  if (key == 'r' || key == 'R') restart();
  if (key == 's' || key == 'S') saveFrame("gaudi_star-####.png");
}
