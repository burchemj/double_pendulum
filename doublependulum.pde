float r1 = 200;
float r2 = 200;
float m1 = 40;
float m2 = 40;
float a1 = PI/2;
float a2 = 30;
float a1_v = 0;
float a2_v = 0;
float a1_a = 0;
float a2_a = 0;

float a1b = PI/4;
float a2b = 30;
float a1_vb = 0;
float a2_vb = 0;
float a1_ab = 0;
float a2_ab = 0;

float g = 1;

float px2 = -1;
float py2 = -1;

float px2b = -1;
float py2b = -1;

PGraphics canvas;

void setup() {
  size(1000, 1000);
  canvas = createGraphics(1000, 1000);
  canvas.beginDraw();
  canvas.background(255);
  canvas.endDraw();
}

void draw() {
  float num1 = -g * (2 * m1 + m2) * sin(a1);
  float num2 = -m2 * g * sin(a1 - 2*a2);
  float num3 = -2 * sin(a1 - a2) * m2 * (a2_v * a2_v * r2 + a1_v * a1_v * r1 * cos(a1 - a2));
  float den = r1 * (2*m1 + m2 - m2 * cos(2*a1-2*a2));
  a1_a = (num1 + num2 + num3) / den;

  num1 = 2 * sin(a1-a2);
  num2 = (a1_v * a1_v * r1 * (m1 + m2) + g*(m1+m2) * cos(a1) + a2_v * a2_v * r2*m2*cos(a1-a2));
  den = r2 * (2 * m1 + m2 - m2 * cos(2*a1 - 2*a2));
  a2_a = (num1*num2) / den;

  float b_num1 = -g * (2 * m1 + m2) * sin(a1b);
  float b_num2 = -m2 * g * sin(a1b - 2*a2b);
  float b_num3 = -2 * sin(a1b - a2b) * m2 * (a2_vb * a2_vb * r2 + a1_vb * a1_vb * r1 * cos(a1b - a2b));
  float b_den = r1 * (2*m1 + m2 - m2 * cos(2*a1b-2*a2b));
  a1_ab = (b_num1 + b_num2 + b_num3) / b_den;

  b_num1 = 2 * sin(a1b-a2b);
  b_num2 = (a1_vb * a1_vb * r1 * (m1 + m2) + g*(m1+m2) * cos(a1b) + a2_vb * a2_vb * r2*m2*cos(a1b-a2b));
  b_den = r2 * (2 * m1 + m2 - m2 * cos(2*a1b - 2*a2b));
  a2_ab = (b_num1*b_num2) / b_den;

  image(canvas,0,0);
  stroke(0);
  strokeWeight(2);

  translate(500, 250);

  float x1 = r1 * sin(a1);
  float y1 = r1 * cos(a1);

  float x2 = x1 + r2 * sin(a2);
  float y2 = y1 + r2 * cos(a2);

  line(0, 0, x1, y1);
  fill(0);
  ellipse(x1, y1, m1, m1);

  line(x1, y1, x2, y2);
  fill(0);
  ellipse(x2, y2, m2, m2);

  float x1b = r1 * sin(a1b);
  float y1b = r1 * cos(a1b);

  float x2b = x1b + r2 * sin(a2b);
  float y2b = y1b + r2 * cos(a2b);

  fill(150);
  line(0, 0, x1b, y1b);
  ellipse(x1b, y1b, m1, m1);

  line(x1b, y1b, x2b, y2b);
  ellipse(x2b, y2b, m2, m2);

  a1_v += a1_a;
  a2_v += a2_a;
  a1 += a1_v;
  a2 += a2_v;

  a1_vb += a1_ab;
  a2_vb += a2_ab;
  a1b += a1_vb;
  a2b += a2_vb;

  canvas.beginDraw();
  canvas.translate(500, 250);
  canvas.strokeWeight(4);

  canvas.stroke(0);
  if (frameCount > 1) {
    canvas.line(px2, py2, x2, y2);
  }

  canvas.stroke(150);
  if (frameCount > 1) {
    canvas.line(px2b, py2b, x2b, y2b);
  }

  canvas.endDraw();

  px2 = x2;
  py2 = y2;

  px2b = x2b;
  py2b = y2b;
}
