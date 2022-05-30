

void setup(){
  size(900,900);
  frameRate(60);
}

//Célula 1
int n = 3;

void desenharCelula1(){
  pushMatrix();

  frameRate = 60;
  if(frameCount % (2*frameRate) == 0){
    if (n >= 12){
      n=2;
    }
    n+=1;
    
  }
  
  float a = -TWO_PI/n;
  float r = 0.8 * width/6;
  translate(width/6,height/6);
  fill(255,255,255);
  beginShape();
  
  for(int i=0; i<n; i++)
  {
    float x = r*cos(i*a);
    float y = r*sin(i*a);
    vertex(x,y);
  }
  endShape(CLOSE);
  popMatrix();
}

//Célula 2

float ax=375, ay=150 ,bx=525, by=150;
int nivel = 1;

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

void desenharCelula2(){
  fill(255,255,255);
  ellipse(450,150,300,300); // raio = 150
  //triangle(320,225,450,0,580,225); // h= 3/2 * 150 = 225
  fill(255,255,255);
  
  frameRate = 60;

  if(frameCount % (2*frameRate) == 0){
    if (nivel >= 6){
      nivel=0;
    }
    nivel+=1;
    
  }
  // 3 por que é triangulo, ou seja 3 lados
  float ang = TWO_PI/3; 
  float r = 0.4 * width/3;
  PVector[] lado = new PVector[3];
  
  for (int i=0; i<3; i++){
    lado[i] = new PVector(r*cos(i*ang),r*sin(i*ang)); // gerar 3 lados
  }
  pushMatrix();
  translate(width/2,height/6);
  beginShape();
    for (int i=0; i<3; i++){
      if (i!=2){
        kochCurve(lado[i].x,lado[i].y,lado[i+1].x,lado[i+1].y,nivel);
      } else {
        kochCurve(lado[i].x,lado[i].y,lado[0].x,lado[0].y,nivel);
      }
    }
  endShape(CLOSE);
  popMatrix();
  
}

//Célula 3

void desenharCelula3(){
  pushMatrix();
  noStroke();
  translate(5*width/6,height/6);
  fill(255,255,0);
  circle(0,0,50);
  rotate((frameCount)*(TWO_PI)/(60*20));
  translate(100,0);
  
  fill(0,0,255);
  circle(0,0,25);
  rotate((frameCount)*(TWO_PI)/(60*5));
  translate(30,0);
  
  fill(50);
  circle(0,0,10);
  stroke(0);
  popMatrix();
}

//Célula 4
ArrayList <PVector>rastroCelula4 = new ArrayList <PVector>(); //vetor pra armazenar o rastro da lua celula 4

void desenharCelula4(){
  
  pushMatrix();
  translate(width/6,height/2);
  //circle(0,0,50);
  
  rotate((frameCount)*(TWO_PI)/(60*20));
  translate(100,0);
  //circle(0,0,25);
  
  rotate((frameCount)*(TWO_PI)/(60*5));
  translate(30,0);
  //circle(0,0,10);
  
  float luaX = screenX(0,0);
  float luaY = screenY(0,0);
  rastroCelula4.add(new PVector(luaX, luaY));
  popMatrix();
  fill(0);
  for (PVector p : rastroCelula4){
    circle(p.x, p.y, 2);
  }
  
  if (frameCount % 1200 == 0) {
    rastroCelula4.clear();
  }
}

//Célula 5
ArrayList <PVector>rastroCelula5 = new ArrayList <PVector>(); //vetor pra armazenar o rastro da lua celula 5

void desenharCelula5(){
  
  pushMatrix();
  translate(3*width/6,height/2);
  //circle(0,0,50);
  
  rotate((frameCount)*(TWO_PI)/(60*1));
  translate(100,0);
  //circle(0,0,25);
  
  rotate((frameCount)*(TWO_PI)/(60*10));
  translate(30,0);
  //circle(0,0,10);
  
  float luaX = screenX(0,0);
  float luaY = screenY(0,0);
  rastroCelula5.add(new PVector(luaX, luaY));
  popMatrix();
  fill(0);
  for (PVector p : rastroCelula5){
    circle(p.x, p.y, 1);
  }
  
  if (frameCount % 600 == 0) {
    rastroCelula5.clear();
  }
  
}

