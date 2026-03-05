/*
  Left Column with 9 Sections
  Top section is larger than the 8 below it
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

  // --- 1. LEFT MAIN CONTAINER ---
  float leftX = AppWidth * 50 / GUIWidth;
  float leftY = AppHeight * 50 / GUIHeight;
  float leftW = AppWidth * 400 / GUIWidth;
  float leftH = AppHeight * 980 / GUIHeight;
  rect(leftX, leftY, leftW, leftH, 10);

  // --- INTERNAL SECTIONS FOR LEFT CONTAINER ---
  float innerPadding = AppWidth * 10 / GUIWidth;
  float sectionX = leftX + innerPadding;
  float sectionW = leftW - (innerPadding * 2);
 
  // Top Section (Large)
  float topSectionH = AppHeight * 240 / GUIHeight;
  fill(230); // Slight tint for the top
  rect(sectionX, leftY + innerPadding, sectionW, topSectionH, 5);
 
  // Calculate remaining height for the other 8 sections
  // Subtracting the top section height and the extra gaps
  float remainingH = leftH - topSectionH - (innerPadding * 3);
  float smallSectionH = remainingH / 8.5; // Using 8.5 to leave a little breathing room at the bottom
  float gap = AppHeight * 6 / GUIHeight; // Gap between small sections

  fill(255);
  for (int i = 0; i < 8; i++) {
    float sectionY = leftY + innerPadding + topSectionH + gap + (i * (smallSectionH + gap));
    rect(sectionX, sectionY, sectionW, smallSectionH, 5);
  }

  // --- 2. MIDDLE RECTANGLE (Thinner) ---
  float midX = AppWidth * 500 / GUIWidth;
  float midW = AppWidth * 620 / GUIWidth;
  rect(midX, leftY, midW, leftH, 10);

  // --- 3. RIGHT RECTANGLE (Thicker) ---
  float rightX = AppWidth * 1170 / GUIWidth;
  float rightW = AppWidth * 700 / GUIWidth;
  rect(rightX, leftY, rightW, leftH, 10);
 
  AppWidth = width;
  AppHeight = height;
}
