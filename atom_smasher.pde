static int s = 800; // size of applet
float theta = 0;
int count = 0;
int frame = 0;
int frameCnt = 5;
float maxFrame = 0;

Particle p[] = new Particle[150];

////////////////////////////////////////////////////////////

class Particle
{
  int c1=255, c2=255, c3=255;

  float charge = .05;
  float x=0, y=0;
  float ax=0, ay=0; 
  float t=0;
  float fx=0, fy=0;
  ////////////////////////////////////////////////////////////
  void calcForce(Particle particle)
  {
    // calculate forces
    fx = ((charge * particle.charge) / ((particle.x - x)*(particle.x - x) + (particle.y - y)*(particle.y - y))) * (particle.x - x);
    fy = ((charge * particle.charge) / ((particle.x - x)*(particle.x - x) + (particle.y - y)*(particle.y - y))) * (particle.y - y); 


  if(maxFrame < fx)
  {
    maxFrame = fx;
    //println("Max F " + fx);
  }

    if(fx > 10)
      fx = 10;
    if(fy > 10)
      fy = 10;

    if(fx < -10)
      fx = -10;
    if(fy < -10)
      fy = -10;


    //println("F " + fx + " " + fy);
    // calculate acceleration
    ax += fx;
    ay += fy; 
    
    particle.ax -= fx;
    particle.ay -= fy;
  }
  ////////////////////////////////////////////////////////////
  void move()
  {
    x += ax*1.1;
    y += ay*1.1;
  }
  ////////////////////////////////////////////////////////////
  Particle()
  {
    init();  
  }
  ////////////////////////////////////////////////////////////
  void init()
  {
    int type = (int)random(2);
    
    x = s / 2 + random(2) - 1;
    y = s / 2 + random(2) - 1;

    type = (int)random(3);

    charge = .1;
    if((int)random(11) > 9)
       charge *= -1;

    ax = 0;
    ay = 0;
    t = 0;
  
    
    //print("*"); 
    
//    x = (int)random(s);
//    y = (int)random(s);

    

    c1 = (int)random(255);
    c2 = (int)random(255);
    c3 = (int)random(255);

    if(c1 > c2 && c1 > c3)
    {   c1 = 255; c3 = 0; count = 120 + (int)random(30);}
    if(c2 > c1 && c2 > c3)
    {   c2 = 255; c1 = 0; count = 100 + (int)random(30);}
    if(c3 > c2 && c3 > c1)
    {   c3 = 255; c2 = 0; count = 100 + (int)random(20);}

  }
  ////////////////////////////////////////////////////////////
  void drawParticle()
  { 
    move();
    if(theta < count)
    {
      stroke(c1,c2,c3,t);     
      t+= .06;
    }
    if(theta > (2000 - count))
    {
      stroke(c1,c2,c3,t); 
      t-= .06;
    }
//    ellipse(x,y,5,5);
vertex(x,y);
//    println(x + " " + y);
  }
}
////////////////////////////////////////////////////////////
void setup()
{
  size(1280,720, FX2D); 
  ellipseMode(CENTER);
  background(0);
  fill(0);
  frameRate(200);

  count = 100;

  for(int x = 0; x < 150; x++)
  {
    p[x] = new Particle(); 
  } 
}
////////////////////////////////////////////////////////////
void draw()
{     
//background(255);

  if(mousePressed) 
  {
     background(0);
  } 

 
  if(theta++ > 1000)
  {
 //   if(frame++ > frameCnt)
    {  
      saveFrame(); 
      println("Saving Frame");
      frame = 0;
      frameCnt = 5 + (int)random(20);
  //    background(0, 0, 0, 200);
  
    fill(0,0,0,15);
    rect(0, 0, width, height);
    }  

    theta = 0;

  //  init();
          

    for(int x = 0; x < 150; x++)
    {
      p[x].init();
    }
  }
//      println("--------");
  for(int x = 0; x < 150; x++)
  {
    for(int y = x; y < 150; y++)
    {
      if(x != y) 
      {
        
//      println("C " + x +  " " + y);
      p[y].calcForce(p[x]);
      }
    } 
  } 
  
  beginShape(POINTS);
  for(int x = 0; x < 150; x++)
  {
    p[x].drawParticle();
  }
  endShape();
}