//landscape project for creative coding

size(900, 950);
background(#B5CBE4);


noStroke();  // water
fill(#1F3D63);
beginShape();  
vertex(0, 600);
vertex(900, 600);
vertex(900, 950);
vertex(0, 950);
endShape();


noStroke();  // pink wall left 1
fill(#F2B5C0);
beginShape();  
vertex(0, 0);
vertex(600, 0);
vertex(600, 726);
vertex(0, 750);
endShape();


noStroke();  // shadow on wall left 
fill(#8B3A5A);
beginShape();  
vertex(0, 0);
vertex(600, 0);
vertex(151, 356);
vertex(151, 746);
vertex(0, 750);
endShape();


noStroke();  // floor base
fill(#E8849A);
beginShape();  
vertex(0, 750);
vertex(600, 725);
vertex(900, 835);
vertex(900, 950);
vertex(0, 950);
endShape();


noStroke();  // wall right
fill(#5C2040);
beginShape();  
vertex(600, 0);
vertex(900, 0);
vertex(900, 835);
vertex(800, 798);
vertex(800, 0);
endShape();


noStroke();  // floor shadow
fill(#8B3A5A,200);
beginShape();  
vertex(0, 750);
vertex(151, 743);
vertex(800, 798);
vertex(900, 835);
vertex(900, 950);
vertex(0, 950);
endShape();


//  moon 
fill(#FFFFFF);
noStroke();
ellipse(750, 150, 50, 50);

// cutout circle (use background color)
fill(#B5CBE4);
ellipse(755, 147, 48, 48);


// window shape outline litht color
fill(#E8849A); 
noStroke();

// rectangle body (bottom part)
rect(420, 360, 120, 210);

// circle top (same color, sits on top of rect)
circle(480, 360, 120);




// Arch / window shape INSIDE - background blue color
fill(#B5CBE4);
noStroke();

// rectangle body (bottom part)
rect(420, 350, 100, 200);

// circle top (same color, sits on top of rect)
circle(470, 350, 100);



noStroke();  // windlow sill highlight
fill(#FBE8ED,200);
beginShape();  
vertex(420, 550);
vertex(450, 550);
vertex(540, 570);
vertex(420, 570);
endShape();
