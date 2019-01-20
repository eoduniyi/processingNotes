 /*
  * This sketch demonstrates the application of the fast Fourier transform (FFT) algorithm
  * In particular, cube-composed pseudo concentric, expanding, rotating circles 
  * are generated as a function of the amplitude and frequency components of the input signal
  * The input signal referenced: H.E.R. - Going (NPR Music Tiny Desk Concert) + H.E.R. - Going;
  * (This sketch was adapted from Benjamin Farahmand - Atomic Sprocket)
  */
import com.hamoid.*;
import ddf.minim.analysis.*;
import ddf.minim.*;
Minim minim;
AudioPlayer player;
FFT fft;
float[] x, y, angle;
int interval = 15000; // 15s
int time;
PFont font;
String oneName = "This American Life - Episode 641";
//String oneName = "The Time of the Slave Is Over.";
String otherName = "";
String displayed = "";
float opacity = 255;
float diameter = 10;

void setup(){
  // Set visualization to fullscreen, specifying the P3D renderer
  fullScreen(P3D);
  
  // Set the number of frames to be displayed per second
  // note, draw() has a default fps of 60
  //frameRate(512);

  // Initialize an instance of the minim class
  minim = new Minim(this);
  
  // Load music to play and visualize:
  player = minim.loadFile("AA-TAL_a-filter1.mp3"); 
  player.play();

  // Create an FFT object that has a time-domain bufferSize and sampleRate of player
  // according to the Nyquist frequency, the size of the spectrum will be bufferSize/2
  fft = new FFT(player.bufferSize(), player.sampleRate()); 
  
  // Create an "x", "y", and "angle" float array each the size of the spectrum (specSize)
  // i.e., the number of frequency bands:
  y = new float[fft.specSize()];
  x = new float[fft.specSize()];
  angle = new float[fft.specSize()]; 
  
  // Set font face and initial timing interval:
  font = createFont("Flama.ttf",25);
  displayed = oneName;
  time = millis();
  
  // Loop the process indefinitely...
  player.loop();
}

void draw(){  
  // Center visualization on screen
  translate(displayWidth/2, displayHeight/2);

  // Set black background for each frame
  //background(255);
  background(237,27,0);

  // Perform a forward FFT on the samples in the player's mix buffer,
  // which contains the mix of both the left and right channels of the audio file
  fft.forward(player.mix);

  // Display the song name at intervals:
  fill(255);
  textFont(font);
  textAlign(CENTER,CENTER);
  text(displayed,0,0);
  if(millis() - time > interval){
    displayed = displayed.equals(oneName) ? otherName:oneName;
    time  = millis() + 25000;
  }
  diameter++;
  // Generate boxes
   circusOfCriclesHER1();
}
/** Function description:
  * box0Algo - Generate a box (cube) which dimensions (size) is a function of the
  *   frequency and amplitude components of the input signal
  * box1Algo - Rotate along x, y, and z-axis and translate (move) position
  *   "moveX" pixels right and "moveY" pixels down, and @ this location generate 
  *   a cube which size is a function of the frequency and amplitude components 
  *   of the input signal
  * boxnAlgo - someFlippedVersion(box1Algo) using scale()
  */
void circusOfCriclesHER1(){
  // box0Algo
  for(int i = 0; i < fft.specSize(); i++){
    pushMatrix();
    translate(0,-20);
    noFill();
    stroke(255);
    strokeWeight(3);
    box(fft.getBand(i)/20+fft.getFreq(i)*10);
    //translate((fft.getBand(i)*250) % width,(fft.getBand(i)*250) % height);
    //rotateX(sin((fft.getBand(i)/10000))/2);
    ellipse(0,0,fft.getBand(i)/20+fft.getFreq(i)*20,fft.getBand(i)/20+fft.getFreq(i)*20);
    popMatrix();
  }
}
void stop(){
  // Close Minim audio classes:
  player.close();
  minim.stop();
  super.stop();
}