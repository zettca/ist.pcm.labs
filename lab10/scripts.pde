int[] calculateHistogram() {
  int[] histogram = new int[256];
  for (int i = 0; i < myMovie.height; i+=1) {
    for (int j = 0; j < myMovie.width; j+=1) {
      float b = brightness(get(i, j));
      int pos = constrain(int(b), 0, 255);
      histogram[pos]++;
    }
  }
  return histogram;
}

void handleTransitionDetection() {
  diffSum = 0;
  for (int i = 0; i < 256; i++) {
    diffSum += sqrt(pow(histBefore[i] - histCurrent[i], 2));
  }

  if (diffSum > 0) println(diffSum);

  if (diffSum > THRESHOLD) {
    saveFrame(outputDir + "2_frames/" + frameNum);
    transitionWriter.print(String.format("%d\t%f\n", frameNum, myMovie.time()));
  }

  histWriter.print(String.format("%d\t%d\t%d\t%d\n", frameNum, diffSum, TS, TB));
}

void handleTwinTransitionDetection() {
  if (diffSum > TB) { // transition  confirmation
    saveFrame(outputDir + "3_frames/" + frameNum);
    twinWriter.print(String.format("%d\t%f\n", frameNum, myMovie.time()));
  } else if (diffSum < TS) { // no transition
    return;
  }
}

void closeEverything() {
  println("Done. Flushing/Closing everything.");

  segmentationWriter.flush();
  segmentationWriter.close();
  transitionWriter.flush();
  transitionWriter.close();
  twinWriter.flush();
  twinWriter.close();
  histWriter.flush();
  histWriter.close();

  exit();
}
