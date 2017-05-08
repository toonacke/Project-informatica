// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// The "Agent" class (for wandering)

class Agent {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float wandertheta;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed

  Agent(float x, float y) {
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    position = new PVector(x,y);
    r = 6;
    wandertheta = 0;
    maxspeed = 0.5;
    maxforce = 0.05;
  }

  void run() {
    update();
    boundaries();
    display();
  }

  // Method to update position
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    position.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  }

  void wander() {
    float wanderR = 25;         // Radius for our "wander circle"
    float wanderD = 150;         // Distance for our "wander circle"
    float change = 0.001;
    wandertheta += random(-change,change);     // Randomly change wander theta= optellen van random getal bij de huidige hoek

    // Now we have to calculate the new position to steer towards on the wander circle
    PVector circlepos = velocity.get();    // Start with velocity
    circlepos.normalize();            // Normalize to get heading
    circlepos.mult(wanderD);          // Multiply by distance
    circlepos.add(position);               // Make it relative to boid's position

    float h = velocity.heading2D();        // We need to know the heading to offset wandertheta

    PVector circleOffSet = new PVector(wanderR*cos(wandertheta+h),wanderR*sin(wandertheta+h));
    PVector target = PVector.add(circlepos,circleOffSet);
    seek(target);

  }
  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    force.limit(maxforce);
    acceleration.add(force);
  }


  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  void seek(PVector target) {
    PVector desired = PVector.sub(target,position);  // A vector pointing from the position to the target

    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);  // Limit to maximum steering force

    applyForce(steer);
  }

  void display() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + radians(90);
    fill(127);
    stroke(0);
    pushMatrix();
    translate(position.x,position.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }

  //// Wraparound
  //void borders() {
  //  if (position.x < -r) position.x = width+r;
  //  if (position.y < -r) position.y = height+r;
  //  if (position.x > width+r) position.x = -r;
  //  if (position.y > height+r) position.y = -r;
  //}

void boundaries() {

    PVector desired = null;
    
    //afstoten van de rand 
    
    if (position.x < d) {
      desired = new PVector(maxspeed, velocity.y);
    } 
    else if (position.x > width -d) {
      desired = new PVector(-maxspeed, velocity.y);
    } 

    if (position.y < d) {
      desired = new PVector(velocity.x, maxspeed);
    } 
    else if (position.y > height-d) {
      desired = new PVector(velocity.x, -maxspeed);
    } 
    
    //afstoten va gebowen
    for (Building B : buildings) {                          //TIJDELIJK HIER, LATER IN DRAW?
     PVector distance = PVector.sub(position,B.position);   // Calculate vector
    float dist = distance.mag();     // Distance between objects
    
    if (dist<B.w ){ //als afstand kleiner is tot centrum als de breedte dan afstoten in tegenovergestelde richting
     desired= distance; 
    }  
    }

    if (desired != null) {
      desired.normalize();
      desired.mult(maxspeed);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxforce/8);
      applyForce(steer);
    }
  }  
}