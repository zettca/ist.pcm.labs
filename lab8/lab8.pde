PImage img;
ArrayList<IntList> hist = null;

void setup() {
  img = loadImage("flower.png");
  surface.setSize(img.width, img.height);
  noLoop();
}

void drawHistogram() {
  if (hist == null) return;
  
  float histMax = 0;
  for (int i = 0; i < hist.size(); i++) {
    int l = hist.get(i).size();
    if (l > histMax) histMax = l;
  }
  
  for (int i = 0; i < img.width; i++) {
    int which = int(map(i, 0, img.width, 0, 255));
    int y = int(map(hist.get(which).size(), 0, histMax, img.height, 0));
    stroke(i);
    line(i, img.height, i, y);
  }
}

void draw() {
  image(img, 0, 0);
  drawHistogram();
}

void updateHistogram(String type) {
  println("histograms/" + type);
  hist = calculateHistogram(type);
  redraw();
  saveFrame("histograms/"+type+".png");
}

void reset() {
  hist = null;
  redraw();
}

void keyPressed() {
  switch (key) {
    case '0':
      reset();
      break;
    case '1':
      updateHistogram("luminance");
      break;
    case '2':
      updateHistogram("red");
      break;
    case '3':
      updateHistogram("green");
      break;
    case '4':
      updateHistogram("blue");
      break;
    default:
      reset();
      break;
  }
}
