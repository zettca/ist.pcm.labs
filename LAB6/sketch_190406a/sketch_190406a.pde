PImage bg;
String keyPressed = "";
int defaultGray = 1;
int i = 0;

void setup() {
  bg = loadImage("PCMLab6.png");
  surface.setSize(bg.width, bg.height);
  noLoop();
  println("Hi stranger!");
  displayMenu();
}

void draw() {
  loadPixels();
  grayScale(defaultGray);  
  updatePixels();
}

void mousePressed() {
  saveFrame("final.png");
}

void keyPressed() {
  if(Character.isLetter(key)){
    println("\nError! Please select a number.");
    displayMenu();
  } else if (keyPressed.length() < 2) {
    keyPressed += "" + key;
    print(key);
    parseInput();
  } else {
    println("\n\nError! Too many arguments. Select one option and one value.");
    println("For example if I want to change the image contrast to 2 I type:  1 2");
    restartInput();
  }
}

void grayScale(int cont){
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
      
      r = (grey + 0.3) * cont;
      g = (grey + 0.59) * cont;
      b = (grey + 0.11) * cont;

      // The RGB values are constrained between 0 and 255 before being set as a new color.      
      r = constrain(r, 0, 255); 
      g = constrain(g, 0, 255);
      b = constrain(b, 0, 255);

      // Make a new color and set pixel in the window
      color c = color(r, g, b);
      pixels[loc] = c;
    }
  }
  
}

void displayMenu() {
  println("\n\nPlease choose an option below followed by the value.");
  println("1) Change the contrast.");
  println("2) Change the segmentation threshold.");
  print("-> ");
}

void parseInput() {
  if(keyPressed.length() == 2){
    int firstChar = Integer.parseInt(String.valueOf(keyPressed.charAt(0)));
    int secondChar = Integer.parseInt(String.valueOf(keyPressed.charAt(1)));
    restartInput();
    if(firstChar == 1) {
      if (secondChar >= 0 && secondChar <= 9) {
        loadPixels();
        grayScale(secondChar);
        updatePixels();
      } else {
        println("Well, I said a number. Try again.");
      }
    } else if (firstChar == 2){
      print("\nYou select the segmentation option followed by: ");
      println(secondChar);
    } else {
      println("\nUnknown option. Try again.");
    }
  }
}

void restartInput() {
  keyPressed = "";
  displayMenu();
}
