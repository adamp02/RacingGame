

// processing documentation for rotating objects: https://processing.org/examples/rotate.html

class Car {


  PVector accel, velocity, position, camPos;

  PShape carShape;
  float direction;  // NOTE: Always use 'radians()' with this to make sure everything is pointing in the right direction
  float degrees;    // radians() version of 'direction'

  float currentSpeed; // TODO: pick better names for these variables
  float carSpeed;
  float turnSpeed;

  //int steering = 1; //(0 = L, 1 = M, 2 = R) // could be used in the future to apply effects / animations depending on where the player is steering

  boolean moveLeft, moveRight, moveUp, moveDown;

  PImage imag;


  // TODO: add a constructor that lets you initialize different stats for each car
  Car(float acceleration, float steering) {

    imag = loadImage("car1.png");
    
   // carSpeed = 0.45;
   carSpeed = acceleration;
   turnSpeed = steering; //3
    direction = 0;
    degrees = 0;

    accel = new PVector(0, 0);
    velocity = new PVector(0, 0);
    position = new PVector(width/2, height/2);
    camPos = new PVector(width/2 - 100, height/2);

    // create car boundary box
    rectMode(CENTER);
    fill(150, 150, 150);
    carShape = createShape(RECT, 0, 0, 40, 20);
    //carShape.texture(imag);
  }


  void show() {

    // Have to convert using radians() to make sure the rotations are accurate (i.e. they actually follow the vehicle's direction)
    // TODO: more descriptive variable name
    degrees = radians(direction);

    accel.set(0, 0); // have to reset each time, otherwise the vehicle will keep accelerating

    // if the player is accelerating...
    if (moveUp) {
      // increase the current acceleration by another acceleration force *in the car's current direction*
      accel.set(accel.x + (carSpeed * cos(degrees)), accel.y + (carSpeed * sin(degrees)));
    }

    // if the player is decelerating...
    if (moveDown) {
      // subtract acceleration force from the player's car
      velocity.sub(accel.x / 2, accel.y / 2);
    }

    position.add(velocity);
    velocity.add(accel);


    velocity.set(velocity.x * 0.96, velocity.y * 0.96);



    // Output the current speed of the object - Useful for speedometers and similar GUI elements
    currentSpeed = velocity.mag();
   // print("Current speed = " + currentSpeed + "\n");

    // https://processing.org/reference/resetMatrix_.html
    // This resets the object's identity whenever the object rotates
    // Without it, the object will keep spinning extremely fast
    carShape.resetMatrix();

    // Have to convert using radians() to make sure the rotations are accurate (i.e. they actually follow the vehicle's direction)
    carShape.rotate(radians(direction));

    // Draw shape at it's position
    shape(carShape, position.x, position.y);

    /*
    
     float rotation = direction % 360;
     
     if (rotation < 360 && rotation >= 180) {
     print("Player is pointing left!");
     } else {
     print("Player is pointing right!\n");
     }
     */

    // TODO: handbrake = faster ship turning direction, no accel (maybe add constant friction / braking if u handbrake?)
  }
  
  // called by the main sketch file to steer the car
  void turn(char turnDirection) {

    if (turnDirection == 'l') {
      direction -= turnSpeed;
    } else if (turnDirection == 'r') {
      direction += turnSpeed;
    }
  }
}
