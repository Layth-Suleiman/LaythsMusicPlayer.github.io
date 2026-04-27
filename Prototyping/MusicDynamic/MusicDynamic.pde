import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// Global Variables
Minim minim;
AudioPlayer[] playList = new AudioPlayer[1];
AudioPlayer[] soundEffects = new AudioPlayer[1];

String songTitle = "Never";
float divX, divY, divW, divH;

void setup() {
  size(700, 500);
  
  // UI Layout for the "Div" on the right
  divW = 220; 
  divH = 70;
  divX = width - divW - 30;
  divY = 30;

  minim = new Minim(this);

  // Constructing paths (Using your directory structure)
  String musicPath = "../../Dependencies/Music/" + songTitle + ".MP3";
  String sfxPath = "../../Dependencies/SoundEffects/MouseClick.mp3";

  // Loading files
  playList[0] = minim.loadFile(musicPath);
  soundEffects[0] = minim.loadFile(sfxPath);

  // Safety check and Play
  if (playList[0] != null) {
    playList[0].play();
  } else {
    println("Error: Music file not found at " + musicPath);
  }
}

void draw() {
  // Render the "Div" to the right
  drawMusicDiv();
}

void drawMusicDiv() {
  // Container Box
  fill(35);
  stroke(255);
  strokeWeight(2);
  rect(divX, divY, divW, divH, 12);
  
  // Text content
  fill(255);
  textAlign(CENTER, CENTER);
  
  textSize(12);
  text("CURRENTLY PLAYING", divX + (divW/2), divY + 22);
  
  textSize(18);
  fill(0, 255, 100); // Neon green for the title
  text(songTitle, divX + (divW/2), divY + 45);
}
