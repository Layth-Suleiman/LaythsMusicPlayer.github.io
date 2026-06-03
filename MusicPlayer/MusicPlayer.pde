/* Layths's Music App, Final Project */

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import java.io.File;
import java.io.FilenameFilter;

Minim minim;
AudioPlayer song, click;

String songTitle = "";
StringList playList;
int currentSongIndex = 0;
String absoluteMusicPath = "";

PImage neverImg, pokemonImg;
float AppWidth, AppHeight, GUIWidth, GUIHeight;
float edgePadding, innerPad;
float leftX, leftW, leftH, leftSectionW, leftTopH, leftSmallH;
float midX, midW, rightX, rightW;
float squareSize, squareX, squareY, squareHeight;
float totalAvailableW, gap, sectionW, sectionH, sectionY, buttonsStartX;

void setup() {
  fullScreen();
  background(240);
  rectMode(CORNER);
  ellipseMode(CENTER);

  minim = new Minim(this);
  playList = new StringList();
  
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
  
  if (folder != null) {
    println("SUCCESS: Found music folder at: " + absoluteMusicPath);
    String[] files = folder.list(new FilenameFilter() {
      public boolean accept(File dir, String name) {
        return name.toLowerCase().endsWith(".mp3");
      }
    });
    
    if (files != null) {
      for (String file : files) {
        println("FOUND AUDIO FILE: " + file);
        playList.append(file.substring(0, file.lastIndexOf('.')));
      }
    }
  }

  if (playList.size() == 0) {
    println("WARNING: No music folder found. Defaulting to 'Never'.");
    playList.append("Never"); 
  }

  songTitle = playList.get(currentSongIndex);
  loadTrack(songTitle);

  click = minim.loadFile("../../Dependencies/SoundEffects/MouseClick.mp3");

  // GUI Calculations
  AppWidth = width;
  AppHeight = height;
  GUIWidth = 1920;
  GUIHeight = 1080;

  edgePadding = AppHeight * 50 / GUIHeight;
  innerPad = AppWidth * 10 / GUIWidth;

  leftX = AppWidth * 50 / GUIWidth;
  leftW = AppWidth * 400 / GUIWidth;
  leftH = AppHeight * 980 / GUIHeight;
  leftSectionW = leftW - (innerPad * 2);
  leftTopH = AppHeight * 300 / GUIHeight;
  leftSmallH = (leftH - leftTopH - (innerPad * 11)) / 7.5;

  midX = AppWidth * 500 / GUIWidth;
  midW = AppWidth * 620 / GUIWidth;

  rightX = leftX + leftW;
  rightW = AppWidth - rightX - leftX;

  squareSize = rightW - 100;
  squareHeight = leftH * 0.70;
  squareX = rightX + (rightW - squareSize) / 2;
  squareY = edgePadding + (innerPad * 4);

  gap = AppWidth * 8 / GUIWidth;
  sectionW = AppWidth * 60 / GUIWidth;
  sectionH = AppHeight * 60 / GUIHeight;

  float totalButtonsWidth = (11 * sectionW) + (10 * gap);
  buttonsStartX = rightX + (rightW - totalButtonsWidth) / 2;
  sectionY = (edgePadding + leftH) - sectionH - (innerPad * 4); 

  neverImg = loadImage("../Dependencies/Images/NeverImage.jpg");
  pokemonImg = loadImage("../Dependencies/Images/PokemonImage.png");
  
  if (neverImg == null) println("ERROR: NeverImage.png failed to load.");
  if (pokemonImg == null) println("ERROR: PokemonImage.png failed to load.");
}

void loadTrack(String title) {
  if (song != null) song.close();
  
  if (!absoluteMusicPath.equals("")) {
    String p = absoluteMusicPath + title;
    song = new File(p + ".mp3").exists() ? minim.loadFile(p + ".mp3") : minim.loadFile(p + ".MP3");
  } 
  
  if (song == null) {
    String p = "../../Dependencies/Music/" + title;
    song = new File(sketchPath(p + ".mp3")).exists() ? minim.loadFile(p + ".mp3") : minim.loadFile(p + ".MP3");
  }
  
  if (song != null) song.play();
}

