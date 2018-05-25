import processing.pdf.*;

PImage img;

float resolution = 360/2; // how many subdivisions the circle will have
float angleIncr = 360/resolution; // reverse of the resolution gives size of increment for the arc sections
int scale = 1; // how much bigger than the input the output will be
String extension = ".jpg"; // image extension

void settings(){
  img = loadImage("img.jpg");
  size(img.width * scale, img.height * scale, P3D);
}

void setup() {
  noStroke();
  noLoop();
}

void draw(){
  background(0);
  
  // create several iteractions to fill the empty space
  for(int i = 0; i < 10; i++){
    float widthVar = random(0.9, 1.3);
    drawArcs(width * widthVar);
  }
  
  drawArc(true, true, 0, 360, width/2, width);
  
  saveFrame("saved/" + year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + "-arcs" + extension);
  exit();
}

void drawArcs(float smallRadius) {
  boolean isPlain = int(smallRadius) % 2 == 0; // every other arc is filled with solid colors
  int angleVariation = isPlain ? 10 : width/15;

  float arcAngle = random(20, 180); // size of the arc
  float bigRadius = smallRadius + random(2, angleVariation); // width of the arc
  float initAngle = random(360); // start arc somewhere around a circle
  
  drawArc(false, isPlain, initAngle, arcAngle, smallRadius, bigRadius);

  if (smallRadius >= 0) { drawArcs(smallRadius - random(10, width/8)); }
}

void drawArc(boolean isFrame, boolean isPlain, float initAngle, float arcAngle, float smallRadius, float bigRadius){
  float centerX = width/2;
  float centerY = height/2;
  
  beginShape(TRIANGLE_STRIP);
  
  color c = color(255);

  if (isPlain && !isFrame) {
    int x = int((cos(0) * (bigRadius) + centerX)/scale);
    int y = int((sin(0) * (bigRadius) + centerY)/scale);
    c = img.get(x, y);
  }
  
  for (float theta = initAngle; theta <= arcAngle + initAngle; theta += angleIncr) {
    float x1 = cos(radians(theta)) * (bigRadius) + centerX;
    float y1 = sin(radians(theta)) * (bigRadius) + centerY;
    float x2 = cos(radians(theta)) * (smallRadius) + centerX;
    float y2 = sin(radians(theta)) * (smallRadius) + centerY;

    // fill with pixel colors if is not plain arc
    if (!isPlain) { c = img.get((int)x1/scale, (int)y1/scale); }

    fill(c);
    vertex(x1, y1);
    vertex(x2, y2);
  }
  endShape();
}
