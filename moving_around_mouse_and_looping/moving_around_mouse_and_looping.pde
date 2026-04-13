int diam = 12;    //integer 




void setup(){
  size(700, 700);  
  frameRate(30); //30 frames per second
  background(0);

}


void draw(){
  
fill(random(0, 2550), random(0, 250), random(0, 2555), random(0,255));  strokeWeight(7);
  strokeWeight(1);
  stroke(0,100,120);
  rectMode(CENTER);
  translate(mouseX, mouseY); //position
  //rotate(radians(random(3,360)));
  square(0,0,diam);
  
  resetMatrix();
  fill(random(0,100), random(50,200),random(0,200), 8);
  translate(random(0,700),random(0,700));
  circle(0,0, random(4,20));
  
}

void keyPressed(){
  if(key == 'x'){          //press x to make black canvas
  background(0);
  }
  
    if(key == 'c'){          //press c to make white canvas
  background(255);
  }

 if(key == 'z'){          //press z to randomly change the canvas color
  background(random(20,255), random(0,24), random(0,200));
  }
  
  
  if(key == 'q'){      // q to pause the loop
    noLoop();
  }
  
  
  if(key == 'w'){      //w to resume the loop
    loop();
  }
  
  if(key == 'p'){
    diam = 18;
  }
  
  if(key == 'o'){
    diam = 250;
  }
  
  
 if(key == '1'){      //to make it grow bigger hold down 1
   diam = diam + 1;
 }
 
  if(key == '2'){      //to make it grow smaller hold down 2
   diam = diam - 1;
   if(diam < 0){    // to make it not go below 0 diameter 
     diam = 1;
     
   } // 
 } // end of making circle smaller
 
 
 
 
 
 if(key == ' '){            //press spacebar to save a jpeg
   save("screenshot" + random(2000) + ".jpeg");    //this will make it not override
 }
 
 
 
 
 
 
 
} // end of keyPressed EVENTS
