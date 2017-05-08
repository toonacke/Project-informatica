class Building {
        
  PVector position;   // position
 
  float w,h,d;
  float strength = 0.05;  

  Building(float w, float h, float d, float x, float y) {
    this.w=w;
    this.h=h;
    this.d=d;
    
    
    position = new PVector(x,y);
    
  }
  
  void display() {
   
    strokeWeight(5);
    stroke(#FA0A0E);
    fill(#FA0A0E);
    
    pushMatrix();
    translate(position.x,position.y,d/2);
    box(w, h, d);
    
    popMatrix();
  }
  
}