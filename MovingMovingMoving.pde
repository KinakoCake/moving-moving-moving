import processing.video.*;
Capture cam;
PImage img;
PImage cam2;

Element e;
ArrayList<Element> es;

int count = 4;
int num = 0;
int prevElementsSize = 0;

void setup() {
  size(600, 600);

  es = new ArrayList<Element>();
  squareRecusion(0, 0, width, count);
  prevElementsSize = es.size();
}

void draw() {
  background(255);

  for (Element e : es) {
    e.move();
    e.render();
  }
}

void mousePressed() {
  num = 0;
  squareRecusion(0, 0, width, count);
  prevElementsSize = num;
}

void squareRecusion(float sqX, float sqY, float scale, int cnt) {

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
      squareRecusion(sqX, sqY, halfScale, cnt);
      squareRecusion(sqX+halfScale, sqY, halfScale, cnt);
      squareRecusion(sqX+halfScale, sqY+halfScale, halfScale, cnt);
      squareRecusion(sqX, sqY+halfScale, halfScale, cnt);
    }
  }
}
