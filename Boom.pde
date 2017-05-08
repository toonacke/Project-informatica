// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com



class Boom {
  float mass;    // Mass, tied to size
  float G;       // Gravitational Constant
  PVector position;   // position
  
  float R=50;
  
  float strength = 0.05;  

  Boom(float x, float y) {
    position = new PVector(x,y);
    mass = 20;
    G = 1;
    
  }

  PVector repel(Agent v) {
    PVector force = PVector.sub(position,v.position);   // Calculate direction of force
    float d = force.mag();     // Distance between objects
    
    if (d<R){
    
    d = constrain(d,1.0,R);                          // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                  // Normalize vector (distance doesn't matter here, we just want this vector for direction)
       // Calculate gravitional force magnitude
    force.mult(-strength); 
    // Get force vector --> magnitude * direction
    
    return force;
    }
    else{
      
     return new PVector(0,0); 
    }
  }

  // Method to display
  void display() {
    ellipseMode(CENTER);
    strokeWeight(4);
    stroke(#3100FC);
    
    ellipse(position.x,position.y,mass*2,mass*2);
  }

  void tak(Boom b){                                                 //tekent tak tussen twee bomen
   takken.add(new Tak(b.position.x,b.position.y,position.x,position.y,1));
   
   
    
  }


}