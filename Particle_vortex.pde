float maxSpeed = 20;
float maxForce = 0.5;
int res = 5;

ArrayList<Particle> balls;

void setup(){
  fullScreen();
  translate(width/2, height/2);

  PImage start = loadImage("initialPos.png");
  start.resize(800/res,800/res);
  balls = new ArrayList<Particle>();
  for (int y=0; y < start.height; y++){
    for(int x=0; x < start.width; x++){
      int loc = x + (y * start.width);
      if(start.pixels[loc] != color(0)){
        
        PVector pos = new PVector(res*x - 400,res*y - 400);
        PVector vel = new PVector(0,0);
        float angle = angleOffHorizontal(pos);
        angle += random(-0.5,0.5); //radians
        PVector target = PVector.fromAngle(angle).mult(random(50,100));
        
        
        Particle ball = new Particle(target, pos, vel);
        balls.add(ball);
      }
    }
  }
}

void draw(){
  println(balls.size());
  translate(width/2, height/2);
  background(0);
  
  ArrayList<Particle> keep = new ArrayList<Particle>();
  for (Particle p : balls){
    if(!p.destroy){
      keep.add(p); 
    }
    p.behaviours();
    p.update();
    p.moveTarget();
    p.show();
  }
  balls = keep;
  
  if(balls.size() == 0){ //all balls offscreen
    noLoop(); 
  }
  
  
}

float angleOffHorizontal(PVector p){ //returns angle from horizontal between -PI and PI
  //PVetor.angleBetween always returns the acute angle between the vectors
  //so to get a consistent direction, sometimes we must invert the angle
  float angle = PVector.angleBetween(new PVector(1,0), p);
  if(p.y < 0){
    angle *= -1; 
  }
  return angle;
}
