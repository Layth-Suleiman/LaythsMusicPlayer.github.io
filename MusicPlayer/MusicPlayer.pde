/* Layths's Music App, Final Project */

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import java.io.File;
import java.io.FilenameFilter;

// Music Variables
Minim minim;
AudioPlayer song;
AudioPlayer click;

String songTitle = "";
StringList playList;
int currentSongIndex = 0;
String absoluteMusicPath = "";

// App Variables
float AppWidth, AppHeight, GUIWidth, GUIHeight;

float edgePadding, innerPad;

float leftX, leftW, leftH;
float leftSectionW, leftTopH, leftSmallH;

float midX, midW;

float rightX, rightW;

float squareSize, squareX, squareY;

float totalAvailableW, gap, sectionW, sectionH, sectionY;

void setup() {

  fullScreen();

  background(240);

  rectMode(CORNER);
  ellipseMode(CENTER);

  // -------------------------
  // MUSIC DIRECTORY SCANNING
  // -------------------------
  minim = new Minim(this);
  playList = new StringList();
  
  // Try 3 different ways to locate your music folder path
  String[] pathChoices = {
    sketchPath("../../Dependencies/Music/"),
    sketchPath("../Dependencies/Music/"),
    sketchPath("data/") 
  };
  
  File folder = null;
  for (String path : pathChoices) {
    File checkFolder = new File(path);
    if (checkFolder.exists() && checkFolder.isDirectory()) {
      folder = checkFolder;
      absoluteMusicPath = path;
      break;
    }
  }
  
  // Scan the folder if found
  if (folder != null) {
    println("SUCCESS: Found music folder at: " + absoluteMusicPath);
    String[] files = folder.list(new FilenameFilter() {
      public boolean accept(File dir, String name) {
        return name.toLowerCase().endsWith(".mp3");
      }
    });
    
    if (files != null && files.length > 0) {
      for (String file : files) {
        println("FOUND AUDIO FILE: " + file);
        // Save the clean display title (without .mp3)
        String cleanName = file.substring(0, file.lastIndexOf('.'));
        playList.append(cleanName);
      }
    }
  }

  // Fallback protection if zero files were scanned
  if (playList.size() == 0) {
    println("WARNING: No music folder found. Defaulting to 'Never'.");
    playList.append("Never"); 
  }

  songTitle = playList.get(currentSongIndex);
  loadTrack(songTitle);

  String clickPath = "../../Dependencies/SoundEffects/MouseClick.mp3";
  click = minim.loadFile(clickPath);

  // -------------------------
  // GUI SIZES
  // -------------------------
  AppWidth = width;
  AppHeight = height;

  GUIWidth = 1920;
  GUIHeight = 1080;

  edgePadding = AppHeight * 50 / GUIHeight;
  innerPad = AppWidth * 10 / GUIWidth;

  // LEFT SIDE
  leftX = AppWidth * 50 / GUIWidth;
  leftW = AppWidth * 400 / GUIWidth;
  leftH = AppHeight * 980 / GUIHeight;

  leftSectionW = leftW - (innerPad * 2);

  leftTopH = AppHeight * 300 / GUIHeight;

  leftSmallH = (leftH - leftTopH - (innerPad * 11)) / 7.5;

  // MIDDLE
  midX = AppWidth * 500 / GUIWidth;
  midW = AppWidth * 620 / GUIWidth;

  // RIGHT SIDE
  rightX = AppWidth * 1170 / GUIWidth;
  rightW = AppWidth * 700 / GUIWidth;

  // BIG SQUARE
  squareSize = rightW - 100;

  squareX = rightX + (squareSize / 11);
  squareY = edgePadding + (squareSize / 4);

  // BUTTONS
  totalAvailableW = rightW - (innerPad * 2);

  gap = AppWidth * 5 / GUIWidth;

  sectionW = (totalAvailableW - (gap * 10)) / 11;

  sectionH = AppHeight * 60 / GUIHeight;

  sectionY = (edgePadding + leftH) - sectionH - innerPad;
}

