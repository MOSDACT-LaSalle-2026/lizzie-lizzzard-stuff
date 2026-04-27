//hunt game

ArrayList<Bicho> bichos = new ArrayList<Bicho>();
boolean gameOver = false;   // boolean to mark a catch
boolean catchedbug = false;


void initialdrawingcharacters() {
  
  image(bichos.get(0).ibicho, 340, 540, bichos.get(0).r*2, bichos.get(0).r*2);
  image(bichos.get(1).ibicho, 450, 540, bichos.get(1).r*2, bichos.get(1).r*2);
  image(bichos.get(2).ibicho, 450, 610, bichos.get(2).r*2, bichos.get(2).r*2);
  
  image(bichos.get(3).ibicho, 900, 540, bichos.get(3).r*2, bichos.get(3).r*2);
  image(bichos.get(4).ibicho, 1010, 540, bichos.get(4).r*2, bichos.get(4).r*2);
  image(bichos.get(5).ibicho, 900, 610, bichos.get(5).r*2, bichos.get(5).r*2);

  image(bichos.get(6).ibicho, 450, 380, bichos.get(6).r*2, bichos.get(6).r*2);
  image(bichos.get(7).ibicho, 570, 380, bichos.get(7).r*2, bichos.get(7).r*2);
  image(bichos.get(8).ibicho, 670, 380, bichos.get(8).r*2, bichos.get(8).r*2);
  image(bichos.get(9).ibicho, 790, 380, bichos.get(9).r*2, bichos.get(9).r*2);
  image(bichos.get(10).ibicho, 900, 380, bichos.get(10).r*2, bichos.get(10).r*2);

  image(bichos.get(11).ibicho, 670, 460, bichos.get(11).r*2, bichos.get(11).r*2);

}

void initializehunt() {
  gameOver = false;
  catchedbug = false;

  for (int i = bichos.size() - 1; i >= 0; i--) 
    bichos.remove(i);  
  for (int i = 0; i < 12; i++) 
    bichos.add(new Bicho());

  for (int i = 0; i < bichos.size(); i++) 
    bichos.get(i).ibicho = loadImage(i + ".png");
}

void huntforappointments() {
  drawBackground();
  
  for (int i = bichos.size() - 1; i >= 0; i--) {
    Bicho b = bichos.get(i);

    // delete non captured bugs
    if (!b.captured && b.dead) {
      bichos.remove(i);
      continue;
    }

    // don't move if there was a catch
    if (!b.captured) {
      b.update();
    }

    b.display();
  }

  if (bichos.size() == 0) {
    gameOver = true;
    phase = 6;
  }

  if (gameOver) noLoop();
  
}

void revisecatches() {
  for (int i = bichos.size() - 1; i >= 0; i--) {
    Bicho b = bichos.get(i);
    if (b.isCaptured()) {
      b.captured = true;

      catchedbug = true;
      phase = 4;

      gameOver = true;   // GAMEOVER
    }
  }
  
}
