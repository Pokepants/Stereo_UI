import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioMetaData[] meta;
AudioPlayer[] players;
Dial dial;
VolumeControl volumeControl;
MarqueeText text;

PVector mouse, buttonSize;
PVector []buttonPos;
boolean rewind;
int numFiles = 5;
int numButtons = 7;
int val =  0;
float dx = 430;
float dy = 300;
float dw = 560;
float dh = 100;

void setup() {

  size (800, 600);
  rectMode(CENTER);
  textAlign (CENTER, CENTER);

  mouse = new PVector();
  minim = new Minim(this);
  players= new AudioPlayer[numFiles];
  buttonPos = new PVector[numButtons];
  buttonSize = new PVector(80, 30);
  dial = new Dial(0, 10, 10, false);
  meta = new AudioMetaData[5];

  dial.toggleValueDisplay();
  dial.toggleTitleDisplay();


  for (int i = 0; i < numFiles; i++) {
    players[i] = minim.loadFile(i + ".mp3");
    meta[i] = players[i].getMetaData();
  }
  for (int i = 0; i < numButtons; i++) {
    buttonPos[i] = new PVector(160*i/2+190, 400);
  }
  text = new MarqueeText("", -1, 50);

  text.setColor(0);
  text.setLMargin(dx-dw/2);
  text.setRMargin(dx+dw/2);

  volumeControl = new VolumeControl (players, dial);
} 

void button() {
  for (int i = 0; i < buttonPos.length; i++) {
    strokeWeight(1);
    fill(255, 255, 255, 255);
    rect(buttonPos[i].x, buttonPos[i].y, buttonSize.x, buttonSize.y);
  }
}

void mouseClicked() {
  if ( abs( mouse.x - buttonPos[0].x) < buttonSize.x/2 && abs(mouse.y - buttonPos[0].y) < buttonSize.y/2 ) {
    players[val].play();
  }
  if ( val > 0  && abs(mouse.x - buttonPos[1].x) < buttonSize.x/2 && abs(mouse.y - buttonPos[1].y) < buttonSize.y/2 ) {
    players[val].pause();
  }
  if ( val < numFiles-1 && abs(mouse.x - buttonPos[2].x) < buttonSize.x/2 && abs(mouse.y - buttonPos[2].y) < buttonSize.y/2 ) {
    rewind = true;
    while (rewind){
     players[val].
    }
  }
  if ( abs(mouse.x - buttonPos[3].x) < buttonSize.x/2 && abs(mouse.y - buttonPos[3].y) < buttonSize.y/2 ) {
  }
  if ( abs(mouse.x - buttonPos[4].x) < buttonSize.x/2 && abs(mouse.y - buttonPos[4].y) < buttonSize.y/2 ) {
    players[val].pause();
    for ( int i = 0; i < numFiles; i++ ) {
      players[i].rewind();
    }
    val++;
    players[val].play();
  }
  if ( abs(mouse.x - buttonPos[5].x) < buttonSize.x/2 && abs(mouse.y - buttonPos[5].y) < buttonSize.y/2 ) {
    players[val].pause();
    for (int i = 0; i < numFiles; i++) {
      players[i].rewind();
    }
    val = 0;
  }
  if ( abs(mouse.x - buttonPos[6].x) < buttonSize.x/2 && abs(mouse.y - buttonPos[6].y) < buttonSize.y/2 ) {
    players[val].pause();
    for ( int i = 0; i < numFiles; i++ ) {
      players[i].rewind();
    }
    val--;
    players[val].play();
  }

  text.setText(meta[val].title() + " by " + meta[val].author() );
  text.setYPos(dy);
}

void display() {
  rect(dx, dy, dw, dh);
  fill (100);
  rectMode(CORNER);
  for (int i = 0; i < players[val].bufferSize() - 1; i++) {
    float x1 = map( i, 0, players[val].bufferSize(), dx-dw/2, dx + dw/2 );
    float x2 = map( i + 1, 0, players[val].bufferSize(), dx-dw/2, dx + dw/2 );
    rect( x1, dy + dh/2, x2 - x1, -abs(players[val].mix.get(i) * dh) );
  }
  rectMode(CENTER);
}

void auto() {
  if ( players[val].position() == meta[val].length() && val < 4) {
    val++;
    players[val].play();
  }
}

void draw() {
  background(255);

  mouse = new PVector(mouseX, mouseY);

  dial.update(mouse);
  volumeControl.update();
  auto();
  button();
  display();
  textSize(20);
  text.update();
}
