public class Element {
  private float x, y;
  private float scale;
  private int Color = int(random(255));

  private float elX, elY = 0;
  private PImage el;

  private float targetX, targetY;
  private float targetScale;

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

  void move() {
    float easing = 0.1;

    float dx = targetX - x;
    float dy = targetY - y;
    float dsz = targetScale - scale;

    this.x += dx * easing;
    this.y += dy * easing;
    this.scale += dsz * easing;
  }

  /*void render() {
   fill(col);
   ellipseMode(CORNER);
   rect(x, y, scale, scale);
   }*/
}
