import java.util.Collections;
PFont myFont;
String emoji = "";
Boolean debug = false;

int i = 0;
int count = 4;
int num = 0;
int prevElementsSize = 0;
Boolean isMoving = false;
int[] removeElements = new int[3];

PImage img;

Element e;
ArrayList<Element> es;
ArrayList<Integer> topElements = new ArrayList<>();


int n = 0;


//int sz=10;


import processing.video.*;


Capture cam;

PImage cam2;



void setup() {



  /*String[] cameras = Capture.list();
   cam = new Capture(this, cameras[1]);
   
   
   cam.start();*/


  size(800, 600);
  fullScreen();


  //initElement();

  println("再起処理前");
  es = new ArrayList<Element>();
  squareRecusion(width/2-(height/2), 0, height, count);
  println("再起処理終了");
  prevElementsSize = es.size();
}

void draw() {
  /*if (cam.available()) {
   cam.read();
   }*/
  background(0);



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

  for (Element e : es) {
    e.render();
  }
}

void mousePressed() {
  /*for(Element e:es){
    for(Integer i:topElements){
      if(e.getNum() == i){
        println(i + "   " + e.getNum());
      }else{
        e.setView(false);
      }
    }
    
    println(e.getNum());
  }*/
  num = 0;
  squareRecusion(width/2-(height/2), 0, height, count);
  prevElementsSize = num;

  //uniteElement();


}

void keyPressed() {
  println(keyCode);
  if (keyCode == 49) {
    debug = !debug;
    println(debug);
  }
  if (keyCode == 81 && n<=es.size()) {
    println(n);
    n++;
  } else if (keyCode == 87 && n!=0) {
    println(n);
    n--;
  }

  if (debug==true) {
    for (Element e : es) {
      if (e.getNum()==n) {
        e.setView(true);
      } else {
        e.setView(false);
      }
    }
  } else {
    for (Element e : es) {
      e.setView(true);
    }
  }
  if (keyCode==38) {
    uniteElement();
  } else if (keyCode==37) {
    for (i=0; i<=2; i++) {
      //es.remove(removeElements[i]);
      //println("dellllll");


      
      e = es.get(100);

      e.targetScale = e.scale*2;

      es.set(100, e);
    }
    //removeElements = new int[3];
  } else if (keyCode==39) {
    e = es.get(0);
    checkOverlapPosition(e);
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
    e.setNum(es.size());
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

  println(cnt + "  " + e.getNum());

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

void uniteElement() {
  for (i=0; i<es.size(); i++) {
    if (i>es.size()) {
      println("over");
    } else {
    }


    Element searchEl = es.get(i);
    searchEl.R = 255;
    es.set(i, searchEl);

    // 範囲指定で検索するような機能を後で実装する

    int n = 0;
    for (Element e : es) {
      float d = dist(e.x, e.y, searchEl.x, searchEl.y) ;
      if (d < 108 ) {

        if (e.scale < searchEl.scale+1 && e.scale > searchEl.scale-1) {
          //println("rinsetsu  " + e.getNum() + "   " + d + "   " + e.scale + "  " + n);
          e.R = 100;
          n++;


          if (searchEl.y<e.y && (searchEl.x < e.x+1 && searchEl.x > e.x-1) ) {
            println(searchEl.x + " > " + (e.x + 1));
            println(searchEl.x + " < " + (e.x - 1));
            println(e.getNum() + " is shita");
            removeElements[0] = e.getNum();
          }

          if (searchEl.x<e.x && (searchEl.y < e.y+1 && searchEl.y > e.y-1) ) {
            println(searchEl.x + " > " + (e.x + 1));
            println(searchEl.x + " < " + (e.x - 1));
            println(e.getNum() + " is hidari");
            removeElements[1] = e.getNum();
          }

          if ((searchEl.x<e.x && searchEl.y<e.y)) {
            println(searchEl.x + " > " + (e.x + 1));
            println(searchEl.x + " < " + (e.x - 1));
            println(e.getNum() + " is naname shita hidari");
            removeElements[2] = e.getNum();
          }
        }
      }


      if (searchEl.x > e.x-1 && searchEl.x < e.x + e.scale+1) {
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
    //println(e.getNum());
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

void checkOverlapPosition(Element el) {

  for (Element e : es) {
    if (e.x == el.x && e.y == el.y) {
      println("[おい！！！！]" + e.getNum() + ": " + e.x + "    " + el.getNum() + ": " + el.x);
    }
  }
}
