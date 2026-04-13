int posx = 0;
float posy = 0;
float posx2 = 0;
float posy2 = 0;
float posx3 = 0;
float posy3 = 0;
float time = 0;
float diam = 1;


// Color for the first circle 1 fill
float red_val   = random(0, 255);
float green_val = random(0, 255);
float blue_val  = random(0, 255);


void setup(){
  size(700,900);
    background(0);
}

void draw(){
  
      // fade out 
  fill(0,10);
  rect(0,0, width, height);
  
      //circle 1 moving to the right
      
  fill(red_val,green_val,blue_val);
  noStroke();
  posy = 350 + random(-50, 50);
  circle(posx, posy, 23);
  posx = posx + 5;
  
  if(posx > width){
    posx = 0;
    red_val   = random(0, 255);
    green_val = random(0, 255);
    blue_val  = random(0, 255);
  }
  
  // circle 2 
  fill(255,123,0);
  posy2 = 100 + 50*sin(0.1*time);   //HARMONIC WAVE SHAPE
  circle(posx2, posy2, diam);
  diam = diam + 1 ;
  posx2 = posx2 + 5;
  
  if(posx2 > width){
    posx2 = 0;
    diam = 0;
  }
  
  
  
  // CIRCLE 3 
  fill(red_val,green_val,blue_val);
  posy3 = 2*50*noise(0.1+time);          //making a bit of shake to the movement - NOISE 
                                      // NOISE is just up and down movement 
  
  circle(posx3, posy3 + 700, diam);
  diam = diam + 1 ;
  posx3 = posx3 + 2;
  print(posx3);
  print("\n");
 if(posx3 > width){
    posx3 = 0;
    diam = 0;
 
 }
  
time = time + 1;     // it doesnt depend on the if, it doens't need to reset 

}    // End of drawing
