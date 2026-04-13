size (700, 700);
  
background(#001529);

fill(#BDE0FE);
strokeWeight(7);
stroke(0,100,120);
rectMode(CENTER);
translate(350,350);
rotate(radians(10));
square(0,0, 234);

rotate(radians(10));
square(0,0, 234);
rotate(radians(10));
square(0,0, 234);
rotate(radians(10));
square(0,0, 234);
rotate(radians(10));
square(0,0, 234);
rotate(radians(10));
square(0,0, 234);
rotate(radians(10));
square(0,0, 234);

//makeing the crosses in each corner - top left
resetMatrix();
fill(#FFAFCC);
strokeWeight(3);
stroke(0,100,120);
rectMode(CENTER);
translate(100,100);
rotate(radians(45));
rect(0,0,50,50);
rect(0,0, 20, 120);
rotate(radians(90));
rect(0,0, 20, 120);
fill(#FF5C9A);
circle(0,0,30);

//top right
resetMatrix();
fill(#FFAFCC);
strokeWeight(3);
stroke(0,100,120);
rectMode(CENTER);
translate(600,100);

rotate(radians(45));
rect(0,0,50,50);
rect(0,0, 20, 120);

rotate(radians(90));
rect(0,0, 20, 120);
fill(#FF5C9A);
circle(0,0,30);

//bottom right
resetMatrix();
fill(#FFAFCC);
strokeWeight(3);
stroke(0,100,120);
rectMode(CENTER);
translate(600,600);

rotate(radians(45));
rect(0,0,50,50);
rect(0,0, 20, 120);
rotate(radians(90));
rect(0,0, 20, 120);
fill(#FF5C9A);
circle(0,0,30);


//bottom left
resetMatrix();
fill(#FFAFCC);
strokeWeight(3);
stroke(0,100,120);
rectMode(CENTER);
translate(100,600);

rotate(radians(45));
rect(0,0,50,50);
rect(0,0, 20, 120);
rotate(radians(90));
rect(0,0, 20, 120);
fill(#FF5C9A);
circle(0,0,30);
