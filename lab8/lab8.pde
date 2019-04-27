PImage bg;
String c = "gray";
int[] hist;

void setup() {
  bg = loadImage("PCMLab8.png");

  surface.setSize(bg.width, bg.height);
  noLoop();
}

int[] calculateLuminanceHistogram() {
  int[] hist = new int[256];
  
  for (int i = 0; i < bg.width; i++) {
    for (int j = 0; j < bg.height; j++) {
      int b = int(brightness(get(i, j)));
      hist[b]++;
    }
  }

  return hist;

}

int[][] calculateColorHistograms() {
  int[][] hists = new int[3][256];
  
  for (int i = 0; i < bg.width; i++) {
    for (int j = 0; j < bg.height; j++) {
      hists[0][int(red(get(i, j)))]++;
      hists[1][int(green(get(i, j)))]++;
      hists[2][int(blue(get(i, j)))]++;
    }
  }
  
  return hists;
}

void drawHistogram() {
  if (hist == null) return;
  
  for (int i = 0; i < bg.width; i++) {
    int which = int(map(i, 0, bg.width, 0, 255));
    int y = int(map(hist[which], 0, max(hist), bg.height, 0));
    if (c == "gray") stroke(i);
    else if (c == "red") stroke(i, 0, 0);
    else if (c == "green") stroke(0, i, 0);
    else if (c == "blue") stroke(0, 0, i);
    line(i, bg.height, i, y);
  }
}

void draw() {
  image(bg, 0, 0);
  drawHistogram();
}

void keyPressed() {
  switch (key) {
    case '1':
      println("histograms/luminance");
      c = "gray";
      hist = calculateLuminanceHistogram();
      redraw();
      saveFrame("histograms/luminance.png");
      break;
    case '2':
      println("histograms/red");
      c = "red";
      hist = calculateColorHistograms()[0];
      redraw();
      saveFrame("histograms/red.png");
      break;
    case '3':
      println("histograms/green");
      c = "green";
      hist = calculateColorHistograms()[1];
      redraw();
      saveFrame("histograms/green.png");
      break;
    case '4':
      println("histograms/blue");
      c = "blue";
      hist = calculateColorHistograms()[2];
      redraw();
      saveFrame("histograms/blue.png");
      break;
  }
}

void mousePressed() {
  if (hist == null) return;
  
  println("saving histograms...");

  hist = calculateLuminanceHistogram();
  redraw();
  saveFrame("histograms/luminance.png");
  
  hist = calculateColorHistograms()[0];
  redraw();
  saveFrame("histograms/red.png");
  
  hist = calculateColorHistograms()[1];
  redraw();
  saveFrame("histograms/green.png");
  
  hist = calculateColorHistograms()[2];
  redraw();
  saveFrame("histograms/blue.png");
}
