/* Layths's Music App, Final Project */

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// Music Variables
Minim minim;
AudioPlayer song;
AudioPlayer click;

String songTitle = "Never";

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
  // MUSIC
  // -------------------------
  minim = new Minim(this);

  String musicPath = "../../Dependencies/Music/" + songTitle + ".MP3";
  String clickPath = "../../Dependencies/SoundEffects/MouseClick.mp3";

  song = minim.loadFile(musicPath);
  click = minim.loadFile(clickPath);

  if (song != null) {
    song.play();
  }

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

  for (int i = 0; i < 8; i++) {

    rect(
      leftX + innerPad,
      edgePadding + innerPad + leftTopH + innerPad +
      (i * (leftSmallH + innerPad/2)),
      leftSectionW,
      leftSmallH
    );
  }

  // -------------------------
  // MIDDLE BOX
  // -------------------------
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

  textSize(60);

  text(
    songTitle,
    squareX + squareSize/2,
    squareY + squareSize/2
  );

  // STATUS
  fill(80);

  textSize(30);

  if (song.isPlaying()) {

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

  song.close();
  click.close();

  minim.stop();

  super.stop();
}
