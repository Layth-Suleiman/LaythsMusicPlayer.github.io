// 1. Setup the Canvas
size(1000, 600); // Static mode requires size() instead of fullScreen()
background(240);
fill(255);
stroke(0);
strokeWeight(2);

// 2. Set up scaling variables
float AppWidth = width;
float AppHeight = height;
float GUIWidth = 1920;
float GUIHeight = 1080;

float edgePadding = AppHeight * 50 / GUIHeight;
float innerPad = AppWidth * 10 / GUIWidth;

// --- 3. LEFT CONTAINER ---
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

// --- 4. MIDDLE CONTAINER ---
float midX = AppWidth * 500 / GUIWidth;
float midW = AppWidth * 620 / GUIWidth;
rect(midX, edgePadding, midW, leftH); 

// --- 5. RIGHT CONTAINER ---
float rightX = AppWidth * 1170 / GUIWidth;
float rightW = AppWidth * 700 / GUIWidth;
rect(rightX, edgePadding, rightW, leftH); 

// Large Square inside Right Container
float squareSize = rightW - 100; 
float squareX = rightX + (squareSize/11);
float squareY = edgePadding + (squareSize/4);
fill(250); 
rect(squareX, squareY, squareSize, squareSize); 
fill(255);

// Right Internal Logic: 11 Horizontal Sections
float totalAvailableW = rightW - (innerPad * 2);
float gap = AppWidth * 5 / GUIWidth; 
float sectionW = (totalAvailableW - (gap * 10)) / 11;
float sectionH = AppHeight * 60 / GUIHeight;
float sectionY = (edgePadding + leftH) - sectionH - innerPad;

fill(245);
for (int i = 0; i < 11; i++) {
  float xPos = rightX + innerPad + (i * (sectionW + gap));
  rect(xPos, sectionY, sectionW, sectionH);
}
