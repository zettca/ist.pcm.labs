PImage img;
ArrayList<IntList> hist = null;

void setup() {
  img = loadImage("PCMLab8.png");
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
    IntList il = hist.get(which);
    int ilsize = il.size();
    int yMin = int(map(ilsize, 0, histMax, img.height, 0));
    
    //println(i, yMin, ilsize, img.height - yMin);
    for (int j = 0; j < il.size(); j+=2) {
      int y = yMin + int((j/float(ilsize)) * (img.height - yMin));
      stroke(color(il.get(j)));
      point(i, y);
    }
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
