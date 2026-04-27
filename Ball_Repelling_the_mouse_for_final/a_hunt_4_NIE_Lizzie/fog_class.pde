
class fog {
  PGraphics fog;
  int cfog;

  fog(int cback) {
    fog = createGraphics(width, height, JAVA2D);    
    fog.beginDraw();
    fog.endDraw();
    
    cback = 0;
    cfog = 255-cback;
    background(cback);
  }

  // This function goes through each pixel of the screen and adds the fog pixel 
  // by calling the fbm funtion. 
  // fogAmt - fog amount: 100 little, 140 medium, 180 large
  // turbAmt - turbulence amount. 0.2: smooth fog, 0.4: realistic, 0.8: stormy fog
  // fogScale: size of clouds.  0.002: smaller clouds, 0.001: bigger smoother clouds
  

  void drawFog(float t, float fogAmt, float turbAmt, float fogScale) {
    
    tint(255, 180);
    image(fog, 0, 0);
    noTint();
   
    fog.beginDraw();
    fog.loadPixels();
    
    float yoff = t;
    for (int y = 0; y < fog.height; y++) {
      float xoff = 0;
      for (int x = 0; x < fog.width; x++) {
    
        float base = fbm(xoff, yoff);
        float turb = turbulence(xoff * 2.0, yoff * 2.0);
    
        float n = base + turbAmt * turb;
    
        float a = map(n, 0, 2.0, 0, fogAmt);
    
        fog.pixels[y*fog.width + x] = color(255, a);
    
        xoff += fogScale;
      }
      yoff += fogScale;
    }
    
    fog.updatePixels();
    fog.endDraw();
  }
  
  
  
  // This is a function I found to create a Fractal Brownian Motion
  // The idea is of this remix is to use it as opening or closing frames of a work.
  float fbm(float x, float y) {
    float total = 0;
    float amplitude = 1;
    float frequency = 1;
  
    for (int i = 0; i < 5; i++) {   // 5 octavas = niebla muy realista
      total += noise(x * frequency, y * frequency) * amplitude;
      frequency *= 2.0;
      amplitude *= 0.5;
    }
  
    return total;
  }
  
  float turbulence(float x, float y) {
    float total = 0;
    float amplitude = 1;
    float frequency = 1;
  
    for (int i = 0; i < 5; i++) {
      float n = noise(x * frequency, y * frequency);
      total += abs(n * 2.0 - 1.0) * amplitude;  // ← valor absoluto = turbulencia
      frequency *= 2.0;
      amplitude *= 0.5;
    }
  
    return total;
  }
  
}
