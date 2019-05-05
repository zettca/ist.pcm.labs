PImage img;
color[][] blocks = null;
int size = 1;
float contrast = 0;
float brightness = 0;

void setup() {
  img = loadImage("PCMLab9.png");
  surface.setSize(img.width, img.height);
  noLoop();
}

void draw() {
  image(img, 0, 0);
  drawImage();
}

void drawImage() {
  noStroke();
  for (int i = 0; i < img.width; i+=size) {
    for (int j = 0; j < img.height; j+=size) {
      color c = getRGBAverage(i, j, size, contrast, brightness);
      fill(c);
      square(i, j, size);
    }
  }
}

void updateImage(String type) {
  println("picture/" + type);
  //blocks = calculateBlocks(type, size);
  redraw();
}

void keyPressed() {
  switch (key) {
    case '0':
      reset();
      break;
    case '1':
      updateImage("luminance");
      break;
    case '2':
      updateImage("red");
      break;
    case '3':
      updateImage("green");
      break;
    case '4':
      updateImage("blue");
      break;
    case '5':
      updateImage("cyan");
      break;
    case '6':
      updateImage("magenta");
      break;
    case '7':
      updateImage("yellow");
      break;
    default:
      reset();
      break;
  }
}
