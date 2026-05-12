// Fletcher Hamilton

float input, lineY;
color line = #BEFDB7;

size(2000, 1000);
background(0);

stroke(255);
line(0, height/2, width, height/2);
fill(line);
stroke(line);
strokeWeight(5);

while (true) {
  for (int i = 0; i <= width; i++) {
    input = random(-10, 10);
    lineY = map(input, -10, 10, height, 0);
    circle(i, lineY, 1);
  }
  background(0);
  //if (0 == width + 1) break;
}

// Sine wave parameters
float amplitude = 100;   // Height of wave
float period = 200;      // Number of pixels before wave repeats
float phase = 0;         // Horizontal shift (for animation)
float speed = 0.05f;     // Speed of wave movement

void calcWave() {
  // Increment theta (try different values for 'angular velocity' here
  theta += 0.02;

  // For every x value, calculate a y value with sine function
  float x = theta;
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = sin(x)*amplitude;
    x+=dx;
  }
}
