/*

 AS5 - Milestone 2
 By: Adam Prochazka
 Student ID: 991613655
 
 
 */

// The 'star' arrays from AS3 will be heavily upgraded / replaced to create an ambient particle system
//star[] starsA = new star[40];

ArrayList<Car> cars = new ArrayList<Car>();

Car playerCar, playerCar2, playerCar3;


PShape rocks, rocket, rocket2, rocket3, tower, car, road;

int test = 255;

// declare booleans to check which direction the player is moving in
boolean pressRight, pressLeft, pressUp, pressDown;

boolean gameOver = false;

int currentScreen;

float easeX;
float easeY;
float easing = 0.09;

float camFly, cF2, cF3;

PImage car1, car2, car3, track1, track2, track3, arrow1, arrow2, arrow3, screen1, screen2, screen3, screen4, img, txtr, startMsg, startMsg2;

int carSelected;
int trackSelected;

// TIMER STUFF:

float lastTime;
float timeCount; // how long until the timer updates --> 1000ms = 1 
float seconds;

Checkpoint cpdemo;

//Arcade Cabinet Specs
// 1280 x 1024 resolution

void setup() {
  
  lastTime = millis();
  timeCount = 1000;
  seconds = 30;
  
  println("Loading...\n");
  size(1280, 960, P3D);
  //fullScreen(P3D);
  camFly = 400;
  cF2 = 100;
  cF3 = 750;
  //img = loadImage("rect286.png");
  screen1 = loadImage("screen1.png");
  screen2 = loadImage("screen2.png");
  screen3= loadImage("screen3.png");
  screen4 = loadImage("screen4.png");
  startMsg = loadImage("startMsg.png");
  startMsg2 = loadImage("startMsg2.png");
  arrow1 = loadImage("arrow1.png");
  arrow2 = loadImage("arrow2.png");
  arrow3 = loadImage("arrow3.png");
  car1 = loadImage("car1.png");
  car2 = loadImage("car2.png");
  car3 = loadImage("car3.png");
  track1 = loadImage("track1.png");
  track2 = loadImage("track2.png");
  track3 = loadImage("track3.png");

  img = loadImage("freeway.png");

  currentScreen = 1;
  carSelected = 1;
  trackSelected = 1;

  pressUp = false;
  pressDown = false;
  pressRight = false;
  pressLeft = false;

  frameRate(60);
  tower = loadShape("tower.obj");
  car = loadShape("sedanSports.obj");
  rocks = loadShape("rockFormationLarge.obj");
  //car = loadShape("r5.obj");



  txtr = loadImage("newPalette.png");
  // road = loadShape("Road.obj");
  //road.setTexture(txtr); //attach texture to the 3D shape
  //road.rotateX(-1.5);



  //road.scale(20);
  //car.scale(10);
  // car.rotateX(1.5);

  //car.rotateX(-0.75);

  playerCar = new Car(0.45, 3);     //create the player car
  playerCar2 = new Car(0.5, 3.5);
  playerCar3 = new Car(0.4, 2.5);

  cars.add(playerCar);
  cars.add(playerCar2);
  cars.add(playerCar3);

  //ortho();
  //ortho(-width/2, width/2, -height/2 - (100), height/2 + (100));
  noStroke();

  println("All assets loaded!\n");

  // TODO: make a load() function instead of putting everything here
  
  cpdemo = new Checkpoint(10, 100, 100, 0, 0);
  
}

void updateTimer() {
 
  if (millis() > lastTime + timeCount) {
   lastTime = millis(); 
   seconds--;
  }
  
}


