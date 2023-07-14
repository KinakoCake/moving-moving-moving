import java.util.Collections;
PFont myFont;
String emoji = "";

int i = 0;
int count = 4;
int num = 0;
int prevElementsSize = 0;
Boolean isMoving = false;

PImage img;

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
    /*if (floor(e.targetX)!=floor(e.x) && floor(e.targetY)!=floor(e.y)) {
     e.move();
     }*/

    e.move();

    float x = e.getPosition()[0];
    float y = e.getPosition()[1];
    float sqsz = e.getPosition()[2];

    //image(e.getElement(), x, y);

    fill(e.getColor());
    if (e.num<4) {
      //e.setView(false);
    }
  }

  ArrayList<Element> res = new ArrayList<Element>(es);
  Collections.reverse(res);

  for (Element e : es) {
    e.render();
  }
}

void mousePressed() {
  num = 0;
  squareRecusion(0, 0, width, count);
  prevElementsSize = num;

  //checkOverlapPosition();
}


void keyPressed() {
  for (Element e : es) {
    println(e.targetX);
  }
  if (keyCode==38) {
    checkOverlapPosition();
    /*for (Element e : es) {
      if (e.getNum()==0) {
        e.x = 0;
        e.y = 0;
      }
    }*/
  }
}

void squareRecusion(float sqX, float sqY, float scale, int cnt) {
  //println("now " + num + "  es.size " + es.size());

  float r = random(1);

  if (prevElementsSize>=1 && num < prevElementsSize) {
    //println("a");
    e = es.get(num);
    e.setNum(num);
    e.setTargetPos(sqX, sqY, scale);
    es.set(num, e);
    //println("num  " + num + "   prev  " + prevElementsSize);
  } else if (num > es.size()-1) {
    //println("b");
    e = new Element();
    e.setTargetPos(sqX, sqY, scale);
    e.setNum(es.size()-1);
    es.add(e);
    es.set(es.size()-1, e);
    //println("add");
  } else if (num > prevElementsSize && num <= es.size()) {
    //println("torinokoshi " + num + "  es.size " + es.size());
    e = es.get(num);
    e.setNum(num);
    e.setTargetPos(sqX, sqY, scale);
    es.set(num, e);
  }

  if (cnt>1) {
    //e.setView(false);
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

void checkOverlapPosition() {
  for (i=0; i<es.size(); i++) {
    if (i>es.size()) {
      println("over");
    } else {
    }
    
    Element searchEl = es.get(100);
    searchEl.R = 255;
    es.set(100,searchEl);
    
    // 範囲指定で検索するような機能を後で実装する
    for (Element e : es) {
      if(searchEl.x > e.x-1 && searchEl.x < e.x + e.scale+1){
        println("rinsetsu  " + e.getNum());
        
      }
    
    }
    
    //if (x>e.x && x<e.x+e.scale) {
     //if (y>e.y && y<e.y+e.scale) {
    
    
    /*if (i+1>=es.size()) {
      println("a");
    } else {
      Element ne = es.get(i+1);

      
      if(ne.scale==e.scale){
       println("onaji size");
       
       ne.R = 255;
       e.R = 255;
       
       es.set(i, e);
       es.set(i+1, ne);
       
       }
    }*/

    Element e = es.get(i);
    println(e.getNum());
  }
  /*float x = el.getPosition()[0];
   float y = el.getPosition()[1];
   float sz = el.getPosition()[2];
   
   println(e.getNum() + "   a");
   
   for (Element e : es) {
   if (e.isView()==true) {
   if (x>e.x && x<e.x+e.scale) {
   if (y>e.y && y<e.y+e.scale) {
   e.setView(false);
   }
   }
   }
   }*/
}