// Helper utility to switch tracks cleanly across case-sensitive file naming systems
void loadTrack(String title) {
  if (song != null) {
    song.close();
  }
  
  // Try loading directly from our discovered folder if we found one
  if (!absoluteMusicPath.equals("")) {
    File lowerCheck = new File(absoluteMusicPath + title + ".mp3");
    if (lowerCheck.exists()) {
      song = minim.loadFile(absoluteMusicPath + title + ".mp3");
    } else {
      song = minim.loadFile(absoluteMusicPath + title + ".MP3");
    }
  } 
  
  // Fallback to original hardcoded relative path format if automatic detection missed
  if (song == null) {
    String lowercasePath = "../../Dependencies/Music/" + title + ".mp3";
    String uppercasePath = "../../Dependencies/Music/" + title + ".MP3";
    File lowFile = new File(sketchPath(lowercasePath));
    if (lowFile.exists()) {
      song = minim.loadFile(lowercasePath);
    } else {
      song = minim.loadFile(uppercasePath);
    }
  }
  
  if (song != null) {
    song.play();
  }
}

void draw() {

  background(240);

  fill(255);
  stroke(0);
  strokeWeight(2);

  // -------------------------
  // LEFT BOX
  // -------------------------
  rect(leftX, edgePadding, leftW, leftH);

  rect(
    leftX + innerPad,
    edgePadding + innerPad,
    leftSectionW,
    leftTopH
  );

  // Render the playlist slots with titles dynamically populated
  for (int i = 0; i < 8; i++) {
    float boxY = edgePadding + innerPad + leftTopH + innerPad + (i * (leftSmallH + innerPad/2));
    
    fill(255);
    rect(leftX + innerPad, boxY, leftSectionW, leftSmallH);
    
    // Write track names onto the sidebar list slots if they exist
    if (i < playList.size()) {
      fill(50);
      textSize(16);
      textAlign(LEFT, CENTER);
      text(playList.get(i), leftX + (innerPad * 2), boxY + (leftSmallH / 2));
    }
  }

  // -------------------------
  // MIDDLE BOX
  // -------------------------
  fill(255);
  rect(midX, edgePadding, midW, leftH);

  // -------------------------
  // RIGHT BOX
  // -------------------------
  rect(rightX, edgePadding, rightW, leftH);

  // -------------------------
  // BIG SQUARE
  // -------------------------
  fill(250);

  rect(squareX, squareY, squareSize, squareSize);

  // =================================================
  // MUSIC DISPLAY INSIDE THE BIG SQUARE
  // =================================================

  fill(0);

  textAlign(CENTER, CENTER);

  // NOW PLAYING
  textSize(28);

  text(
    "CURRENTLY PLAYING",
    squareX + squareSize/2,
    squareY + 120
  );

  // SONG TITLE
  fill(0, 180, 80);

  textSize(45); // Adjusted down slightly from 60 to prevent long titles wrapping outside the box

  text(
    songTitle,
    squareX + squareSize/2,
    squareY + squareSize/2
  );

  // STATUS
  fill(80);

  textSize(30);

  if (song != null && song.isPlaying()) {

    text(
      "NOW PLAYING",
      squareX + squareSize/2,
      squareY + squareSize - 120
    );

  } else {

    text(
      "STOPPED",
      squareX + squareSize/2,
      squareY + squareSize - 120
    );
  }

  // -------------------------
  // MUSIC BUTTONS
  // -------------------------
  for (int i = 0; i < 11; i++) {

    float xPos = rightX + innerPad + (i * (sectionW + gap));

    // Hover Effect
    if (
      mouseX >= xPos &&
      mouseX <= xPos + sectionW &&
      mouseY >= sectionY &&
      mouseY <= sectionY + sectionH
    ) {

      fill(200);

    } else {

      fill(245);
    }

    rect(xPos, sectionY, sectionW, sectionH);

    drawMusicIcon(i, xPos, sectionY, sectionW, sectionH);
  }
}

