
import com.hamoid.*;
import ddf.minim.analysis.*;
import ddf.minim.*;
Minim minim;
AudioPlayer jingle;
AudioInput player;
FFT fft;
float[] angle;
float[] y, x;
//String oneName = "Sam Gellaitry - Midnight Racer (Original Mix)";
//String oneName = "H.E.R. - Going (NPR Music Tiny Desk Concert)";
String oneName = "H.E.R. - Still Down";
//String oneName = "Kwabs - The Wilhelm Scream (James Blake Cover)";
//String oneName = "Kids See Ghost - Cudi Montage";
//String oneName = "Jay Rock - Redemption ft. SZA";
//String oneName = "Jay Rock - Knock It Off";
//String oneName = "Flying Lotus - Zodiac Shit";
//String oneName = "Ann Marie ft. YK Osiris - Secret";
//String oneName = "Mumu Fresh Ft. Black Thought & DJ Dummy - Say My Name (NPR Music Tiny Desk Concert)";
//String oneName = "GoldLink - Pray Everday (NPR Music Tiny Desk Concert)";
//String oneName = "";
String otherName = "";
String displayed ="";
int 
  samples = 1024; 
float 
  angleStep  = TWO_PI/samples,
  maxRadius = 300.,
  scaleF = 125.,
  radiusStep;
PVector 
  shapeCenter, 
  currentVertex;
PVector[] 
  lookupTable;


int interval = 15000; // 2s
//int interval = 2000; // 2s
int time;

PFont font;

void setup()
{
  size(displayWidth, displayHeight, P3D); // I shoxuld change this later.
  minim = new Minim(this);
  //player = minim.getLineIn(Minim.STEREO, 2048, 192000.0);
  //jingle = minim.loadFile("Kwabs.mp3");
  //jingle = minim.loadFile("Sam Gellaitry -  Midnight Racer (Original Mix).mp3");
  jingle = minim.loadFile("H.E.R. - Still Down (Audio).mp3");
  //jingle = minim.loadFile("H.E.R. NPR Music Tiny Desk Concert.mp3");
  //jingle = minim.loadFile("tiny_desk_edit_mixdown_filter2.mp3");
  //jingle = minim.loadFile("tiny_desk_edit_mixdown_filter13.mp3");
  //jingle = minim.loadFile("H.E.R. - Going (Interlude) (Audio).mp3");
  //jingle = minim.loadFile("going_original_edit_mixdown_filter4.mp3"); 
  //jingle = minim.loadFile("goldlink_mixdown.mp3");
  //jingle = minim.loadFile("goldlink_mixdown_echotest2.mp3");
  //jingle = minim.loadFile("Say My Name.mp3");
  //jingle = minim.loadFile("Flying Lotus - Zodiac Shit.mp3"); 
  //jingle = minim.loadFile("Ann Marie Feat. YK Osiris Secret (WSHH Exclusive - Official Music Video).mp3");
  //jingle = minim.loadFile("secret_mixdown.mp3");
  //jingle = minim.loadFile("Jay Rock - Redemption ft. SZA (Redemption).mp3");
  //jingle = minim.loadFile("Jay Rock - Knock It Off.mp3");
  //jingle = minim.loadFile("Cudi Montage.mp3");
  //jingle = minim.loadFile("Cudi Montage_filter1.mp3");
  //jingle = minim.loadFile("Common, Karriem Riggins & Robert Glasper - August Greene (Full Album).mp3");
  //jingle = minim.loadFile("Sóley - Endless Summer (Live on KEXP).mp3");
  //jingle = minim.loadFile("Friday Morning.mp3");
  //jingle = minim.loadFile("Mount Kimbie - Carbonated.mp3");
  //jingle = minim.loadFile("stln_drms - backpack.mp3");
  //jingle = minim.loadFile("The Protest.mp3");
  //jingle = minim.loadFile("JMSN - Bout It-short.mp3");
  jingle.play();
  //fft = new FFT(player.bufferSize(), player.sampleRate());
  fft = new FFT(jingle.bufferSize(), jingle.sampleRate()); //
  y = new float[fft.specSize()];
  x = new float[fft.specSize()];
  angle = new float[fft.specSize()]; 
  //frameRate(1000); 
  font = createFont("Courier New.ttf",18);
  background(0);
  //font = createFont("MyriadArabic-Bold.otf",18);
  //font = createFont("AdobeArabic-Bold.otf",15);
  displayed = oneName;
  time = millis();
  
  shapeCenter  = new PVector(width/2, height/2);
  currentVertex= new PVector();
  lookupTable= new PVector[samples];
  for (int i = 0; i < samples; i++) 
  {
       float angle= i*angleStep + HALF_PI;
       lookupTable[i] = new PVector(cos(angle), sin(angle)); 
  }
  radiusStep = maxRadius/(jingle.length()*6/100);

}

