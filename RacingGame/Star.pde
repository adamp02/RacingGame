
// 'Star' class from AS3
// Currently a placeholder until it gets replaced with a more robust and reusable particle system

class star {

  PVector v1, v2;

  float speed;
  float starX;
  float starY;
  float starWidth;
  float starLength;

  // the type determines if it's a foreground or background star
  // 'a' = background star = smaller, dimmer, slower
  // 'b' = foreground star = bigger, brighter, faster
  char type;

  // constructor
  star(char starType) {

    // check which type of star it is (background = 'a', foreground = 'b' or else)
    // randomize the position
    if (starType == 'a') {
      type = 'a';
      speed = random(-0.2, -0.05);

      starX = random(0, 600);
      starY = random(0, 400);
      starWidth = 5;
      starLength = 5;

      fill(255, 255, 255, 50);
      v1 = new PVector(starX, starY);
      v2 = new PVector(speed, 0);
    } else {

      type = 'b';

      speed = random(-0.6, -0.45);

      starX = random(0, 600);
      starY = random(20, 380);
      starWidth = 7;
      starLength = 7;

      fill(255, 255, 255, 100);
      v1 = new PVector(starX, starY);
      v2 = new PVector(speed, 0);
    }
  }

  // draw the star every frame
  void show() {

    noStroke();

    // make the star dimmer if it's in the background, or brighter if it's in the foreground
    if (type == 'a') {
      fill(255, 50);      
    } else {
      fill (255, 150);
    }

    // draw the star and move it every frame
    rect(v1.x, v1.y, starLength, starWidth);
    move();

    // wrap the star around the screen if it goes off-screen
    if (v1.x <= -20)
    {
      wrapStar();
    }
  }

  // wrap the star around the screen if it goes off-screen
  void wrapStar() {
    
    v1.x = width;
    
  }


  // move the star every frame
  void move() {
    v1.add(v2);
  }
}
