PImage cloud1;
PImage cloud2;
PImage cloud3;
PImage mush1;
PImage mush2;
PImage butter1;
PImage bird1;

float posx = 900;
float posy = 0;
float time = 0;

int countf = 0;    // counts how many frames are saved 


//num_butter = 10



void setup() {
  size(700, 900);
  cloud1 = loadImage("cloud coding.png");
  cloud2 = loadImage("cloud2.png");
  cloud3 = loadImage("cloud3.png");
  mush1 = loadImage("mush1.png");
  mush2 = loadImage("mush2.png");
  bird1 = loadImage("bird1.png");
  butter1 = loadImage("butter1.png");

  imageMode(CENTER);
  background(#B7E7F6);
  frameRate(9);
}


void draw() {

  fill(220, 200, 20);
  stroke(255, 120, 0);
  strokeWeight(3);
  // image(cloud2, 30, 100);
  // image(cloud3, 350, 450);
  // image(cloud1, 100, 100, cloud1.width/4,cloud1.height/4);

  //tint(255,0,0, 10);
  //image(cloud1, mouseX , mouseY , 90,200);


  if (frameCount % 18 == 0) {   // clouds every 18 frames (2 seconds)
    image(cloud1, random(0, 700), random(0, 400), 110, 200);
  }

  image(mush1, random(0, 700), random(400, 900), random(100, 150), random(100, 300));
  image(mush2, random(0, 700), random(500, 900), random(20, 100), random(80, 130));

  // only stamp butter1 every 1 second - frameRate is 9, so 9 frames = 1 second
  if (frameCount % 9 == 0) {
    image(butter1, random(0, 700), random(200, 500), random(100, 150), random(100, 200));
  }
  if (frameCount % 5 == 0) {   // every 5 frames
    image(butter1, random(0, 700), random(10, 600), random(10, 80), random(40, 60));   // smaller butterflies
  }

  pushMatrix();
  rotate(radians(20));
  posy = 200 + 20*sin(0.1*time);
  tint(255,255,255,80);
  image(bird1, posx, posy, 100, 100);
  tint(255,255,255,255);
  posx = posx - 5;
  popMatrix();
  if (posx <= 0) {
    posx = 900;
  }

  time = time + 1;
  
  if(countf < 200){
    saveFrame("screenshots#####.png");
    countf = countf + 1 ;
  }
  
  
}


void keyPressed() {      // press r to reset canvas
  if (key == 'r') {
    background(#B7E7F6);
  }


  if (key == '1') {        // press 1 to stamp cloud 1
    image(cloud1, mouseX, mouseY, 90, 200);
  }

  if (key == '2') {      // press 2 to stamp cloud 2
    image(cloud2, mouseX, mouseY, cloud1.width/4, cloud1.height/4);
  }
}
