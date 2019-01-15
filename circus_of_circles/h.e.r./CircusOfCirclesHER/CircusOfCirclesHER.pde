/**
  * This sketch demonstrates how to use an FFT to analyze an 
  * AudioBuffer and draw the resulting spectrum. 
  * For more information about Minim and additional features, 
  * visit http://code.compartmental.net/minim/
  */
import com.hamoid.*;
import ddf.minim.analysis.*;
import ddf.minim.*;
Minim minim;
AudioPlayer player;
FFT fft;
float[] angle;
float[] y, x;
PFont font;

String oneName = "H.E.R. - Going (NPR Music Tiny Desk Concert)";
//String oneName = "H.E.R. - Still Down";
String otherName = "";
String displayed = "";
int interval = 15000; // 15s
int time;

void setup()
{
  // Set visualization to fullscreen, specifying P3D renderer
  fullScreen(P3D);
  //frameRate(200);

  // Initialize an instance of the minim class
  minim = new Minim(this);
  
  // Load music to play and visualize:
  player = minim.loadFile("going_original_edit_mixdown_filter4.mp3"); 
  //player = minim.loadFile("H.E.R. - Still Down (Audio).mp3");
  player.play();

  // Create an FFT object that has a time-domain bufferSize and sampleRate of player
  // according to the Nyquist frequency, the size of the spectrum will be bufferSize/2
  fft = new FFT(player.bufferSize(), player.sampleRate()); 
  
  // Create an "x", "y", and "angle" float array each the size of the spectrum (specSize)
  // i.e., the number of frequency bands:
  y = new float[fft.specSize()];
  x = new float[fft.specSize()];
  angle = new float[fft.specSize()]; 
  
  // Set font face and initial timing interval
  font = createFont("Courier New.ttf",18);
  displayed = oneName;
  time = millis();
  
  // Loop the process indefinitely...
  // player.loop();
}

void draw()
{  
  // Center visualization
  translate(displayWidth/2, displayHeight/2);

  // Set black background for each frame
  background(0);

  // Perform a forward FFT on the samples in the player's mix buffer,
  // which contains the mix of both the left and right channels of the audio fil
  fft.forward(player.mix);
  
  // Display the song name at intervals:
  textFont(font);
  text(displayed,30,-10,600,30);
  if(millis() - time > interval){
    displayed = displayed.equals(oneName) ? otherName:oneName;
    time  = millis() + 25000;
    oneName = "H.E.R. - Going (Interlude)";
  }

  // Generate a box that expands based on the amplitude and frequency components:
  for(int i = 0; i < fft.specSize(); i++){
    //stroke(255);
    noFill();
    //fill(fft.getFreq(i)*2, 0, fft.getBand(i)*2);
    pushMatrix();
    //line(i, height, i, height - fft.getBand(i)*20);
    box(fft.getBand(i)/20+fft.getFreq(i)/15);
    //rect(20, -10, fft.getBand(i)/20+fft.getFreq(i)/15, fft.getBand(i)/20+fft.getFreq(i)/15, 7);
    popMatrix();
  }

  //stroke(255, 0, 0, 128);
  //Manipulate frequency spectrum with circles 
  //for (int i = 0; i < fft.specSize(); i++) 
  //{
  //  y[i] = y[i] + fft.getBand(i)/1000;
  //  x[i] = x[i] + fft.getFreq(i)/1000;
  //  angle[i] = angle[i] + fft.getFreq(i)/100000;
  //  rotateX(sin(angle[i]/2));
  //  rotateY(cos(angle[i]/2));
  //  //stroke(255);
  //  strokeWeight(2);
  //  noFill();
  //  //stroke(fft.getFreq(i)*2, 0, fft.getBand(i)*2);
  //  //fill(0, 255-fft.getFreq(i)*2, 255-fft.getBand(i)*2);
  //  pushMatrix();
  //  translate((x[i]+250)%width, (y[i]+250)%height);
  //  box(fft.getBand(i)/20+fft.getFreq(i)/15);
  //  popMatrix();
  //} 

  //stroke(255, 0, 0, 128);
  //Manipulate frequency spectrum with circles 
  //for (int i = 0; i < fft.specSize(); i++) 
  //{
  //  scale(-1,1);
  //  y[i] = y[i] + fft.getBand(i)/1000;
  //  x[i] = x[i] + fft.getFreq(i)/1000;
  //  angle[i] = angle[i] + fft.getFreq(i)/100000;
  //  rotateX(sin(angle[i]/2));
  //  rotateY(cos(angle[i]/2));
  //  stroke(255);
  //  strokeWeight(2);
  //  noFill();
  //  //stroke(fft.getFreq(i)*2, 0, fft.getBand(i)*2);
  //  //fill(0, 255-fft.getFreq(i)*2, 255-fft.getBand(i)*2);
  //  pushMatrix();
  //  translate((x[i]+250) % width,(y[i]+250) % height);
  //  //box(fft.getBand(i)/20+fft.getFreq(i)/15);
    
  //  // Compose shape:
  //  ellipseMode(CENTER);
  //  ellipse(0, 0, fft.getBand(i)/20+fft.getFreq(i)/15, fft.getBand(i)/20+fft.getFreq(i)/15);
  //  //rect(0, 0, fft.getBand(i)/20+fft.getFreq(i)/15, fft.getBand(i)/20+fft.getFreq(i)/15, 7);
  //  popMatrix();
  //}

  //Manipulate frequency spectrum with circles 
  //for (int i = 0; i < fft.specSize(); i++) 
  //{
  //  scale(1,-1);
  //  y[i] = y[i] + fft.getBand(i)/1000;
  //  x[i] = x[i] + fft.getFreq(i)/1000;
  //  angle[i] = angle[i] + fft.getFreq(i)/100000;
  //  rotateX(sin(angle[i]/2));
  //  rotateY(cos(angle[i]/2));
  //  //rotateZ(tan(angle[i]/2));
  //  stroke(255);
  //  strokeWeight(2);
  //  noFill();
  //  //stroke(fft.getFreq(i)*2, 0, fft.getBand(i)*2);
  //  //fill(0, 255-fft.getFreq(i)*2, 255-fft.getBand(i)*2);
  //  pushMatrix();
  //  translate((x[i]+250)%width, (y[i]+250)%height);
  //  box(fft.getBand(i)/20+fft.getFreq(i)/15);
  //  popMatrix();
  //}
  
 
  for (int i = 0; i < fft.specSize(); i++) 
  {
    scale(-1,-1);
    y[i] = y[i] + fft.getBand(i)/1000;
    x[i] = x[i] + fft.getFreq(i)/1000;
    angle[i] = angle[i] + fft.getFreq(i)/100000;
    rotateX(sin(angle[i]/2));
    rotateY(cos(angle[i]/2));
    rotateZ(tan(angle[i]/2));
    stroke(255);
    //strokeWeight(2);
    noFill();
    //stroke(fft.getFreq(i)*2, 0, fft.getBand(i)*2);
    //fill(0, 255-fft.getFreq(i)*2, 255-fft.getBand(i)*2);
    pushMatrix();
    translate((x[i]+250) % width, (y[i]+250) % height);
    box(fft.getBand(i)/20+fft.getFreq(i)/15);
    popMatrix();
  }
}

void stop()
{
  // Close Minim audio classes:
  player.close();
  minim.stop();
  super.stop();
}