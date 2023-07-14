import processing.video.*;
Capture cam;
PImage img;
PImage cam2;

Element e;
ArrayList<Element> es;

int count = 4;
int num = 0;
int prevElementsSize = 0;
int msTMP = 0;

void setup() {
  //fullScreen();
  size(600, 600);

  es = new ArrayList<Element>();
  squareRecursion(0, 0, width, count);
  prevElementsSize = es.size();
}

void draw() {
  background(0);

  for (Element e : es) {
    e.move();
    e.render();
  }

  int ms = millis();


  if (ms - msTMP >= 1800) {
    regenSquareRecursion();
    msTMP = ms;
  }
}

void mousePressed() {
  regenSquareRecursion();
}

void squareRecursion(float sqX, float sqY, float scale, int cnt) {

  if (prevElementsSize>=1 && num < prevElementsSize) {
    e = es.get(num);
    e.setNum(num);
    e.setTargetPos(sqX, sqY, scale);
    es.set(num, e);
  } else if (num > es.size()-1) {
    e = new Element();
    e.setTargetPos(sqX, sqY, scale);
    e.setNum(es.size()-1);
    es.add(e);
    es.set(es.size()-1, e);
  } else if (num > prevElementsSize && num <= es.size()) {
    e = es.get(num);
    e.setNum(num);
    e.setTargetPos(sqX, sqY, scale);
    es.set(num, e);
  }

  cnt-=1;
  num += 1;

  if (cnt>=0) {
    float halfScale = scale/2;

    float p = map(cnt, 0, cnt-1, 0.5, 0);
    if (random(1)>p) {
      squareRecursion(sqX, sqY, halfScale, cnt);
      squareRecursion(sqX+halfScale, sqY, halfScale, cnt);
      squareRecursion(sqX+halfScale, sqY+halfScale, halfScale, cnt);
      squareRecursion(sqX, sqY+halfScale, halfScale, cnt);
    }
  }
}

void regenSquareRecursion() {
  num = 0;
  squareRecursion(0, 0, width, count);
  prevElementsSize = num;
}
