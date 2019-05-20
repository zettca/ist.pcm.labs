import processing.video.*;

Movie movie1, movie2;

final int WIDTH = 960;
final int HEIGHT = 540;
final float TRANSITION_INCREMENT = 0.01;

float transitionPercentage = 0;

String effect = "CHROMA";

void settings() {
  size(WIDTH, HEIGHT);
}

void setup() {
  String pathMovie1 = dataPath("PCMLab11-1.mov"); // 320x240@15fps
  String pathMovie2 = dataPath("PCMLab11-2.mov"); // 960x540@30fps

  movie1 = new Movie(this, pathMovie1);
  movie2 = new Movie(this, pathMovie2);

  movie1.loop();
  movie1.volume(0);
  movie2.loop();
  movie2.volume(0);
}

void draw() {
  image(movie1, 0, 0, WIDTH, HEIGHT);

  handleEffects(effect);

  if (transitionPercentage >= 1) {
    transitionPercentage = 1;
    //movie = movie2;
  } else if (transitionPercentage > 0) {
    transitionPercentage += TRANSITION_INCREMENT;
  }
}

void movieEvent(Movie m) {
  m.read();
}

void keyPressed() {
  switch (key) {
  case '1':
    effect = "WIPE";
    break;
  case '2':
    effect = "FADE";
    break;
  case '3':
    effect = "DISSOLVE";
    break;
  case '4':
    effect = "CHROMA";
    break;
  default:
    break;
  }

  transitionPercentage = TRANSITION_INCREMENT; // init transition
}
