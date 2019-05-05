PImage img;
color[][] blocks = null;
int size = 1;
float contrast = 0;
float brightness = 100;

void setup() {
  img = loadImage("PCMLab9.png");
  surface.setSize(img.width, img.height);
  noLoop();
  noStroke();
}

void draw() {
  image(img, 0, 0);
  drawImage();
}

void reset() {
  blocks = null;
  redraw();
}

void drawImage() {
  for (int i = 0; i < img.width; i+=size) {
    for (int j = 0; j < img.height; j+=size) {
      color c = getRGBAverage(i, j, size, contrast, brightness);
      fill(c);
      square(i, j, size);
    }
  }
}
