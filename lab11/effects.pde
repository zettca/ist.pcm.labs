void handleEffects(String effect) {
  switch(effect) {
  case "WIPE":
    performWipe();
    break;
  case "FADE":
    performFade();
    break;
  case "DISSOLVE":
    performDissolve();
    break;
  case "CHROMA":
    performChroma();
    break;
  default:
    performWipe();
    break;
  }
}

void performWipe() {
  int numLines = int(WIDTH * transitionPercentage);

  for (int i = 0; i < WIDTH; i++) {
    for (int j = 0; j < HEIGHT; j++) {
      color c = (i > numLines) ? movie1.get(i, j) : movie2.get(i, j);
      set(i, j, c);
    }
  }
}

void performFade() {
  float fadeFactor = 1 - transitionPercentage;

  for (int i = 0; i < WIDTH; i++) {
    for (int j = 0; j < HEIGHT; j++) {
      color c = movie1.get(i, j);
      float r = red(c) * fadeFactor;
      float g = green(c) * fadeFactor;
      float b = blue(c) * fadeFactor;
      set(i, j, color(r, g, b));
    }
  }
}

void performDissolve() {
  float dF1 = transitionPercentage;
  float dF2 = 1 - dF1;

  for (int i = 0; i < WIDTH; i++) {
    for (int j = 0; j < HEIGHT; j++) {
      color c1 = movie1.get(i, j);
      color c2 = movie2.get(i, j);
      float r = red(c1) * dF2 + red(c2) * dF1;
      float g = green(c1) * dF2 + green(c2) * dF1;
      float b = blue(c1) * dF2 + blue(c2) * dF1;
      set(i, j, color(r, g, b));
    }
  }
}

float chromaDetect(color c) {
  float A = 1.0;
  float B = 1.4;

  float r = constrain(red(c), 0, 255);
  float g = constrain(green(c), 0, 255);
  float b = constrain(blue(c), 0, 255);

  return (A * (r+b)) - (B * g);
}

color chromaAdjust(color c) {
  float r = red(c);
  float g = green(c);
  float b = blue(c);
  return color(r, min(g, b), b);
}

void performChroma() {
  for (int i = 0; i < WIDTH; i++) {
    for (int j = 0; j < HEIGHT; j++) {
      color c1 = movie1.get(i, j);
      color c2 = movie2.get(i, j);

      color c = (chromaDetect(c2) < 0) ? c1 : chromaAdjust(c2);

      set(i, j, c);
    }
  }
}
