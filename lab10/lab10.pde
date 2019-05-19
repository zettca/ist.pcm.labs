import processing.video.*;

Movie myMovie;

PrintWriter segmentationWriter, transitionWriter, twinWriter, histWriter;

String outputDir = "output/";
String movieFullPath = "PCMLab10.mov";

int frameNum = 0;
int frameJump = 20;
int[] hist = new int[256];
int[] histBefore = new int[256];
int[] histCurrent = new int[256];

int diffSum = 0;

int THRESHOLD = 110 * 1000;
int TS = 80 * 1000;
int TB = THRESHOLD;

void setup() {
  segmentationWriter = createWriter(outputDir + "1.txt");
  transitionWriter = createWriter(outputDir + "2.txt");
  twinWriter = createWriter(outputDir + "3.txt");
  histWriter = createWriter(outputDir + "4.txt");

  size(960, 540);
  myMovie = new Movie(this, movieFullPath);
  myMovie.loop();
}

void draw() {
  image(myMovie, 0, 0);

  if (frameNum % frameJump == 0) { // 1.
    saveFrame(outputDir + "1_frames/" + frameNum);
    segmentationWriter.print(String.format("%d\t%f\n", frameNum, myMovie.time()));
  }

  if (frameNum == 0) {
    hist = calculateHistogram();
    histBefore = hist;
  } else {
    histCurrent = calculateHistogram();

    handleTransitionDetection(); // 2. and 4.
    handleTwinTransitionDetection(); // 3.

    histBefore = histCurrent;
  }

  if (myMovie.time() == myMovie.duration()) {
    closeEverything();
  }

  frameNum++;
}

void movieEvent(Movie m) {
  m.read();
}
