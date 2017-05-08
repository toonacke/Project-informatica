
float GUIy=150;

boolean deformMesh = false;
boolean strutss=true;

float numDivisionsWidth=10;
float numDivisionsDepth=10;
float frameWeight=4;
float spaceBetween=50;
float t;
Boolean extraAgent;
Boolean reset;
void setupGUI() {

  control = new ControlP5(this);
  control.setAutoDraw(false);




  //control.addSlider("numDivisionsWidth")
  //  .setPosition(50, 50)
  //  .setRange(0, 20)

  //  ;


  //control.addSlider("numDivisionsDepth")
  //  .setPosition(250, 50)
  //  .setRange(0, 20)

  //  ;


 


  control.addButton("addTree")  //zelf boom plaatsen en takken aanmaken tussen nieuwe boom en alle oude bomen


    .setPosition(450, 100)
    .setSize(50, 20)

    ;

  control.addButton("resetall")
    .setPosition(50, 100)
    .setSize(50, 20)
    ;
  control.addButton("addAgent")
    .setPosition(450, 50)
    .setSize(50, 20)
    ;
}

public void addAgent() {
  println("addAgent");

  makeAgents(1);

}

public void addTree() {
  println("addtree");

  makeTrees(1);

}

public void resetall() {
  println("reset");
  reset();
}
void renderGUI()
{
  camera.beginHUD();

  // draw background
  noStroke();
  fill( 0, 128 );
  rect( width/2, GUIy/2, width, GUIy );

  control.draw();
  camera.endHUD();
}