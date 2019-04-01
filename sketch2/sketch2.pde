PImage bg;
PShape owl;
String lines[];

void setup() {
  lines = loadStrings("pcm.txt");
  bg = loadImage("pcm.jpg");
  owl = loadShape("owl.svg");
  
  surface.setSize(bg.width, bg.height);
  noLoop();
}

void draw() {
  tint(0, 153, 204, 200);  // Tint blue
  image(bg, 0, 0);
  
  owl.scale(1.8); 
  shape(owl, 0, 20);
  
  fill(0);
  textSize(16);
  text(lines[0], 0, 120);
}

void mousePressed() {
  saveFrame("final.png");
}