void draw() {


  rectMode(CENTER);
  background(20, 10, 35);
  background(50, 50, 50);
  noTint();

  // SPLASH SCREEN
  if (currentScreen == 1) {
    camera(0, 0, ((height/2.0) / tan(PI*30.0 / 180.0)), 0, 0, 0, 0, 1, 0);

    image(screen1, -width/2, -height/2, 1280, 1024);

    tint(255, 255, 255, 155 + 100 * sin(0.2 * frameCount / 3));
    image(startMsg, -width/2, -height/2 + 800);
  }

  // 'SELECT CAR' SCREEN
  if (currentScreen == 2) {
    camera(0, 0, ((height/2.0) / tan(PI*30.0 / 180.0)), 0, 0, 0, 0, 1, 0);

    image(screen2, -width/2, -height/2, 1280, 1024);

    if (carSelected == 1) {
      image(arrow1, -width/2, -height/2 + 400);
      image(car1, -width/2, -height/2 + 300);
    } else if (carSelected ==2) {
      image(arrow2, -width/2, -height/2 + 400);
      image(car2, -width/2, -height/2 + 300);
    } else if (carSelected == cars.size()) {
      image(arrow3, -width/2, -height/2 + 400);
      image(car3, -width/2, -height/2 + 300);
    }

    tint(255, 255, 255, 155 + 100 * sin(0.2 * frameCount / 3));
    image(startMsg2, -width/2, -height/2 + 800);
  }

  // 'SELECT TRACK' SCREEN
  if (currentScreen == 3) {
    camera(0, 0, ((height/2.0) / tan(PI*30.0 / 180.0)), 0, 0, 0, 0, 1, 0);
    image(screen3, -width/2, -height/2, 1280, 1024);

    if (trackSelected == 1) {
      image(arrow1, -width/2, -height/2 + 400);
      image(track1, -width/2, -height/2 + 300);
    } else if (trackSelected ==2) {
      image(arrow2, -width/2, -height/2 + 400);
      image(track2, -width/2, -height/2 + 300);
    } else {
      image(arrow3, -width/2, -height/2 + 400);
      image(track3, -width/2, -height/2 + 300);
    }

    tint(255, 255, 255, 155 + 100 * sin(0.2 * frameCount / 3));
    image(startMsg2, -width/2, -height/2 + 800);
  }

  // CONTROLS SCREEN
  if (currentScreen == 4) {
    camera(0, 0, ((height/2.0) / tan(PI*30.0 / 180.0)), 0, 0, 0, 0, 1, 0);
    image(screen4, -width/2, -height/2, 1280, 1024);

    tint(255, 255, 255, 155 + 100 * sin(0.2 * frameCount / 3));
    image(startMsg, -width/2, -height/2 + 800);
  }

  // GAMEPLAY
  if (currentScreen == 5) {


    
    image(img, -width/2, -2800, 3500, 3500); // placeholder 2D track - doesn't match the final artstyle
    cpdemo.show();
    
     shape(rocks, cpdemo.checkPos.x + 50, cpdemo.checkPos.y + 50);
  rocks.resetMatrix();
  rocks.scale(150);
  rocks.rotateX(1.57);
  //car.rotate(radians(cars.get(carSelected-1).direction + 90));
    
    
    boolean gotCheck = cpdemo.carCollision(cars.get(carSelected - 1).position);
    if (gotCheck && cpdemo.enabled) {
     
      
      print("GOT CHECK ");
      cpdemo.enabled = false;
      seconds+=cpdemo.checkTime;
      
      cars.get(carSelected - 1).velocity.mult(-1); // good collision! // No
                                                   // have some multiply everything by -1, some only X, some only Y
      
    }
    
    
    // TO-DO: create an empty Car object that holds the 'cars.get(carSelected-1)' obj instead of constantly calling that
    // or call function that sends obj ref?
    
    fill(255);
    textSize(20);
    text(int(seconds), cars.get(carSelected - 1).position.x, cars.get(carSelected - 1).position.y + 50);
    updateTimer();
    
    
    fill(255);
  textSize(20);
  text("FPS: " + frameRate, cars.get(carSelected - 1).position.x - 50, cars.get(carSelected - 1).position.y + 100);

    cars.get(carSelected - 1).show();
   // print("CarSelected = " + carSelected + "\n");


    if (trackSelected == 2) {
      cars.get(carSelected - 1).position.set(0, 0);
    }

    

    float currentCarSpeed = getCarSpeed(cars.get(carSelected-1));
    //print("Current speed = " + currentCarSpeed + "\n");

    if (cF2 >0) {
      cF2 -=0.5;
    }

    if (cF3 > 0) { // 0 or 400
      cF3 -=2;
    }

    camera(easeX, easeY, ((height/2.0) / tan(PI*30.0 / 180.0)) - cF3, easeX, easeY, 0, 0, 1, 0);
    // should use position.x/y until it gets to the final 2D position -- otherwise it 'snaps' to the position as everything loads

    if (pressRight) {
      cars.get(carSelected-1).turn('r');
      cars.get(carSelected-1).moveRight = true;
    }

    if (pressUp) {
      cars.get(carSelected-1).moveUp = true;
    }

    if (pressDown) {
      cars.get(carSelected-1).moveDown = true;
    }

    if (pressLeft) {
      cars.get(carSelected-1).turn('l');
      cars.get(carSelected-1).moveLeft = true;
    }
    
   
    
  }





 

  float targetX = cars.get(carSelected-1).position.x;
  float dx = targetX - easeX;
  easeX += dx * easing;

  float targetY = cars.get(carSelected-1).position.y;
  float dy = targetY - easeY;
  easeY += dy * easing;






  // GUI & P3D tests (used for debugging and testing only):

  // Speedometer placement test
  //fill (255, 0, 0);
  //rect(easeX - (width/2), easeY - (height/2), 50, 50);

  // shape(tower, 20, 220);
  //tower.rotateY(0.025);

  // directionalLight(255, 255, 255, 0, -1, -2);
  // directionalLight(155, 155, 200, 2, 0, 0);

   shape(car, cars.get(carSelected-1).position.x, cars.get(carSelected-1).position.y);
  //car = loadShape("sedanSports.obj"); // this resets it to 0 at all times, but there has to be a better way apart from loading it?
  // vv YES THERE IS :D
  car.resetMatrix();
  car.scale(15);
  car.rotateX(1.57);
  car.rotate(radians(cars.get(carSelected-1).direction + 90));

  // animates the car bumping on uneven ground. rate of bumping is determined by the car's magnitude (faster = more erratic shaking)
   car.rotateY(random(-0.05 * (cars.get(carSelected-1).currentSpeed * 0.1), 0.05 * (cars.get(carSelected-1).currentSpeed * 0.1))); //shaking on gravel
   car.rotateX(random(-0.01 * (cars.get(carSelected-1).currentSpeed * 0.1), 0.05 * (cars.get(carSelected-1).currentSpeed * 0.1)));


  //shadow
  //fill(0, 75);
  //rect(playerCar.shipPosition.x, playerCar.shipPosition.y, 45, 30);
}

