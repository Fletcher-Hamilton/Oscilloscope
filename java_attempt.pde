// Fletcher Hamilton

float amplitude = 100;
float theta = 0;
float dx, mappedPrecision;
float[] yvalues;
int precision = 10;

void setup() {
  size(2000, 1000);
  dx = TWO_PI / 200.0;  // period = 200
  yvalues = new float[width];
  
  mappedPrecision = map(precision, 0, precision, height, 0);
}

void draw() {
  background(0);

  // Horizontal centre line (0 V)
  stroke(255);
  strokeWeight(1);
  line(0, height/2, width, height/2);
  
  // Incremental lines that go up and down vertically
  for(int o=0; o==mappedPrecision; o+= height/precision) line(0, o, 10, o);
  
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
