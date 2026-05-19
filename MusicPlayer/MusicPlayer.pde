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
  rectMode(CORNER);
  ellipseMode(CENTER);
  
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
  background(240); 
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
  
  // 11 Sections in Right with Icons
  for (int i = 0; i < 11; i++) {
    float xPos = rightX + innerPad + (i * (sectionW + gap));
    
    // Bounding box collision checking for mouse hover
    if (mouseX >= xPos && mouseX <= xPos + sectionW && mouseY >= sectionY && mouseY <= sectionY + sectionH) {
      fill(200); // Distinct grey when mouse hovers over it
    } else {
      fill(245); // Default off-white background
    }
    
    stroke(0);
    strokeWeight(2);
    rect(xPos, sectionY, sectionW, sectionH);
    
    // Draw music icons (0-10)
    drawMusicIcon(i, xPos, sectionY, sectionW, sectionH);
  }
} // End Draw

void mousePressed() {} // End Mouse Pressed

// --- ICON HELPER FUNCTION ---
void drawMusicIcon(int index, float x, float y, float w, float h) {
  float centerX = x + w/2;
  float centerY = y + h/2;
  float s = w * 0.4; // Scale size of icons
  
  fill(50); 
  stroke(50);
  strokeWeight(2);
  strokeJoin(ROUND);

  if (index == 0) { // Play
    triangle(centerX - s/2, centerY - s/2, centerX - s/2, centerY + s/2, centerX + s/2, centerY);
  } 
  else if (index == 1) { // Pause
    rect(centerX - s/2, centerY - s/2, s/3, s);
    rect(centerX + s/6, centerY - s/2, s/3, s);
  } 
  else if (index == 2) { // Stop
    rect(centerX - s/2, centerY - s/2, s, s);
  } 
  else if (index == 3) { // Fast Forward
    triangle(centerX - s/2, centerY - s/2, centerX - s/2, centerY + s/2, centerX, centerY);
    triangle(centerX, centerY - s/2, centerX, centerY + s/2, centerX + s/2, centerY);
  } 
  else if (index == 4) { // Skip
    triangle(centerX - s/2, centerY - s/2, centerX - s/2, centerY + s/2, centerX, centerY);
    rect(centerX, centerY - s/2, s/4, s);
  } 
  else if (index == 5) { // Faster Forward
    triangle(centerX - s/2, centerY - s/2, centerX - s/2, centerY + s/2, centerX - s/6, centerY);
    triangle(centerX - s/6, centerY - s/2, centerX - s/6, centerY + s/2, centerX + s/6, centerY);
    triangle(centerX + s/6, centerY - s/2, centerX + s/6, centerY + s/2, centerX + s/2, centerY);
  } 
  else if (index == 6) { // Loop
    noFill();
    arc(centerX, centerY, s, s, 0, PI + HALF_PI);
    fill(50);
    pushMatrix();
    translate(centerX + s/2, centerY);
    triangle(0, 0, -s/6, -s/6, s/6, -s/6);
    popMatrix();
  } 
  else if (index == 7) { // Unloop
    noFill();
    ellipse(centerX, centerY, s, s);
    line(centerX - s/2, centerY + s/2, centerX + s/2, centerY - s/2);
  } 
  else if (index == 8) { // Loop Once
    noFill();
    arc(centerX, centerY, s, s, 0, PI + HALF_PI);
    fill(50);
    textSize(s * 0.6);
    textAlign(CENTER, CENTER);
    text("1", centerX, centerY);
  }
  else if (index == 9) { // Volume Up
    // Speaker Body
    rect(centerX - s/2, centerY - s/4, s/4, s/2);
    beginShape();
    vertex(centerX - s/4, centerY - s/4);
    vertex(centerX, centerY - s/2);
    vertex(centerX, centerY + s/2);
    vertex(centerX - s/4, centerY + s/4);
    endShape(CLOSE);
    // Plus Sign
    line(centerX + s/4, centerY, centerX + s/2 + s/4, centerY);
    line(centerX + s/2, centerY - s/4, centerX + s/2, centerY + s/4);
  }
  else if (index == 10) { // Volume Down
    // Speaker Body
    rect(centerX - s/2, centerY - s/4, s/4, s/2);
    beginShape();
    vertex(centerX - s/4, centerY - s/4);
    vertex(centerX, centerY - s/2);
    vertex(centerX, centerY + s/2);
    vertex(centerX - s/4, centerY + s/4);
    endShape(CLOSE);
    // Minus Sign
    line(centerX + s/4, centerY, centerX + s/2 + s/4, centerY);
  }
}
