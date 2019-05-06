PImage img;

int size = 1;

int hueValue = 0;

float contrast = 0;
float brightness = 0;

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

void restoreDefaults() {
  size = 1;
  hueValue = 0;
  contrast = 0;
  brightness = 0;
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

void keyPressed() {
  switch (key) {
    case 'p':
      size *= 2;
      break;
    case 'h':
      hueValue += 20;
      break;
    case 'c':
      contrast += 20;
      break;
    case 'v':
      contrast -= 20;
      break;
    case 'b':
      brightness += 20;
      break;
    case 'n':
      brightness -= 20;
      break;
    case '0':
      restoreDefaults();
      break;
    default:
      break;
  }
  
  redraw();
}
