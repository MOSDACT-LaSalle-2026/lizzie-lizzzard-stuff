import themidibus.*;  // import the library

MidiBus myBus;  // the MidiBus

void setup (){
  MidiBus.list();
  
  myBus = new MidiBus(this, "LPD8 mk2", "Java Sound Synthesizer"); // create a new MidiBus 

  
}

void draw(){
}
