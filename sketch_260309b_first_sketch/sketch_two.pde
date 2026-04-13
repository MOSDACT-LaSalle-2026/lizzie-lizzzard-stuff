size(600,600);
background(#caf0f8);

fill(#450920);
triangle(0,0,0,600,300,600);


fill(#e4c1f9,90);
triangle(0,600,600,0,600,600);


fill(#414833,90);
triangle(600,0,0,300,600,600);

fill(#da627d,240);
beginShape();
vertex(100, 80);
vertex(120, 80);
vertex(150, 130);
vertex(180, 80);
vertex(200, 80);
vertex(200, 300);
vertex(180, 300);
vertex(180, 150);
vertex(150, 200);
vertex(120, 150);
vertex(120, 300);
vertex(100, 300);
vertex(100, 80);
endShape();

fill(random(0,255), 200, random(0,255));
beginShape();
curveVertex(336,  80);
curveVertex(336,  80);
curveVertex(500,  120);
curveVertex(520,  370);
curveVertex(336, 400);
curveVertex(336, 400);

endShape(CLOSE);
