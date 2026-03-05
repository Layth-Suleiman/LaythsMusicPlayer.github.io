/*
  Responsive Layout - Sharp Edges Version
  Left: 9 Vertical Sections
  Right: 11 Horizontal Sections at the bottom
*/

int AppWidth, AppHeight;
float GUIWidth = 1920;
float GUIHeight = 1080;

void setup() {
  fullScreen();
  AppWidth = width;
  AppHeight = height;
}

void draw() {
  background(240);
  fill(255);
  stroke(0);
  strokeWeight(2);

  float edgePadding = AppHeight * 50 / GUIHeight;
  float innerPad = AppWidth * 10 / GUIWidth;

  // --- 1. LEFT CONTAINER ---
  float leftX = AppWidth * 50 / GUIWidth;
  float leftW = AppWidth * 400 / GUIWidth;
  float leftH = AppHeight * 980 / GUIHeight;
  rect(leftX, edgePadding, leftW, leftH); 
  
  // Left Vertical Sections
  float leftSectionW = leftW - (innerPad * 2);
  float leftTopH = AppHeight * 300 / GUIHeight;
  rect(leftX + innerPad, edgePadding + innerPad, leftSectionW, leftTopH); 
  
  float leftSmallH = (leftH - leftTopH - (innerPad * 11)) / 7.5;
  for (int i = 0; i < 8; i++) {
    rect(leftX + innerPad, edgePadding + innerPad + leftTopH + innerPad + (i * (leftSmallH + innerPad/2)), leftSectionW, leftSmallH);
  }

  // --- 2. MIDDLE CONTAINER ---
  float midX = AppWidth * 500 / GUIWidth;
  float midW = AppWidth * 620 / GUIWidth;
  rect(midX, edgePadding, midW, leftH); // Removed rounding

  // --- 3. RIGHT CONTAINER ---
  float rightX = AppWidth * 1170 / GUIWidth;
  float rightW = AppWidth * 700 / GUIWidth;
  rect(rightX, edgePadding, rightW, leftH); // Removed rounding

  // Large Square inside Right Container
  float squareSize = rightW - 100; 
  float squareX = rightX + (squareSize/11);
  float squareY = edgePadding + (squareSize/4);
  fill(250); 
  rect(squareX, squareY, squareSize, squareSize); // Removed rounding
  fill(255);

  // Right Internal Logic: 11 HORIZONTAL Sections at the Bottom
  float totalAvailableW = rightW - (innerPad * 2);
  float gap = AppWidth * 5 / GUIWidth; 
  float sectionW = (totalAvailableW - (gap * 10)) / 11;
  float sectionH = AppHeight * 60 / GUIHeight;
  float sectionY = (edgePadding + leftH) - sectionH - innerPad;

  fill(245);
  for (int i = 0; i < 11; i++) {
    float xPos = rightX + innerPad + (i * (sectionW + gap));
    rect(xPos, sectionY, sectionW, sectionH); // Removed rounding
  }
  
  fill(255);
  AppWidth = width;
  AppHeight = height;
}
