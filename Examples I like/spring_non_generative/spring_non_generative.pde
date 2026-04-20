/*
Nombre: Payaso 02
 Segunda versión del sketch payaso que utiliza las oscilaciones
 de los valores del seno  y el concepto de PopMatrix y PUpMatrix de apilar y desapilar
 Fecha: Marzo 2009, Barcelona.
 Autor: Alba G. Corral.
 Licencia: open source.
 */
/*
Non generative -
 It is when an artist take  direct control over the process
 An artist that chooses to constrain themselves by only working with white and using that to determine the pixel's color would not be incorporating an autonomous system into their work
 This practice would not be generative because the "system" that chose the color was the brain of the artist and not external; the artist maintained control throughout.
 */
float velocidad = 0.05;//incremento de angulo
float dim;//diametro 
float RESISTENCIA ;
float NUM_TALLOS = 5;
int longitud ;
float inc= 4;
void setup() {
  size(800, 800);//tam. del sketch
  dim = width/200;//diametro
  longitud=width/3;//diametro
  RESISTENCIA = width/20;
  smooth();//suavizado
  background(255);//pintamos de negro el fondo
}
void draw() {
  //background(255);//pintamos de negro el fondo
  //this is cause pasjfkjlskfjalkfs
  translate(width/2, height/2);//trasladamos las coordenadas a la mitad de la pantalla
  inc += velocidad;//incrementamos el valor del radio
  float angle = sin(inc) / RESISTENCIA;//calculamos el angulo
  //dibuja una ellipse con ancho > dim y alto > dim. en la posicion de coordenadas 0,0

  for (int i = 0; i < NUM_TALLOS; i++) {//loop que va desde 0 hasta 8, aumentando uno
    //llamamos a la funcion tallo con los parametros de entrada
    //float x> posicion horizontal,float y> posicion vertical, int longitud, float angle>angulo
    tallo(0, -dim/2, longitud, angle);
    rotate(TWO_PI/NUM_TALLOS);//vamos rotando
  }
  ellipse(0, 0, angle, angle);
 // if (velocidad > 10) inc = inc * -1;;
   

}
void tallo(float x, float y, int longitud, float angle) {
  pushMatrix();
  translate(x, y);
  for (int i = longitud; i > 0; i--) {
    strokeWeight(i/150);
    stroke(0, 30);//seleccionamos el color del borde > 255, blanco
    line(0, 0, 0, -4);//dibujamos una linea con punto inicial (0,0) y punto final(0-4)
    strokeWeight(i/10);//Ancho del borde
    stroke(200, 50, 0, 2);
    line(0, 0, -10, 0);//dibujamos una linea con punto inicial (0,0) y punto final(4-0)

    translate(0, -4);
    rotate(angle);
  }
  popMatrix();
}
