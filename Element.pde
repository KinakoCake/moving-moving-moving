public class Element {
  private float x, y;
  private float scale;
  int Color;

  private float targetX, targetY;
  private float targetScale;
  private int num;
  private Boolean view = true;

  float[] getPosition() {
    float [] positions = {this.x, this.y, this.scale};
    return positions;
  }

  int getColor() {
    return this.Color;
  }

  void setRandomColor() {
    if (0.6 > random(10)) {
      Color = 255;
    } else {
      Color = int(random(25, 255));
    }
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
    float easing = 0.075;

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
      fill(Color);
      rect(x, y, scale, scale);

      noStroke();

      if (Color<160) {
        fill(255);
      } else {
        fill(0);
      }

      text(num, x, y+10);
    }
  }
}
