int getPos(color c, String type) {
  switch (type) {
    case "luminance":
      return int(brightness(c));
    case "red":
      return int(red(c));
    case "green":
      return int(green(c));
    case "blue":
      return int(blue(c));
    case "cyan":
      return 255 - int(red(c));
    case "magenta":
      return 255 - int(green(c));
    case "yellow":
      return 255 - int(blue(c));
    default:
      return int(brightness(c));
  }
}

ArrayList<IntList> calculateHistogram(String type) {
  int SIZE = 256;
  ArrayList<IntList> colors = new ArrayList<IntList>(SIZE);
  for (int i = 0; i < SIZE; i++) colors.add(new IntList());
  
  for (int i = 0; i < img.width; i++) {
    for (int j = 0; j < img.height; j++) {
      color c = get(i, j);
      int pos = getPos(c, type);
      IntList il = colors.get(pos);
      il.append(c);
    }
  }
  
  for (int i = 0; i < SIZE; i++) {
    IntList il = colors.get(i);
    il.sort();
  }

  return colors;
}
