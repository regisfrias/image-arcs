import processing.pdf.*;

PImage img;

float resolution = 360/2;
float angleIncr = 360/resolution;

void setup() {
  size(800, 800, P3D);
  img = loadImage("img6.jpg");
  noStroke();
  noLoop();
}

void draw(){
  background(0);
  for(int i = 0; i < 10; i++){
    float widthVar = random(0.9, 1.3);
    drawArcs(width * widthVar);
  }
  
  saveFrame("saved/" + year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + "-circles.jpg");
  exit();
}

void drawArcs(float smallRadius) {
  boolean isPlain = int(smallRadius) % 2 == 0;
  int angleVariation = isPlain ? 10 : width/15;
  //float centerX = random(width/2 - width/20, width/2 + width/20);
  //float centerY = random(height/2 - height/20, height/2 + height/20);
  float centerX = width/2;
  float centerY = height/2;

  float arcAngle = random(20, 180);
  float bigRadius = smallRadius + random(2, angleVariation);
  float initAngle = random(360);

  color c = color(0);

  if (isPlain) {
    int x = int(cos(0) * (bigRadius) + centerX);
    int y = int(sin(0) * (bigRadius) + centerY);
    c = img.get(x, y);
  }

  beginShape(TRIANGLE_STRIP);
  //texture(img);
  for (float theta = initAngle; theta <= arcAngle + initAngle; theta += angleIncr) {
    float x1 = cos(radians(theta)) * (bigRadius) + centerX;
    float y1 = sin(radians(theta)) * (bigRadius) + centerY;
    float x2 = cos(radians(theta)) * (smallRadius) + centerX;
    float y2 = sin(radians(theta)) * (smallRadius) + centerY;

    if (!isPlain) {
      c = img.get((int)x1, (int)y1);
    }

    fill(c);
    vertex(x1, y1);
    vertex(x2, y2);
  }
  endShape();

  if (smallRadius >= 0) {
    drawArcs(smallRadius - random(10, width/8));
  }
}