//Célula 6

ArrayList <PVector>curvaCelula6 = new ArrayList <PVector>();
void desenharCelula6(){
  float u = frameCount/100.0;
  float x =15*cos(u)*(exp(cos(u))-2*cos(4*u)-sin(pow((u/12),5)));
  float y =15*sin(u)*(exp(cos(u))-2*cos(4*u)-sin(pow((u/12),5)));
  curvaCelula6.add(new PVector(x,y));
  pushMatrix();
  translate(5*width/6,height/2);
  beginShape();
  
  for(PVector p : curvaCelula6){
    vertex(p.x, p.y);
  }
  
  endShape();
  popMatrix();
}

//Célula 7
ArrayList <PVector>curvaCelula7 = new ArrayList <PVector>();
void desenharCelula7(){
  
  pushMatrix();
  translate(width/6,5*height/6);
  float R = 10;
  float fi1 = 2;
  float fi2 = 4;
  float a=0.2;
  float b=0.5;
  float teta = radians(frameCount);
  if (a+b > 1){
    return;
  }
  
  beginShape();

  float r = 5*R*(1 +a*cos(2*teta+fi1) +b*cos(3*teta+fi2));
  float x = r*cos(teta);
  float y = r*sin(teta);
  curvaCelula7.add(new PVector(x,y));
  for(PVector p : curvaCelula7){
   vertex(p.x, p.y);
   

  }

  if (teta == 2*PI){
    teta = 0;
  }
  
  endShape();
  popMatrix();
  
}

//Célula 8 - Bezier Curve

ArrayList<PVector> pontos = new ArrayList<PVector>();
PVector pontoSelecionado = null;

void bezierCurve()
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

void mouseReleased() {
  pontoSelecionado = null;
}

void desenharCelula8(){
  pushMatrix();
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
    if ( 300 > p.x){
      p.x = 310;
    } else if(600 < p.x){
      p.x = 590;
    }
    if ( 600 > p.y){
      p.y = 610;
    } else if(900 < p.y ){
      p.y = 890;
    }
    circle(p.x,p.y,10);
  }
  
  if(pontos.size() == 4){

    bezierCurve();
  }
  popMatrix();
}



//Célula 9 - Espiral de Lítuo

ArrayList <PVector>curvaCelula9 = new ArrayList <PVector>();

void desenharCelula9(){ 
  float ang = radians(200);
  float teta = radians(frameCount*20);
  float r = 50*sqrt(ang/teta);
  
  pushMatrix();
  translate(5*width/6, 5*height/6);
  beginShape();
  float x = r*cos(teta);
  float y = r*sin(teta);
  curvaCelula9.add(new PVector(x,y));
  for(PVector p : curvaCelula9){
    vertex(p.x, p.y);
  }
  endShape();
  popMatrix();

  
}


void draw(){
  background(200);
  
  //Célula 1
  
  fill(200,200,200);
  square(0,0,300);
  
  desenharCelula1();
  
  fill(180,180,180);
  square(300,0,300); 
  
  //Célula 2
  
  desenharCelula2();
  
  fill(160,160,160);
  square(600,0,300);
  
  //Célula 3
  desenharCelula3();
  
  fill(140,140,140);
  square(0,300,300);
  
  //Célula 4  
  desenharCelula4();
  
  fill(120,120,120);
  square(300,300,300);
  
  //Célula 5  
  desenharCelula5();
  
  fill(100,100,100);
  square(600,300,300);
  
  //Célula 6  
  desenharCelula6();
  
  fill(80,80,80);
  square(0,600,300);
  
  //Célula 7  
  desenharCelula7();
  
  fill(60,60,60);
  square(300,600,300);
  
  //Célula 8
  desenharCelula8();
  
  
  fill(40,40,40);
  square(600,600,300);  
  
  //Célula 9  
  desenharCelula9();
  
}

  
  
