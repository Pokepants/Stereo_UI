class MarqueeText {
  private int textSize = 28;
  private float spacing = textSize*0.35;
  private String message = "Replace this message!";
  private String [] msg;
  private PVector[] msgPos;
  private float msgSpeed = 2;
  private float yPos = 200;
  private float rMargin = 700;
  private float lMargin = 100;
  private color msgColor = color (200, 0, 150);  

  //you can call this constuctor but then you will need to call functions below to 
  //access the features
  MarqueeText() {
    init();
  }

  MarqueeText(String m, float s, int siz) {
    message = m;
    textSize = siz;
    msgSpeed = s;
    init();
  }

  private void init() {
    textAlign(CENTER, CENTER);
    textSize(textSize);
    msg = message.split("");
    createLetterPositions();
  }

  private void createLetterPositions() {
    msgPos = new PVector[msg.length];
    for (int i = 0; i < msg.length; i++) {
      int index = msg.length - i - 1; //start with the back end
      float startPos = lMargin;
      if (msgSpeed < 0) {
        //index = i;
        index = i;
        startPos = rMargin;
      }   
      msgPos[index] = new PVector(startPos - (50+ i * spacing)*abs(msgSpeed*2)/msgSpeed, yPos);
    }
  }

  void setText(String m) {
    message = m;
    msg = message.split("");
    createLetterPositions();
  }

  void setSize(int siz){
    textSize = siz;
    createLetterPositions();
  }
  
  void setYPos(float y) {
    for (int i = 0; i < msg.length; i++) {  
      msgPos[i].y =  y;
    }
  }

  void setColor(color c) {
    msgColor = c;
  }

  void setLMargin(float l) {
    lMargin = l;
    createLetterPositions();
  }

  void setRMargin(float r) {
    rMargin = r;
    createLetterPositions();
  }

  //set the speed + to go left to right and negative to do the opposite
  void setSpeed(float s) {
    msgSpeed = s;
    createLetterPositions();
  }

  void update() {

    fill(msgColor);
    for (int i = 0; i < msg.length; i++) {  

      msgPos[i].x +=  msgSpeed;
      if (msgSpeed > 0) {
        if (msgPos[i].x > rMargin - textSize/5) {
          msgPos[i].x = lMargin-msg.length*spacing*msgSpeed;
        }
        if (msgPos[i].x > lMargin) {
          text(msg[i], msgPos[i].x, msgPos[i].y);
        }
      } else if (msgSpeed < 0) {
        if (msgPos[i].x < lMargin + textSize/5) {
          msgPos[i].x = rMargin-msg.length*spacing*msgSpeed;
        }
        if (msgPos[i].x < rMargin) {
          text(msg[i], msgPos[i].x, msgPos[i].y);
        }
      }
    }
  }
}
