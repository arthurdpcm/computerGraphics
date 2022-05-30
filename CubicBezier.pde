ArrayList<PVector> pontos = new ArrayList<PVector>();
PVector pontoSelecionado = null;

void setup() {
  size(600,600);
}

void draw() {
  background(200);
  if(pontoSelecionado != null) {
    pontoSelecionado.x = mouseX;
    pontoSelecionado.y = mouseY;
  }
  for(int i=0; i<pontos.size(); i++) {
    PVector p = pontos.get(i);
    if(p == pontoSelecionado) {
      fill(255,0,0);
    } 
    else {
    }
    circle(p.x,p.y,10);
  }
  
  if(pontos.size() == 4){

    teste();
  }
  
}

void mouseReleased() {
  pontoSelecionado = null;
}

void mousePressed() {
  
  PVector p = new PVector(mouseX, mouseY);
  
  for(int i=0; i<pontos.size(); i++) {
    PVector p2 = pontos.get(i);
    if(p.dist(p2) < 10) {
      pontoSelecionado = p2;
      return;
    }
  }
  if(pontos.size()<4){
    pontoSelecionado = p;
    pontos.add(p);
  }
}

void teste()
{
  float p1x = pontos.get(0).x;
  float p1y = pontos.get(0).y;
  float p2x = pontos.get(1).x;
  float p2y = pontos.get(1).y;
  float p3x = pontos.get(2).x;
  float p3y = pontos.get(2).y;
  float p4x = pontos.get(3).x;
  float p4y = pontos.get(3).y;
  noFill();
  beginShape();
  for(float t = 0; t <= 1; t += 0.01)
  {
    float ax = p1x + t*(p2x-p1x);
    float bx = p2x + t*(p3x-p2x);
    float cx = p3x + t*(p4x-p3x);
    float dx = ax + t*(bx-ax);
    float ex = bx + t*(cx-bx);
    float fx = dx + t*(ex-dx);
    
    
    float ay = p1y + t*(p2y-p1y);
    float by = p2y + t*(p3y-p2y);
    float cy = p3y + t*(p4y-p3y);
    float dy = ay + t*(bx-ay);
    float ey = by + t*(cy-by);
    float fy = dy + t*(ey-dy);
    
    
    vertex(fx,fy);  
  }
  endShape();
}
