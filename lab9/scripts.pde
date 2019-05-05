float getContrastAdjustment(float c, float contrast) {
  float cFactor = (259 * (contrast + 255)) / (255 * (259 - contrast));
  return cFactor * (c - 128) + 128;
}

color getRGBAverage(int x, int y, int radius, float contrast, float brightness) {
  float r = 0,  g = 0, b = 0;
  int num = 0;

  for (int i = x - radius; i < x + radius; i++) {
    for (int j = y - radius; j < y + radius; j++) {
      if (i < 0 || i >= width || j < 0 || j >= height) continue;
      if (dist(x, y, i, j) > r) continue;

      color c = img.get(i, j);
      r += getContrastAdjustment(red(c), contrast) + brightness;
      g += getContrastAdjustment(green(c), contrast) + brightness;
      b += getContrastAdjustment(blue(c), contrast) + brightness;
      num++;
    }
  }

  return color(r/num, g/num, b/num);
}
