class Particle{
  PVector pos;
  PVector target;
  PVector vel;
  PVector acc;
  float maxspeed;
  float maxforce;
  float angleTurned;
  boolean destroy;

  //constructor
  Particle(PVector T, PVector P, PVector V){
     target = T;
     pos = P;
     vel = V;
     acc = new PVector(0,0);
     maxspeed = maxSpeed;
     maxforce = maxForce;
     angleTurned = 0;
     destroy = false;
  }
  
  void behaviours(){
    PVector arive = arive();
    applyForce(arive);
  }
  
  void applyForce(PVector f){
    acc.add(f);
  }
  
  void update(){
    vel.add(acc);
    pos.add(vel);
    acc.mult(0); //set acceleration to 0 as force is only applied momenterilly
  }
  
  boolean offScreen(){
    return (pos.x<=-width/2) || (pos.x>=width/2) || (pos.y<=-height/2) || (pos.y>=height/2);
  }
  
  void show(){
    strokeWeight(res+1);
    stroke(255,0,0);
    if(offScreen()){
       stroke(0,0,255);
    }
    point(pos.x,pos.y);
    strokeWeight(1);
    //line(pos.x,pos.y,target.x,target.y);
  }
  
  PVector arive(){
    PVector desired = new PVector(target.x-pos.x,target.y-pos.y);
    // desired = target.sub(pos) for some reason doesnt work
    float distance = desired.mag();
    float speed = maxspeed;
    if (distance < 100){
      speed = map(distance, 0, 100, 0, maxspeed); 
    }
    desired.setMag(speed);
    PVector steer = new PVector(desired.x-vel.x,desired.y-vel.y);
    //println(pos,target,desired,steer);
    steer.limit(maxforce);
    return steer;
  }  


  void moveTarget(){
    float angle = angleOffHorizontal(target);
    float distance = target.mag();
    
    if(angleTurned < PI){    
      angle += 0.03; //radians
      distance += random(-10, 10);
      if(distance < 50){
        distance = 200; 
      }
      angleTurned += 0.03;
      
    } else {
      angle += 0.03; //radians
      distance *= random(1, 1.3);
      if(offScreen()){
        destroy = true;
      }
    }
    
    PVector newTarget = PVector.fromAngle(angle).mult(distance);
    target = newTarget;
    
  }
  
}
