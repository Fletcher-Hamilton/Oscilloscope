// Fletcher Hamilton

float period = 200;
float amplitude = 100;
float theta = 0;
float dx, cSize, sliderY;
float[] yvalues;
int precision = 10;
int oWidth;

void setup() {
  size(2000, 1000);
  dx = TWO_PI / period;  // period = 200 at default
  oWidth = int(width*.8); // size of display screen (%)
  cSize = width-oWidth;
  yvalues = new float[oWidth];
  
  sliderY = height/25;
}

void draw() {
  background(0);

  // Horizontal centre line (0 V)
  stroke(255);
  strokeWeight(2);
  line(0, height/2, oWidth, height/2);

  // Right side of display screen
  line(oWidth, 0, oWidth, height);

  // Incremental lines that go up and down vertically
  strokeWeight(.5);
  for (int p=0; p<=oWidth; p+=height/precision) line(0, p, oWidth, p);
  
  // Slider for period
  if (mouseX >= oWidth+cSize/3 && mouseX <= oWidth+cSize*2/3 && mouseY >= )
  
  fill(255);
  strokeWeight(3);
  line(oWidth+cSize/2, height/25, oWidth+cSize/2, height/4);
  circle(oWidth+cSize/2, sliderY, 15);

  // Sine wave
  calcWave();
  stroke(#befdb7);
  strokeWeight(2);
  noFill();
  beginShape();
  for (int i = 0; i < yvalues.length; i++) {
    vertex(i, height / 2 + yvalues[i]);
  }
  endShape();
}

void calcWave() {
  theta += 0.02;
  float x = theta;
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = sin(x) * amplitude;
    x += dx;
  }
}
