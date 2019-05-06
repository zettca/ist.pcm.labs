float getContrastAdjustment(float c, float contrast) {
  float cFactor = (259 * (contrast + 255)) / (255 * (259 - contrast));
  return cFactor * (c - 128) + 128;
}

color getRGBAverage(int x, int y, int radius, float contrast, float brightness) {
  float r = 0,  g = 0, b = 0;
  int num = 0;

  colorMode(RGB, 255, 255, 255);
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
  
  color c = color(r/num, g/num, b/num);
  
  if (hueValue > 0) {
    colorMode(HSB, 360, 100, 100);
    return color(hueValue, saturation(c), brightness(c));
  } else {
    colorMode(RGB, 255, 255, 255);
    return c;
  }
}

void restoreDefaults() {
  img = loadImage(imagePath);
  size = 1;
  hueValue = 0;
  contrast = 0;
  brightness = 0;
}
