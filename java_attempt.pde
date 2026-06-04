// Fletcher Hamilton

float amplitude = 100;
float theta = 0;
float pulseTime = 0.5; // 0 -> 1 (% of time pulsing) // this means 0.5 = square wave
float dx, cSize, sSliderY, fSliderY, aSliderY, pSliderY, period, sPeriod, pMax;
float[] yvalues;
int gridSize = 10;
int maxFocus = 1000;
int oWidth;
boolean h = false;
PImage milkyWayBg;
char waveType;

void setup() {
  fullScreen();
  textSize(25);
  textAlign(CENTER);

  
  oWidth = int(width*.8); // size of display screen (% decimal)
  dx = TWO_PI / period;  // period = 200 at default
  sSliderY = height/5;
  fSliderY = height/5;
  aSliderY = height*3/4;
  pSliderY = height/5;
  
  waveType = 'u'; // Second letter in the name (since sine, square, and sawtooth would all be the same 's')

  milkyWayBg = loadImage("milkyWay.png");
}

void draw() {
  if (width < displayWidth | height < displayHeight) image(milkyWayBg, 0, 0, displayWidth, displayHeight);

  cSize = width-oWidth;
  yvalues = new float[oWidth];

  noStroke();
  fill(0);
  rect(0, 0, width, height);

  // Horizontal centre line (0 V)
  stroke(255);
  strokeWeight(2);
  line(0, height/2, oWidth, height/2);

  // Right side of display screen
  line(oWidth, 0, oWidth, height);

  // Incremental lines that go up and down vertically
  strokeWeight(.5);
  for (int p=0; p<=height; p+=height/gridSize) line(0, p, oWidth, p);

  // General slider setup
  fill(255);
  strokeWeight(3);

  // Slider for broader focus (focus slider)
  line(oWidth+cSize/4, height/10, oWidth+cSize/4, height/3);
  circle(oWidth+cSize/4, fSliderY, 15);

  // Logic for focus slider
  pMax = map(fSliderY, height/10, height/3, 201, maxFocus);

  // Slider for period (precision slider)
  line(oWidth+cSize/2, height/10, oWidth+cSize/2, height/3);
  circle(oWidth+cSize/2, pSliderY, 15);
  
  // Logic for precision slider
  period = map(pSliderY, height/10, height/3, pMax-200, pMax*10);

  // Slider for small change in period (Super precision slider)
  line(oWidth+cSize*3/4, height/10, oWidth+cSize*3/4, height/3);
  circle(oWidth+cSize*3/4, sSliderY, 15);

  // Logic for super precision slider
  sPeriod = map(sSliderY, height/10, height/3, pMax-200, pMax);
  dx = TWO_PI / (period*sPeriod);
  
  //println("sPeroid:" + sPeroid,  

  // Slider for amplitude (Amp slider)
  line(oWidth+cSize/4, height*2/3, oWidth+cSize/4, height*9/10);
  circle(oWidth+cSize/4, aSliderY, 15);

  // Logic for amplitude slider
  amplitude = map(aSliderY, height*2/3, height*9/10, 0.0001, 1000);
  
  
  // General waveType button setup
  noStroke();
  
  // Sine wave button
  fill(255, 0, 0); // red
  circle(oWidth+cSize/4, height/2, cSize/4);
  
  // Square wave button
  fill(0, 255, 0); // green
  circle(oWidth+cSize/2, height/2, cSize/4);
  
  // Sawtooth wave button
  fill(0, 0, 255); // blue
  circle(oWidth+cSize*3/4, height/2, cSize/4);
  
  // Triangle wave button
  fill(255, 255, 0); // yellow
  circle(oWidth+cSize/4, height*3/5, cSize/4);
  
  // Pulse wave button
  fill(0, 255, 255); // cyan
  circle(oWidth+cSize/2, height*3/5, cSize/4);

  // Help text
  if (h==true) {
    text("time^10\n(focus)", oWidth+cSize/12, height/25, cSize/3, height/12.5);
    text("timex10\n(general)", oWidth+cSize*4/12, height/25, cSize/3, height/12.5);
    text("time\n(length)", oWidth+cSize*7/12, height/25, cSize/3, height/12.5);
    text("amplitude", oWidth+cSize/12, height*16/25, cSize/3, height/12.5);
  }

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
  float phase = (x % TWO_PI) / TWO_PI;
  for (int i = 0; i < yvalues.length; i++) {
    if (waveType == 'i') yvalues[i] = sin(x) * amplitude;
                                          // condition  // if true  // if false //
    else if (waveType == 'q') yvalues[i] = (sin(x) > 0) ? amplitude : -amplitude;
    else if (waveType == 'a') yvalues[i] = ((x % TWO_PI) / PI - 1)  * amplitude;
    else if (waveType == 'r') yvalues[i] = (asin(sin(x)) / HALF_PI) * amplitude;
    else if (waveType == 'u') {
      yvalues[i] = (phase < pulseTime) ? amplitude : -amplitude;
      println(yvalues[0], yvalues[1], yvalues[i]);
    }
    x += dx;
  }
}

void mouseDragged() {
  // UI slider
  if (mouseX >= oWidth-width/75 && mouseX <= oWidth+width/75 && mouseY >= 0 && mouseY <= height) oWidth = int(mouseX);
  // Precision slider
  else if (mouseX >= oWidth+cSize*5/12 && mouseX <= oWidth+cSize*7/12 && mouseY >= height/10 && mouseY <= height/3) pSliderY = mouseY;
  // Super precision slider
  else if (mouseX >= oWidth+cSize*2/3 && mouseX <= oWidth+cSize*5/6 && mouseY >= height/10 && mouseY <= height/3) sSliderY = mouseY;
  // Focus slider
  else if (mouseX >= oWidth+cSize/6 && mouseX <= oWidth+cSize/3 && mouseY >= height/10 && mouseY <= height/3) fSliderY = mouseY;
  // Amp slider
  else if (mouseX >= oWidth+cSize/6 && mouseX <= oWidth+cSize/3 && mouseY >= height*2/3 && mouseY <= height*9/10) aSliderY = mouseY;
  // Window width slider
  if (mouseX >= width/1.01 && mouseX <= width*1.01) width = mouseX;
  // Window height slider
  if (mouseY >= height/1.01 && mouseY <= width*1.01) height = mouseY;
}

void keyPressed() {
  if (key == 'h' || key == 'H') h = !h;
}

void mouseReleased() {
  // Sine wave
  if (dist(oWidth+cSize/4, height/2, mouseX, mouseY) <= cSize/8) waveType = 'i';
  // Square wave
  else if (dist(oWidth+cSize/2, height/2, mouseX, mouseY) <= cSize/8) waveType = 'q';
  // Sawtooth wave
  else if (dist(oWidth+cSize*3/4, height/2, mouseX, mouseY) <= cSize/8) waveType = 'a';
  // Triangle wave
  else if (dist(oWidth+cSize/4, height*3/5, mouseX, mouseY) <= cSize/8) waveType = 'r';
  // Pulse wave
  else if (dist(oWidth+cSize/2, height*3/5, mouseX, mouseY) <= cSize/8) waveType = 'u';
}
