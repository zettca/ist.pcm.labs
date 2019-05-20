import processing.video.*;

Movie movie, movie1, movie2;

final int WIDTH = 960;
final int HEIGHT = 540;
final float TRANSITION_INCREMENT = 0.01;

float transitionPercentage = 0;

String effect = "CHROMA";

void settings() {
  size(WIDTH, HEIGHT);
}

void setup() {
  String pathMovie1 = dataPath("sample.mp4"); // 320x240@15fps
  String pathMovie2 = dataPath("PCMLab11-2.mov"); // 960x540@30fps

  movie1 = new Movie(this, pathMovie1);
  movie2 = new Movie(this, pathMovie2);

  movie1.loop();
  movie1.volume(0);
  movie2.loop();
  movie2.volume(0);

  movie = movie1;
}

void draw() {
  image(movie, 0, 0, WIDTH, HEIGHT);

  handleEffects(effect);

  if (transitionPercentage >= 1) {
    transitionPercentage = 1;
    //movie = movie2;
  } else if (transitionPercentage > 0) {
    transitionPercentage += TRANSITION_INCREMENT;
  }
}

void mouseClicked() {
  transitionPercentage = TRANSITION_INCREMENT; // init transition
}

void movieEvent(Movie m) {
  m.read();
}

void handleEffects(String effect) {
  switch(effect) {
  case "WIPE":
    performWipe();
    break;
  case "FADE":
    performFade();
    break;
  case "DISSOLVE":
    performDissolve();
    break;
  case "CHROMA":
    performChroma();
    break;
  default:
    performWipe();
    break;
  }
}