void mousePressed() {

  if (click != null) {
    click.rewind();
    click.play();
  }

  // Process Controls Click Mapping Loop
  for (int i = 0; i < 11; i++) {
    float xPos = rightX + innerPad + (i * (sectionW + gap));

    if (mouseX >= xPos && mouseX <= xPos + sectionW &&
        mouseY >= sectionY && mouseY <= sectionY + sectionH) {
      
      if (song != null) {
        
        // 0: Play
        if (i == 0) {
          song.play();
        }
        
        // 1: Pause
        else if (i == 1) {
          song.pause();
        }
        
        // 2: Stop
        else if (i == 2) {
          song.pause();
          song.rewind();
        }
        
        // 3: Fast Forward (Skip 5 seconds)
        else if (i == 3) {
          song.skip(5000); 
        }
        
        // 4: Skip Track (Cycles to next found song file dynamically)
        else if (i == 4) {
          currentSongIndex = (currentSongIndex + 1) % playList.size();
          songTitle = playList.get(currentSongIndex);
          loadTrack(songTitle);
        }
        
        // 5: Faster Forward (Skip 10 seconds)
        else if (i == 5) {
          song.skip(10000);
        }
        
        // 6: Loop Continuously
        else if (i == 6) {
          song.loop();
        }
        
        // 7: Unloop
        else if (i == 7) {
          song.play(); 
        }
        
        // 8: Loop Once
        else if (i == 8) {
          song.loop(1);
        }
        
        // 9: Volume Up
        else if (i == 9) {
          float currentGain = song.getGain();
          song.setGain(currentGain + 2.0);
        }
        
        // 10: Volume Down
        else if (i == 10) {
          float currentGain = song.getGain();
          song.setGain(currentGain - 2.0);
        }
      }
      break; 
    }
  }
}

// ------------------------------------------------
// ICONS
// ------------------------------------------------
void drawMusicIcon(int index, float x, float y, float w, float h) {

  float centerX = x + w/2;
  float centerY = y + h/2;

  float s = w * 0.4;

  fill(50);

  stroke(50);

  strokeWeight(2);

  // Play
  if (index == 0) {

    triangle(
      centerX - s/2,
      centerY - s/2,
      centerX - s/2,
      centerY + s/2,
      centerX + s/2,
      centerY
    );
  }

  // Pause
  else if (index == 1) {

    rect(centerX - s/2, centerY - s/2, s/3, s);
    rect(centerX + s/6, centerY - s/2, s/3, s);
  }

  // Stop
  else if (index == 2) {

    rect(centerX - s/2, centerY - s/2, s, s);
  }

  // Fast Forward
  else if (index == 3) {

    triangle(centerX - s/2, centerY - s/2,
             centerX - s/2, centerY + s/2,
             centerX, centerY);

    triangle(centerX, centerY - s/2,
             centerX, centerY + s/2,
             centerX + s/2, centerY);
  }

  // Skip
  else if (index == 4) {

    triangle(centerX - s/2, centerY - s/2,
             centerX - s/2, centerY + s/2,
             centerX, centerY);

    rect(centerX, centerY - s/2, s/4, s);
  }

  // Faster Forward
  else if (index == 5) {

    triangle(centerX - s/2, centerY - s/2,
             centerX - s/2, centerY + s/2,
             centerX - s/6, centerY);

    triangle(centerX - s/6, centerY - s/2,
             centerX - s/6, centerY + s/2,
             centerX + s/6, centerY);

    triangle(centerX + s/6, centerY - s/2,
             centerX + s/6, centerY + s/2,
             centerX + s/2, centerY);
  }

  // Loop
  else if (index == 6) {

    noFill();

    arc(centerX, centerY, s, s, 0, PI + HALF_PI);

    fill(50);

    triangle(
      centerX + s/2,
      centerY,
      centerX + s/3,
      centerY - s/6,
      centerX + s/2,
      centerY - s/3
    );
  }

  // Unloop
  else if (index == 7) {

    noFill();

    ellipse(centerX, centerY, s, s);

    line(
      centerX - s/2,
      centerY + s/2,
      centerX + s/2,
      centerY - s/2
    );
  }

  // Loop Once
  else if (index == 8) {

    noFill();

    arc(centerX, centerY, s, s, 0, PI + HALF_PI);

    fill(50);

    textSize(16);

    textAlign(CENTER, CENTER);

    text("1", centerX, centerY);
  }

  // Volume Up
  else if (index == 9) {

    rect(centerX - s/2, centerY - s/4, s/4, s/2);

    line(centerX + s/4, centerY,
         centerX + s/2, centerY);

    line(centerX + s/3, centerY - s/6,
         centerX + s/3, centerY + s/6);
  }

  // Volume Down
  else if (index == 10) {

    rect(centerX - s/2, centerY - s/4, s/4, s/2);

    line(centerX + s/4, centerY,
         centerX + s/2, centerY);
  }
}

void stop() {

  if (song != null) song.close();
  if (click != null) click.close();

  minim.stop();

  super.stop();
}
