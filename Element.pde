public class Element {
  private float x, y;
  private float scale;
  private int Color = int(random(255));

  private int R = 500;
  private int G = 0;
  private int B = 0;

  private float elX, elY = 0;
  private PImage el;

  private float targetX, targetY;
  private float targetScale;
  private int num;
  private Boolean view = true;

  float[] getPosition() {
    float [] positions = {this.x, this.y, this.scale};
    return positions;
  }

  void setElement() {
    //elX = (int)random(width);
    //elY = (int)random(height);
  }

  /*PImage getElement() {
   //el = cam.get(elX, elY, sz, sz);
   return this.el;
   }*/

  int getColor() {
    return this.Color;
  }

  void setTargetPos(float x, float y, float sz) {
    targetX = x;
    targetY = y;
    targetScale = sz;
  }

  void setNum(int n) {
    num = n;
  }

  int getNum() {
    return this.num;
  }

  void move() {
    float easing = 0.1;

    float dx = targetX - x;
    float dy = targetY - y;
    float dsz = targetScale - scale;

    this.x += dx * easing;
    this.y += dy * easing;
    this.scale += dsz * easing;
  }

  void setView(Boolean b) {
    view = b;
  }

  Boolean isView() {
    return view;
  }

  void render() {
    if (view==true) {
      noStroke();
      fill(Color);

      rect(x, y, scale, scale);
      
      if(Color<160){
        fill(255);
      }else{
        fill(0);
      }
      text(num, x, y+10);
    }
  }
}
