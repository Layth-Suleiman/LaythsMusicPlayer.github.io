/* Library Notes
 - File / Sketch / Import Library / Manage Libraries
 - We use Minim for Sound and Sound Effects
 - Able to Google-search libraries to make your project easier
 - Documentation: https://code.compartmental.net/minim/
 - Specific Class: https://code.compartmental.net/minim/audioplayer_class_audioplayer.html
 - Specific Class: https://code.compartmental.net/minim/audiometadata_class_audiometadata.html
 
 ** You are now able to research any Processing-Java Library ... or Any Java Library from the internet **
 - Processing-Java Libraries must be installed into the IDE
 - Java Libraries simply require the 'import' declaration
 
 - Note: Hard Drive Registery or address
 
 - Library will not execute since not using full compiler
 
 */
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
String soundEffectsFolder = "Sound Effects"; //Developer Specific
String dependanciesFolder = "Depindancies"; //Developer Specific
String songName1 = "groove";
String soundEffect1 = "Car_Door_Closing";
String fileExtension_mp3 = ".mp3";
//
