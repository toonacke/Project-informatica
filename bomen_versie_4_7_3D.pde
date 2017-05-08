import controlP5.*;        
import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

ControlP5 control;

PeasyCam camera;




boolean debug = false;

int boomx, boomy;
//doel
int x, y;
float w,h;

float d = 35;


int numbAgents=5; //aantal random agenten
int numbBoom=5; //aantalbomen
int numbBuildings=3;



// An ArrayList of agents                                
ArrayList<Agent> agents;

ArrayList<Boom> bomen;

ArrayList<Tak> takken;

ArrayList<Building> buildings;

void setup() {

  size(1009, 678, P3D);
  smooth(8);
  println("Hei Anaïs!  geniet ervan");
  camera = new PeasyCam( this, 500 );
  camera.setMinimumDistance( 200 );
  camera.setMaximumDistance( 1000 );



  camera.lookAt( 500, 200, 400); 

  agents = new ArrayList<Agent>(); //array van agents
  bomen= new ArrayList<Boom>();
  takken= new ArrayList<Tak>();
  buildings= new ArrayList<Building>();

 

  makeBuildings(numbBuildings); // Nu kunnen buildings en bomen nog overlappen


  makeAgents(numbAgents);

  makeTrees(numbBoom);
  
  rectMode(CENTER);
  setupGUI();
}

void draw() {

  background(255); 

  renderGUI();
  fill( 255 );
  stroke( 0 );
  rect( (width+d)/2, (height+d)/2, width+d, height+d );

  textSize(32);
  text("druk op spacebar voor flowlines, op 'r' voor reset agenten ", 10, 30); 
  text(" klik met muis voor extra boom, op 'p' voor extra agent", 10, 60);


  for (Boom b : bomen) {
    for (Agent v : agents) {


      PVector force= b.repel(v);  //alle agenten laten afgestoten worden door bomen
      v.applyForce(force);

      v.boundaries();
      v.wander();

      v.run();                //bomen en agenten afbeelden
      b.display();
    }
  }

  //takken tekenen tussen alle bomen en takken laten ouder worden(dikker)
  for (Tak t : takken) {
    t.addyear();
    t.display();
  }
  for (Building B : buildings) {

    B.display();
  }
}

void makeAgents(float amount) { //amount agenten aanmaken
  for (int i = 0; i<amount; i++) {       
    agents.add(new Agent(random(0, width), random(0, height)));
  }
}

void removeAgents() { //alle agenten verwijderen
  for (int i = agents.size()-1; i>=0; i--) { //reset agents
    agents.remove(i);
  }
}

void reset() {

  removeAgents();
  makeAgents(numbAgents);      //opnieuw random agenten aanmaken
  removeTrees();
  makeTrees(numbBoom);
  removeBuildings();
  makeBuildings(numbBuildings);
}







//een aantal (amount) random bomen plaatsen
void makeTrees(float amount) {

  for (int i = 0; i<amount; i++) {

    //eventueel op bepaalde lichtere kleuren (= open plekken) is er een mogelijkheid om een boom te zetten.
    //misschien moeten we hier wel een elegantere oplossing voor zoeken; bv op de 20 lichtste pixels een boom zetten,

    //en een andere, mss abstractere afbeelding zou ook mooi zijn, want nu gaan er ook bomen op de huizen enz staan.


    boomy = int (random(0, height));
    boomx = int (random(0, width));

    bomen.add(new Boom(boomx, boomy)); //bomen worden aangemaakt in klasse als repellers
  }
  for (int i = 0; i < bomen.size(); i++) {
    for (int j = 0; j < bomen.size(); j++) {
      if (i != j) {
        bomen.get(j).tak(bomen.get(i));
      }
    }
  }
}

void removeTrees() { //alle bomen verwijderen
  for (int i = bomen.size()-1; i>=0; i--) { 
    bomen.remove(i);
  }
  for (int i = takken.size()-1; i>=0; i--) { //reset agents
    takken.remove(i);
  }
}
void makeBuildings(float amount) {

  for (int i = 0; i<amount; i++) {  
    w=random(50,180);
    h=random(50,180);
    buildings.add(new Building(w,h,random(50,180) , random(w, width-w), random(h, height-h)));
  }
}
void removeBuildings() { //alle bomen verwijderen
  for (int i = buildings.size()-1; i>=0; i--) { 
    buildings.remove(i);
  }
}