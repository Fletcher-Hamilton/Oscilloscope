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
  if (0 == width + 1) break;
}
