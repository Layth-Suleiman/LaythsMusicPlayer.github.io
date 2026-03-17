/*Divs 2D Rectangles
*/
//
println(displayWidth, displayHeight);
fullScreen();
int appWidth = displayWidth;
int appHeight = displayHeight;
//
int paperWidth = 42;
int paperHeight = 28;

float MenuDivX = appWidth * 1 / paperWidth;
float MenuDivY = appHeight * 3 / paperHeight;

float MenuDivWidth = appWidth * 10 / paperWidth;
float MenuDivHeight = appHeight * 23 / paperHeight;

rect(MenuDivX, MenuDivY, MenuDivWidth, MenuDivHeight, 3);

float LyricsDivX = appWidth * 12 / paperWidth;
float LyricsDivY = appHeight * 3 / paperHeight;

float LyricsDivWidth = appWidth * 11 / paperWidth;
float LyricsDivHeight = appHeight * 23 / paperHeight;

rect(LyricsDivX, LyricsDivY, LyricsDivWidth, LyricsDivHeight, 3);

float SongPlayerX = appWidth * 24 / paperWidth;
float SongPlayerY = appHeight * 3 / paperHeight;

float SongPlayerWidth = appWidth * 17 / paperWidth;
float SongPlayerHeight = appHeight * 23 / paperHeight;

rect(SongPlayerX, SongPlayerY, SongPlayerWidth, SongPlayerHeight, 3);

float UpcomingSongDivX = appWidth * 1 / paperWidth;
float UpcomingSongDivY = appHeight * 3 / paperHeight;

float UpcomingSongDivWidth = appWidth * 10 / paperWidth;
float UpcomingSongDivHeight = appHeight * 7 / paperHeight;

rect(UpcomingSongDivX, UpcomingSongDivY, UpcomingSongDivWidth, UpcomingSongDivHeight, 3);

float LikedSongsDivX = appWidth * 12 / paperWidth;
float LikedSongsDivY = appHeight * 3 / paperHeight;

float LikedSongsDivWidth = appWidth * 11 / paperWidth;
float LikedSongsDivHeight = appHeight * 23 / paperHeight;

rect(LikedSongsDivX, LikedSongsDivY, LikedSongsDivWidth, LikedSongsDivHeight, 3);
