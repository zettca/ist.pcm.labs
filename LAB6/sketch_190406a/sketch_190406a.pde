PImage bg;
color gray = color(0.3*255, 0.59*255, 0.11*255);

void setup() {
  bg = loadImage("PCMLab6.png");
  surface.setSize(bg.width, bg.height);
  noLoop();
}

void draw() {
  loadPixels();
  bg.loadPixels();
  image(bg, 0, 0);
  // We must also call loadPixels() on the PImage since we are going to read its pixels.  img.loadPixels(); 
  for (int x = 0; x < bg.width; x++ ) {
    for (int y = 0; y < bg.height; y++ ) {
          
      // Calculate the 1D pixel location
      int loc = x + y*bg.width;
    
      // Get the R,G,B values from image
      float r = red  (bg.pixels[loc]);
      float g = green(bg.pixels[loc]);
      float b = blue (bg.pixels[loc]);
      int grey = (int)(r+g+b)/3;
      
      r = grey + 0.3;
      g = grey + 0.59;
      b = grey + 0.11;

      // The RGB values are constrained between 0 and 255 before being set as a new color.      
      r = constrain(r, 0, 255); 
      g = constrain(g, 0, 255);
      b = constrain(b, 0, 255);

      // Make a new color and set pixel in the window
      color c = color(r, g, b);
      pixels[loc] = c;
      
    }
  }
  
  updatePixels();
}

void mousePressed() {
  saveFrame("final.png");
}
