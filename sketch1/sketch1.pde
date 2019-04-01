void setup() {
  size(200, 200);
  background(64, 64, 64);
  stroke(255, 255, 255);
  fill(200, 200, 200);
}

void draw() {
  line(50, 50, 150, 150);
  ellipse(50, 50, 50, 50);
}

void mousePressed() {
  saveFrame("outputFinal.png");
}
