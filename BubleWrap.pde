import processing.sound.*;

SoundFile file;
SoundFile pop;

float sampleDuration = 1;
float offset = 0;
boolean isPlaying = false;
float playStartTime = 0;

float bubbleSize = 40;
float bubblePadding = 10;

void setup (){
  size(810, 810);
  frame.setTitle("Bublé Wrap");
  file = new SoundFile(this, "song.mp3");
  pop = new SoundFile(this, "pop.wav");
  ellipseMode(CENTER);
}

float clickX = 0;
float clickY = 0;

void draw() {
  background(255);
  stroke(0);
  strokeWeight(3);
  
  if (isPlaying){
    if (millis() >= playStartTime + 1000*sampleDuration){
      stopSample();
    }
  }
  
  for (int y=0; y<height/(bubbleSize+bubblePadding); y++){
    for (int x=0; x<width/(bubbleSize+bubblePadding); x++){
      float xPos = x*(bubbleSize+bubblePadding)+bubblePadding+bubbleSize/2.0;
      float yPos = y*(bubbleSize+bubblePadding)+bubblePadding+bubbleSize/2.0;
      if (pow(clickX-xPos, 2) + pow(clickY-yPos, 2) < pow(bubbleSize/2.0, 2)){
        fill(66, 134, 244);
      } else {
        fill(186, 245, 255);
      }
      ellipse(xPos, yPos, bubbleSize, bubbleSize);
    }
  }
}

void mousePressed() {
  clickX = mouseX;
  clickY = mouseY;
  outerloop:
  for (int y=0; y<height/(bubbleSize+bubblePadding); y++){
    for (int x=0; x<width/(bubbleSize+bubblePadding); x++){
  
    
      float xPos = x*(bubbleSize+bubblePadding)+bubblePadding+bubbleSize/2.0;
      float yPos = y*(bubbleSize+bubblePadding)+bubblePadding+bubbleSize/2.0;
      if (pow(clickX-xPos, 2) + pow(clickY-yPos, 2) < pow(bubbleSize/2.0, 2)){
        pop.play();
        if (!isPlaying){
          playSample();
          break outerloop;
        }
      }
    }
  }
}


void playSample(){
  file.cue(offset);
  file.play();
  isPlaying = true;
  playStartTime = millis();
}

void stopSample() {
  file.stop();
  isPlaying = false;
  offset += (millis()-playStartTime)/1000.0;
}