void draw() {
  background(240);
  fill(255);
  stroke(0);
  strokeWeight(2);

  // LEFT BOX
  rect(leftX, edgePadding, leftW, leftH);
  float topBoxX = leftX + innerPad;
  float topBoxY = edgePadding + innerPad;
  rect(topBoxX, topBoxY, leftSectionW, leftTopH);

  String cleanTitle = songTitle.trim().toLowerCase();
  PImage imgToDraw = null;
  if (cleanTitle.contains("never")) imgToDraw = neverImg;
  else if (cleanTitle.contains("pokemon")) imgToDraw = pokemonImg;

  if (imgToDraw != null) {
    float boxW = leftSectionW - 4, boxH = leftTopH - 4;
    float imgRatio = (float) imgToDraw.width / imgToDraw.height;
    float boxRatio = boxW / boxH;
    float drawW = (imgRatio > boxRatio) ? boxW : boxH * imgRatio;
    float drawH = (imgRatio > boxRatio) ? boxW / imgRatio : boxH;
    image(imgToDraw, topBoxX + 2 + (boxW - drawW)/2, topBoxY + 2 + (boxH - drawH)/2, drawW, drawH);
  } else {
    fill(220);
    rect(topBoxX + 2, topBoxY + 2, leftSectionW - 4, leftTopH - 4);
    fill(120); textSize(14); textAlign(CENTER, CENTER);
    text("[ No Cover Art Image Loaded ]", topBoxX + leftSectionW/2, topBoxY + leftTopH/2);
  }

  for (int i = 0; i < 8; i++) {
    float boxY = edgePadding + innerPad + leftTopH + innerPad + (i * (leftSmallH + innerPad/2));
    fill(255); rect(leftX + innerPad, boxY, leftSectionW, leftSmallH);
    if (i < playList.size()) {
      fill(50); textSize(16); textAlign(LEFT, CENTER);
      text(playList.get(i), leftX + (innerPad * 2), boxY + (leftSmallH / 2));
    }
  }

  // RIGHT BOX & PLAYER DISPLAY
  fill(255); rect(rightX, edgePadding, rightW, leftH);
  fill(250); rect(squareX, squareY, squareSize, squareHeight);

  fill(0); textAlign(CENTER, CENTER); textSize(28);
  text("CURRENTLY PLAYING", squareX + squareSize/2, squareY + (squareHeight * 0.2));
  
  fill(0, 180, 80); textSize(45);
  text(songTitle, squareX + squareSize/2, squareY + (squareHeight * 0.5));

  fill(80); textSize(30);
  text((song != null && song.isPlaying()) ? "NOW PLAYING" : "STOPPED", squareX + squareSize/2, squareY + (squareHeight * 0.8));

  // BUTTON INTERACTION LOOP
  for (int i = 0; i < 11; i++) {
    float xPos = buttonsStartX + (i * (sectionW + gap));
    fill((mouseX >= xPos && mouseX <= xPos + sectionW && mouseY >= sectionY && mouseY <= sectionY + sectionH) ? 200 : 245);
    rect(xPos, sectionY, sectionW, sectionH);
    drawMusicIcon(i, xPos, sectionY, sectionW, sectionH);
  }
}

void mousePressed() {
  if (click != null) { click.rewind(); click.play(); }

  for (int i = 0; i < 11; i++) {
    float xPos = buttonsStartX + (i * (sectionW + gap));
    if (mouseX >= xPos && mouseX <= xPos + sectionW && mouseY >= sectionY && mouseY <= sectionY + sectionH) {
      if (song != null) {
        if (i == 0)      song.play();
        else if (i == 1) song.pause();
        else if (i == 2) { song.pause(); song.rewind(); }
        else if (i == 3) song.skip(5000);
        else if (i == 4) { currentSongIndex = (currentSongIndex + 1) % playList.size(); songTitle = playList.get(currentSongIndex); loadTrack(songTitle); }
        else if (i == 5) song.skip(10000);
        else if (i == 6) song.loop();
        else if (i == 7) song.play();
        else if (i == 8) song.loop(1);
        else if (i == 9) song.setGain(song.getGain() + 2.0);
        else if (i == 10) song.setGain(song.getGain() - 2.0);
      }
      break;
    }
  }
}

void drawMusicIcon(int index, float x, float y, float w, float h) {
  float centerX = x + w/2, centerY = y + h/2, s = w * 0.4;
  fill(50); stroke(50); strokeWeight(2);

  if (index == 0)      triangle(centerX - s/2, centerY - s/2, centerX - s/2, centerY + s/2, centerX + s/2, centerY);
  else if (index == 1) { rect(centerX - s/2, centerY - s/2, s/3, s); rect(centerX + s/6, centerY - s/2, s/3, s); }
  else if (index == 2) rect(centerX - s/2, centerY - s/2, s, s);
  else if (index == 3) { triangle(centerX - s/2, centerY - s/2, centerX - s/2, centerY + s/2, centerX, centerY); triangle(centerX, centerY - s/2, centerX, centerY + s/2, centerX + s/2, centerY); }
  else if (index == 4) { triangle(centerX - s/2, centerY - s/2, centerX - s/2, centerY + s/2, centerX, centerY); rect(centerX, centerY - s/2, s/4, s); }
  else if (index == 5) { triangle(centerX - s/2, centerY - s/2, centerX - s/2, centerY + s/2, centerX - s/6, centerY); triangle(centerX - s/6, centerY - s/2, centerX - s/6, centerY + s/2, centerX + s/6, centerY); triangle(centerX + s/6, centerY - s/2, centerX + s/6, centerY + s/2, centerX + s/2, centerY); }
  else if (index == 6) { noFill(); arc(centerX, centerY, s, s, 0, PI + HALF_PI); fill(50); triangle(centerX + s/2, centerY, centerX + s/3, centerY - s/6, centerX + s/2, centerY - s/3); }
  else if (index == 7) { noFill(); ellipse(centerX, centerY, s, s); line(centerX - s/2, centerY + s/2, centerX + s/2, centerY - s/2); }
  else if (index == 8) { noFill(); arc(centerX, centerY, s, s, 0, PI + HALF_PI); fill(50); textSize(16); textAlign(CENTER, CENTER); text("1", centerX, centerY); }
  else if (index == 9) { rect(centerX - s/2, centerY - s/4, s/4, s/2); line(centerX + s/4, centerY, centerX + s/2, centerY); line(centerX + s/3, centerY - s/6, centerX + s/3, centerY + s/6); }
  else if (index == 10) { rect(centerX - s/2, centerY - s/4, s/4, s/2); line(centerX + s/4, centerY, centerX + s/2, centerY); }
}

void stop() {
  if (song != null) song.close();
  if (click != null) click.close();
  minim.stop();
  super.stop();
}
