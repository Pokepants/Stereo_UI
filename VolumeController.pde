class VolumeControl {
  Dial dial;
  Gain gain;
  AudioPlayer[] players;

  VolumeControl(AudioPlayer[] p, Dial d) {
    players = p;
    dial = d;
  }

  void update() {
    for (int i = 0; i < players.length-1; i++) { 

      if ( players[i].hasControl(Controller.GAIN) )
      {
        // map the mouse position to the audible range of the gain
        float val = map(dial.getSetting(), dial.max, dial.min, 6, -30);
        // if a gain control is not available, this will do nothing
        players[i].setGain(val);
      }
    }
  }
}
