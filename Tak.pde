class Tak {
 
  float x1,x2,y1,y2,age;
  float maxAge=5;

  Tak(float x, float y,float xx,float yy,float life) {
   
    x1=x;
    y1=y;
    x2=xx;
    y2=yy;
    age=life;
    
   
   
    
  }
  
 void  display(){
   strokeWeight(age);
   line(x1,y1,x2,y2); 
   
   
   
   
 }
  
  void addyear(){
   age=age+0.01; 
   age=constrain(age,0,maxAge);
  }
  
  
}