float getCarSpeed(Car car) {
  return car.velocity.mag();
}


// Cutscene code from AS3, will be modified into a function that can fade in or fade out at any time.

/*
// display the opening Star Wars cutscene
 void openingCutscene() {
 
 // black background - starts at alpha = 400 and fades out
 fill(0, 400 - frameCount * 1.2);
 rect(0, 0, width, height);
 
 
 // black foreground - placed over other fading elements to make it look like the above text is fading in
 fill(0, 300 - frameCount * 2.5);
 rect(0, 0, width, height);
 } */


// Handle player input
void keyPressed() {


  if (key == ' ' || key == '1') {
    if (currentScreen < 5) {
      currentScreen++;
    }
  }

  if (key == 'd' || key == CODED && keyCode == RIGHT) {

    if (currentScreen == 2 && carSelected < 3) {
      carSelected++;
    } else if (currentScreen == 3 && trackSelected < 3) {
      trackSelected++;
    }


    pressRight = true;
  }

  if (key == 'w' || key == CODED && keyCode == UP || key == 'x') {
    pressUp = true;
  }

  if (key == 'a' || key == CODED && keyCode == LEFT) {

    if (currentScreen == 2 && carSelected > 1) {
      carSelected--;
    } else if (currentScreen == 3 && trackSelected > 1) {
      trackSelected--;
    }

    pressLeft = true;
  }

  if (key == 's' || key == CODED && keyCode == DOWN || key == 'z') {
    pressDown = true;
  }
}

// TODO: since the arcade stick maps to the arrow keys, make sure the player can't accidentally hit 'up' while accelerating
//       otherwise they'll instantly stop the car
void keyReleased() {


  if (key == 'd' || key == CODED && keyCode == RIGHT) {
    pressRight = false;
    cars.get(carSelected-1).moveRight = false;
  }

  if (key == 'w' || key == CODED && keyCode == UP || key == 'x') {
    pressUp = false;
    cars.get(carSelected-1).moveUp = false;
  }

  if (key == 'a' || key == CODED && keyCode == LEFT) {
    pressLeft = false;
    cars.get(carSelected-1).moveLeft = false;
  }

  if (key == 's' || key == CODED && keyCode == DOWN || key == 'z') {
    pressDown = false;
    cars.get(carSelected-1).moveDown = false;
  }
}
