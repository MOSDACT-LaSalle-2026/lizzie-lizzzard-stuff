ArrayList<Bicho> bichos = new ArrayList<Bicho>();
boolean gameOver = false;

void initializehunt() {
  gameOver = false;
  bichos.clear();
  for (int i = 0; i < 10; i++) {
    bichos.add(new Bicho());
  }
}

void huntforappointments() {
  drawBackground();

  for (int i = bichos.size() - 1; i >= 0; i--) {
    Bicho b = bichos.get(i);
    if (!b.captured) b.update();
    b.display();
  }

  if (gameOver) noLoop();
}

void revisecatches() {
  for (int i = bichos.size() - 1; i >= 0; i--) {
    Bicho b = bichos.get(i);
    if (b.isCaptured()) {
      b.captured = true;
      b.cbicho = color(255, 120, 0);
      phase = 3;
      gameOver = true;
    }
  }
}
