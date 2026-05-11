/* Music App, Final Project */
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//
// Global Variables
//
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
  
  // 1. Set up scaling variables
  AppWidth = width;
  AppHeight = height;
  GUIWidth = 1920;
  GUIHeight = 1080;

  edgePadding = AppHeight * 50 / GUIHeight;
  innerPad = AppWidth * 10 / GUIWidth;

  // 2. LEFT CONTAINER Logic
  leftX = AppWidth * 50 / GUIWidth;
  leftW = AppWidth * 400 / GUIWidth;
  leftH = AppHeight * 980 / GUIHeight;
  leftSectionW = leftW - (innerPad * 2);
  leftTopH = AppHeight * 300 / GUIHeight;
  leftSmallH = (leftH - leftTopH - (innerPad * 11)) / 7.5;

  // 3. MIDDLE CONTAINER Logic
  midX = AppWidth * 500 / GUIWidth;
  midW = AppWidth * 620 / GUIWidth;

  // 4. RIGHT CONTAINER Logic
  rightX = AppWidth * 1170 / GUIWidth;
  rightW = AppWidth * 700 / GUIWidth;
  
  // Large Square inside Right Container
  squareSize = rightW - 100; 
  squareX = rightX + (squareSize/11);
  squareY = edgePadding + (squareSize/4);

  // Right Internal Logic: 11 Horizontal Sections
  totalAvailableW = rightW - (innerPad * 2);
  gap = AppWidth * 5 / GUIWidth; 
  sectionW = (totalAvailableW - (gap * 10)) / 11;
  sectionH = AppHeight * 60 / GUIHeight;
  sectionY = (edgePadding + leftH) - sectionH - innerPad;
} //End Setup

void draw() {
  background(240); // Refreshes background every frame
  fill(255);
  stroke(0);
  strokeWeight(2);

  // --- DRAW LEFT CONTAINER ---
  rect(leftX, edgePadding, leftW, leftH);  
  rect(leftX + innerPad, edgePadding + innerPad, leftSectionW, leftTopH);  
  for (int i = 0; i < 8; i++) {
    rect(leftX + innerPad, edgePadding + innerPad + leftTopH + innerPad + (i * (leftSmallH + innerPad/2)), leftSectionW, leftSmallH);
  }

  // --- DRAW MIDDLE CONTAINER ---
  rect(midX, edgePadding, midW, leftH); 

  // --- DRAW RIGHT CONTAINER ---
  rect(rightX, edgePadding, rightW, leftH); 
  
  // Square in Right
  fill(250); 
  rect(squareX, squareY, squareSize, squareSize); 
  
  // 11 Sections in Right
  fill(245);
  for (int i = 0; i < 11; i++) {
    float xPos = rightX + innerPad + (i * (sectionW + gap));
    rect(xPos, sectionY, sectionW, sectionH);
  }
} // End Draw

void mousePressed() {} // End Mouse Pressed
