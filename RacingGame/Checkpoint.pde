
// 'Star' class from AS3
// Currently a placeholder until it gets replaced with a more robust and reusable particle system

class Checkpoint {

  PVector checkPos;

  float speed;
  float checkWidth;
  float checkLength;

  float checkTime;

  boolean enabled; // when the player drives through a check, disable it so they don't get extra time.
  // REMEMBER TO RE-ENABLE EVERY CHECK AT THE START OF EACH RACE!!!

  // the type determines if it's a foreground or background star
  // 'a' = background star = smaller, dimmer, slower
  // 'b' = foreground star = bigger, brighter, faster
  char type;

  // constructor
  Checkpoint(float time, float sizeX, float sizeY, float posX, float posY) {

    checkTime = time;
    checkLength = sizeX;
    checkWidth = sizeY;
    checkPos = new PVector(posX, posY);

    enabled = true;
  }

  // draw the star every frame
  void show() {

    noStroke();

    fill(255, 0, 0);
    // draw the star and move it every frame
    if (enabled) {
      rectMode(CORNER);
        rect(checkPos.x, checkPos.y, checkLength, checkWidth);
        rectMode(CENTER);
    }
  }

  boolean carCollision(PVector carPos) {

    //for (int i = 0; i < player.boundingBoxCoordinates.length; i++) {

    // if a [bounding box coordinate] is currently [within debris], it counts as a collision
    if (carPos.x >= checkPos.x
      && carPos.x <= checkPos.x + checkLength
      && carPos.y <= checkPos.y + checkWidth
      && carPos.y >= checkPos.y) {

      // car is currently in checkpoint

      //enabled = false;
      // add time to checkpoint timer

      return true;
    } else {
      return false;
    }
  }
  
  
}
