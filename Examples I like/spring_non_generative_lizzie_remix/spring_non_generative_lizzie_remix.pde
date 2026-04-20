/*
Name: Payaso 02 (Clown 02)
 Second version of the "payaso" sketch that uses the oscillations
 of the sine values and the concept of pushMatrix and popMatrix to stack and unstack.
 Date: March 2009, Barcelona.
 Author: Alba G. Corral.
 License: open source.
 */
/*
Non generative -
 It is when an artist takes direct control over the process.
 An artist that chooses to constrain themselves by only working with white and using that to determine the pixel's color would not be incorporating an autonomous system into their work.
 This practice would not be generative because the "system" that chose the color was the brain of the artist and not external; the artist maintained control throughout.
 */
float velocidad = 0.05;// angle increment (speed)
float dim;// diameter
float RESISTENCIA ;
float NUM_TALLOS = 15;
int longitud ;
float inc= 0.1;
void setup() {
  size(800, 800);// sketch size
  dim = width/10;// diameter
  longitud=width/2;// length
  RESISTENCIA = width/300;
  smooth();// smoothing / antialiasing
  background(255);// paint the background white
}
void draw() {
  //background(255);// paint the background white
  //this is cause pasjfkjlskfjalkfs
  translate(width/2, height/2);// move the coordinates to the middle of the screen
  inc += velocidad;// increase the radius value
  float angle = sin(inc) / RESISTENCIA;// calculate the angle
  //draws an ellipse with width > dim and height > dim. at coordinate position 0,0

  for (int i = 0; i < NUM_TALLOS; i++) {// loop from 0 to NUM_TALLOS, increasing by 1
    //call the "tallo" (stem) function with input parameters
    //float x> horizontal position, float y> vertical position, int length, float angle> angle
    tallo(0, -dim, longitud, angle);
    rotate(TWO_PI/NUM_TALLOS);// rotate
  }
  ellipse(0, 0, angle, angle);
 // if (velocidad > 10) inc = inc * -1;;
   

}
void tallo(float x, float y, int longitud, float angle) {
  pushMatrix();
  translate(x, y);
  for (int i = longitud; i > 0; i--) {
    strokeWeight(i/150);
    stroke(0, 10);// select the stroke color > 255, white (actually black here: 0)
    line(0, 0, 0, -4);// draw a line from (0,0) to (0,-4)
    strokeWeight(i/100);// stroke width
    stroke(255, 0, 0, 2);
    line(0, 0, -10, 0);// draw a line from (0,0) to (-10,0)

    translate(0, -4);
    rotate(angle);
  }
  popMatrix();
}
