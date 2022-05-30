float ax, ay, bx, by;

void setup(){
  size(900, 900);
  background(0,0,0);
  stroke(255,255,255);

}

void draw(){

  ax = 100;
  ay = 450;
  bx = 800;
  by = 450;
  
  kochCurve(ax,ay, bx,by, 4);
}

void kochCurve(float ax,float ay,float bx,float by, int nivel){

  if(nivel == 0){
    line(ax,ay,bx,by);
    return;
  }
  float cx = ax+(bx-ax)*(1/3.0);
  float cy = ay+(by-ay)*(1/3.0);
  
  float dx = ax+(bx-ax)*(2/3.0);
  float dy = ay+(by-ay)*(2/3.0);
  
  float ex = (dx-cx)*cos(PI/3)+(dy-cy)*sin(PI/3)+cx;
  float ey = (dy-cy)*cos(PI/3)-(dx-cx)*sin(PI/3)+cy;

  kochCurve(ax,ay,cx,cy, nivel-1);
  kochCurve(cx,cy, ex, ey, nivel-1);
  kochCurve(ex,ey, dx, dy, nivel-1);
  kochCurve(dx,dy, bx, by, nivel-1);
    
}
