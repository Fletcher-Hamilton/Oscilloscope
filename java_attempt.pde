// Fletcher Hamilton

float amplitude = 100;
float theta = 0;
float dx, cSize, sSliderY, fSliderY, aSliderY, pSliderY, period, sPeriod, pMax;
float[] yvalues;
int gridSize = 10;
int maxFocus = 1000;
int oWidth;
boolean h = false;
PImage milkyWayBg;

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
  period = map(pSliderY, height/10, height/3, 1, pMax*10);

  // Slider for small change in period (Super precision slider)
  line(oWidth+cSize*3/4, height/10, oWidth+cSize*3/4, height/3);
  circle(oWidth+cSize*3/4, sSliderY, 15);

  // Logic for super precision slider
  sPeriod = map(sSliderY, height/10, height/3, pMax-200, pMax);
  dx = TWO_PI / (period*sPeriod);  // period = 200 at default

  // Slider for amplitude (Amp slider)
  line(oWidth+cSize/4, height*2/3, oWidth+cSize/4, height*9/10);
  circle(oWidth+cSize/4, aSliderY, 15);

  // Logic for amplitude slider
  amplitude = map(aSliderY, height*2/3, height*9/10, 1, 1000);


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
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = sin(x) * amplitude;
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
