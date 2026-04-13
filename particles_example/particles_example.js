let particles = [];

function setup() {
  createCanvas(600, 800);
  noStroke();
  blendMode(ADD);

  // Initialize particles
  for (let i = 0; i < 100; i++) {
    particles.push(new Particle(random(width), random(height)));
  }
}

function draw() {
  background(0, 10); // Fading background effect

  // Move and display particles
  for (let i = particles.length - 1; i >= 0; i--) {
    let p = particles[i];
    p.move();
    p.display();
    
    // Remove particles that go off-screen
    if (p.isOffscreen()) {
      particles.splice(i, 1);
    }
  }

  // Add new particles at the mouse position
  if (mouseIsPressed) {
    particles.push(new Particle(mouseX, mouseY));
  }
}

class Particle {
  constructor(x, y) {
    this.pos = createVector(x, y);
    this.vel = createVector(random(-2, 2), random(-2, 2));
    this.acc = createVector();
  //  this.size = random(5, 15);
    this.size = 2;
    this.color = color(random(255), random(255), random(255), 300);
  }

  move() {
    // Apply Perlin noise to create a swirling motion
    let angle = noise(this.pos.x * 0.005, this.pos.y * 0.005) * TWO_PI * 10;
    let force = p5.Vector.fromAngle(angle);
    force.mult(0.2);
    this.acc.add(force);

    // Update position and velocity
    this.vel.add(this.acc);
    this.pos.add(this.vel);
    this.acc.mult(0);

    // Add some friction
    this.vel.mult(0.97);
  }

  display() {
    fill(this.color);
    ellipse(this.pos.x, this.pos.y, this.size, this.size);
  }

  isOffscreen() {
    return (
      this.pos.x < -this.size ||
      this.pos.x > width + this.size ||
      this.pos.y < -this.size ||
      this.pos.y > height + this.size
    );
  }
}