void draw()
{   
  translate(displayWidth/2, displayHeight/2.2);
  //translate(displayWidth / 2, displayHeight / 4.2);
  //imageMode(CENTER); // Center entire image/visualization

  // 1. Set background colors
  background(0);
  // 1.1
  //background(255, 204, 0);
  // 1.2
  //background(255, 99, 216);

  // Manipulate frequency spectrum
  fft.forward(jingle.mix);
  //fft.forward(player.mix);

  // 2. Set central box/equilizer colors
  // 2.1
  //stroke(61,184,255);
  // 2.2
  //stroke(255, 0, 0, 128);
  //stroke(153);


//  //String s = "Sam Gellaitry - Midnight Racer (Original Mix)";
//  //textFont(mono);
//  textAlign(CENTER, BOTTOM);
//  //line(88, 30, 570, 30);
    textFont(font);
    text(displayed,30,-10,600,30);
    if (millis() - time > interval) {
      displayed = displayed.equals(oneName)? otherName:oneName;
      time  = millis() + 25000;
      //time  = millis() + 11575; // For Zodiac shit
      //oneName = "H.E.R. - Going (Interlude)"; 
      //oneName = "";
    }

//  //String s = "H.E.R. - Still Down";
//  //textFont(mono);
//  //textAlign(CENTER, BOTTOM);
//  //line(225, 30, 435, 30);
//  //text(s,30,-5,600,30);

  //stroke(255, 255, 0, 128);
  //if (jingle.isPlaying()) 
  //{
  // strokeWeight(3);
  // visualizeWaves(jingle.right.toArray(), 0x50ff0000, maxRadius, scaleF);
  // visualizeWaves(jingle.left.toArray(), 0x50000000, maxRadius, scaleF);
  // visualizeWaves(jingle.mix.toArray(), 0xffffffff, maxRadius -= radiusStep, scaleF);
  // scale(-1,-1);
  // visualizeWaves(jingle.mix.toArray(), 0xffffffff, maxRadius -= radiusStep, scaleF);
  //}

  //Manipulate frequency spectrum with box
  for (int i = 0; i < fft.specSize(); i++)
  {
    //translate(displayWidth/2, displayHeight/4);
    //translate(displayWidth / 60, displayHeight /2);
    //stroke(255);
    noFill();
    //fill(fft.getFreq(i)*2, 0, fft.getBand(i)*2);
    pushMatrix();
    //line(i, height, i, height - fft.getBand(i)*20);
    box(fft.getBand(i)/20+fft.getFreq(i)/15);
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
  for (int i = 0; i < fft.specSize(); i++) 
  {
    scale(-1,1);
    y[i] = y[i] + fft.getBand(i)/1000;
    x[i] = x[i] + fft.getFreq(i)/1000;
    angle[i] = angle[i] + fft.getFreq(i)/100000;
    rotateX(sin(angle[i]/2));
    rotateY(cos(angle[i]/2));
    stroke(255);
    strokeWeight(2);
    noFill();
    //stroke(fft.getFreq(i)*2, 0, fft.getBand(i)*2);
    //fill(0, 255-fft.getFreq(i)*2, 255-fft.getBand(i)*2);
    pushMatrix();
    translate((x[i]+250)%width, (y[i]+250)%height);
    box(fft.getBand(i)/20+fft.getFreq(i)/15);
    popMatrix();
  }

  //stroke(255, 0, 0, 128);

  //Manipulate frequency spectrum with circles 
  for (int i = 0; i < fft.specSize(); i++) 
  {
    scale(-1,-1);
    y[i] = y[i] + fft.getBand(i)/1000;
    x[i] = x[i] + fft.getFreq(i)/1000;
    angle[i] = angle[i] + fft.getFreq(i)/100000;
    rotateX(sin(angle[i]/2));
    rotateY(cos(angle[i]/2));
    stroke(255);
    //strokeWeight(2);
    noFill();
    //stroke(fft.getFreq(i)*2, 0, fft.getBand(i)*2);
    //fill(0, 255-fft.getFreq(i)*2, 255-fft.getBand(i)*2);
    pushMatrix();
    translate((x[i]+250)%width, (y[i]+250)%height);
    box(fft.getBand(i)/20+fft.getFreq(i)/15);
    popMatrix();
  }
  
  //if (jingle.isPlaying()) 
  //{
  // strokeWeight(3);
  // pushMatrix();
  // visualizeWaves(jingle.right.toArray(), 0x50ff0000, maxRadius, scaleF);
  // visualizeWaves(jingle.left.toArray(), 0x50000000, maxRadius, scaleF);
  // visualizeWaves(jingle.mix.toArray(), 0xffffffff, maxRadius -= radiusStep, scaleF);
  // scale(-1,-1);
  // visualizeWaves(jingle.mix.toArray(), 0xffffffff, maxRadius -= radiusStep, scaleF);
  // popMatrix();
  //}
}

void stop()
{
  // Close Minim audio classes when you finish with them
  jingle.close();
  minim.stop();
  super.stop();
}
////Sound fingerprint
////A simple way of visualizing sounds creating a unique fingerprint 
////Ale González, 2013
////Credits: "Basura Sónica No Deseada" by AZ-Rotator. In "Spam", 2010, Discontinu Records.
////artist info:
////www.azrotator.info
////www.myspace.com/azrotator

////import ddf.minim.*;
////import ddf.minim.analysis.*;


////Minim minim;
////AudioPlayer song;

////int 
////  samples = 1024; 
////float 
////  angleStep  = TWO_PI/samples,
////  maxRadius = 300.,
////  scaleF = 125.,
////  radiusStep;
////PVector 
////  shapeCenter, 
////  currentVertex;
////PVector[] 
////  lookupTable;

////void setup()
////{
////    size(displayWidth, displayHeight, P3D);
////    imageMode(CENTER); // Center entire image/visualization
////    smooth();
////    noStroke();
////    //background(-1);
////    //noCursor();
////    shapeCenter  = new PVector(width/2, height/2);
////    currentVertex= new PVector();
////    lookupTable= new PVector[samples];
////    for (int i = 0; i < samples; i++) 
////    {
////         float angle= i*angleStep + HALF_PI;
////         lookupTable[i] = new PVector(cos(angle), sin(angle)); 
////    }
////    minim = new Minim(this);
////    //song = minim.loadFile(".mp3", samples);
////    song = minim.loadFile("H.E.R. - Still Down (Audio).mp3",samples);
////    radiusStep = maxRadius/(song.length()*6/100);
////    song.play();
////}

////void draw()
////{
////    background(0);
////    //stroke(255, 255, 0, 128);
////    if (song.isPlaying()) 
////    {
////         //visualizeWaves(song.right.toArray(), 0x50ff0000, maxRadius, scaleF);
////         ////visualizeWaves(song.left.toArray(), 0x50000000, maxRadius, scaleF);
////         visualizeWaves(song.mix.toArray(), 0xffffffff, maxRadius -= radiusStep, scaleF);
////         scale(-1,-1);
////         visualizeWaves(song.mix.toArray(), 0xffffffff, maxRadius -= radiusStep, scaleF);
////    }
////}

void visualizeWaves(float [] wavesToVisualize, color fillColor, float radius, float scale_factor)
{
     //fill(fillColor);
     //stroke(0x10ffffff);
     beginShape();
     for (int i = 0; i < wavesToVisualize.length; i++)
     {
          float  r = radius + wavesToVisualize[i]*scale_factor;
          currentVertex = PVector.add(shapeCenter, PVector.mult(lookupTable[i], r));
          vertex (currentVertex.x, currentVertex.y);
      }
      endShape();
} 

////void stop(){
////  song.close();
////  minim.stop();
////  super.stop();
////}