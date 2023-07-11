int i = 0;
int count = 4;
int num = 0;
int prevElementsSize = 0;

Element e;
ArrayList<Element> es;

//int sz=10;


import processing.video.*;


Capture cam;

PImage cam2;



void setup() {
  /*String[] cameras = Capture.list();
   cam = new Capture(this, cameras[1]);
   
   cam.start();*/


  size(600, 600);


  //initElement();

  println("再起処理前");
  es = new ArrayList<Element>();
  squareRecusion(0, 0, width, count);
  println("再起処理終了");
  prevElementsSize = es.size();
}

void draw() {
  /*if (cam.available()) {
   cam.read();
   }*/
  background(255);



  for (Element e : es) {
    if (floor(e.targetX)!=floor(e.x) && floor(e.targetY)!=floor(e.y)) {
      e.move();
    }

    float x = e.getPosition()[0];
    float y = e.getPosition()[1];
    float sqsz = e.getPosition()[2];

    //image(e.getElement(), x, y);

    fill(e.getColor());
    rect(x, y, sqsz, sqsz);
  }
}

void mousePressed() {
  num = 0;
  squareRecusion(0, 0, width, count);
  prevElementsSize = es.size();
}

void keyPressed() {
  for (Element e : es) {
    println(e.targetX);
  }
}

void squareRecusion(float sqX, float sqY, float scale, int cnt) {


  if (prevElementsSize>=1) {
    e = es.get(num);
    e.setTargetPos(sqX, sqY, scale);
    es.set(num, e);
    println("num  " + num + "   prev  " + prevElementsSize);
  }else if(num > prevElementsSize){

   
    
    e = new Element();
    e.setTargetPos(sqX, sqY, scale);
    es.add(e);
     es.set(num, e);
    println("add");
  }

  if (prevElementsSize<=1) {
    e = new Element();
    e.setTargetPos(sqX, sqY, scale);
    es.add(e);
  }


  //setTargetPos((int)sqX, (int)sqY, 20);


  //println(x+ "   " + y + "   " +sqsz);

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
