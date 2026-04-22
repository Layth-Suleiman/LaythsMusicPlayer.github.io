
//Library - Minim
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
//
//Global Variables
Minim minim;  //initates entire class
int numberOfSongs = 1; //Best Practcie
int numberOfSoundEffect = 1;
AudioPlayer[] playList = new AudioPlayer[ numberOfSongs ];
AudioPlayer[] soundEffects = new AudioPlayer[ numberOfSoundEffect ];
int currentSong = numberOfSongs - numberOfSongs; //ZERO, Math Property
//
//Display
size( 700, 500 ); //width //height
//fullScreen();  //displayWidth //displayHeight
int appWidth = width; //Best Practice
int appHeight = height;
//
//Music Loading - STRUCTURED Review

minim = new Minim(this); //Manditory



String upArrow = "..";
String open = "/";
String musicFolder = "Music"; //Developer Specific
String soundEffectsFolder = "SoundEffects"; //Developer Specific
String dependanciesFolder = "Dependencies"; //Developer Specific
String songName1 = "Never";
String soundEffect1 = "MouseClick";

String fileExtension_mp3 = ".mp3";
String fileExtension_MP3 = ".MP3";
//CAUTION: Mistakes Below
String musicDirectory = upArrow + open + upArrow + open + dependanciesFolder + open + musicFolder + open ; //Concatenation
String soundEffectsDirectory = upArrow + open + upArrow + open + dependanciesFolder + open + soundEffectsFolder + open ; //Concatenation
String pathway = musicDirectory + songName1 + fileExtension_MP3; //TO BE Rewritten and deleted once file is LOADED
println(pathway);
playList[ currentSong ] = minim.loadFile( pathway ); //ERROR: Verify Spelling & Library installed, Sketch / Import Library
pathway = soundEffectsDirectory + soundEffect1 + fileExtension_mp3; //Rewritting FILE
println(pathway);
soundEffects[currentSong] = minim.loadFile( pathway ); //ERROR: Verify Spelling & Library installed, Sketch / Import Library
//
if ( playList[currentSong]==null || soundEffects[currentSong]==null ) { //ERROR, play list is NULL
  //See FILE or minim.loadFile
 
  
  println("The Play List or Sound Effects did not load properly");
  printArray(playList);
  printArray(soundEffects);
  /*
  println("Music Pathway", musicDirectory);
   println("Full Music File Pathway", file);
   */
} else {
  playList[currentSong].play();
  printArray(playList);
}
