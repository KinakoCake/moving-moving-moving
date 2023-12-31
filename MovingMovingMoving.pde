Element e;
ArrayList<Element> es;

int count = 4;
int countR = 3;
int num = 0;
int prevElementsSize = 0;
int msTMP = 0;

void setup() {
  fullScreen();
  //size(600, 600);

  es = new ArrayList<Element>();
  genSquareRecursion();
  prevElementsSize = es.size();
}

void draw() {
  background(0);

  for (Element e : es) {
    e.move();
    e.render();
  }

  int ms = millis();
  if (ms - msTMP >= 2500) {
    genSquareRecursion();
    msTMP = ms;
  }
}

void mousePressed() {
  genSquareRecursion();
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
    e.setRandomColor();
    es.add(e);
    es.set(es.size()-1, e);
  } else if (num > prevElementsSize && num <= es.size()) {
    e = es.get(num);
    e.setNum(num);
    e.setTargetPos(sqX, sqY, scale);
    es.set(num, e);
  }

  cnt -= 1;
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

void genSquareRecursion() {
  num = 0;

  squareRecursion(0, 0, height, count);
  squareRecursion(height-(height/4), 0, height, countR);

  prevElementsSize = num;
}
