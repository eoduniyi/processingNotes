/**
  * Sketch by Manuel Kretzer, 2016 
  * From "Processing - Generative Design Tutorial: Sound Mapping"
  * visit hhttp://responsivedesign.de/wp-content/uploads/2016/05/tutorial-06_processing-soundmapping2.pdf
  */
import ddf.minim.*;
import processing.pdf.*; // pdf export
import java.util.Calendar; // java calendar timestamp
Minim minim;
AudioPlayer song;
AudioMetaData meta;
int spacing = 16; // space between lines in pixels
int border = spacing*2; // top, left, right, bottom border
int amplification = 6; // frequency amplification factor
int y = spacing;
float ySteps; // number of lines in y direction
float lastx, lasty;

void setup() {
   size(800, 800);
   // beginRecord(PDF, meta.author() + " - " + meta.title()+ " - " + timestamp() + ".pdf”);
   // save pdf with song artist, title and time
   background(255);
   textFont(createFont("Courier New.ttf", 11)); // set up font
   textAlign(RIGHT); // align text to the right
   minim = new Minim(this);
   song = minim.loadFile("going_original_edit_mixdown_filter4.mp3");
   meta = song.getMetaData(); // load music meta data
   song.play();
}

void draw() {
   String info = meta.author() + " - " + meta.title(); // song artist and title
   float textsize = textWidth(info); // get size of text length
   noStroke();
   fill(255); // draw rectangle the size of the text
   rectMode(CORNER);
   rect(width-border-textsize-spacing, height-border, textsize+border+spacing, border);
   fill(0);
   text(info, width-border, height-border/2); // print song info
   int screenSize = int((width-2*border)*(height-1.5*border)/spacing);
   int x = int(map(song.position(), 0, song.length(), 0, screenSize)); // current song pos
   ySteps = x/(width-2*border); // number of lines
   x -= (width-2*border)*ySteps; // new x pos in each line
   float freqMix = song.mix.get(int(x));
   float freqLeft = song.left.get(int(x));
   float freqRight = song.right.get(int(x));
   float amplitude = song.mix.level();
   float size = freqMix * spacing * amplification;
   float red = map(freqLeft, -1, 1, 200, 222);
   float green = map(freqRight, -1, 1, 10, 199);
   float blue = map(freqMix, -1, 1, 10, 88);
   float opacity = map(amplitude, 0.3, 0.5, 80, 100);
   strokeWeight(amplitude*5);
   if ((x >= width - 2 * border - 5) || (x <= 10) || song.mix.level() == 0) noStroke();
   else stroke(red, green, blue, opacity);
   
   line(x+border, y*ySteps+border-freqLeft*amplification, lastx+border,
   lasty*ySteps+border+freqLeft*amplification);
   
   if ((x >= width - 2 * border - 5) || (x <= 10) || song.mix.level() == 0) noStroke();
   else stroke(222, red, blue, opacity);
   
   line(x+border, y*ySteps+border+spacing/2-freqRight*amplification, lastx+border,
   lasty*ySteps+border+spacing/2+freqRight*amplification);
   lastx = x;
   lasty = y;
   
   if (amplitude > 0.33) {
     noStroke();
     fill(0, 0, random(255), 50);
     pushMatrix();
     translate(x+border, y*ySteps+border+size);
     int circleResolution = (int)map(amplitude, 0.33, 0.5, 3, 5);
     float radius = size/2;
     float angle = TWO_PI/circleResolution;
     beginShape();
     for (int i=0; i<=circleResolution; i++) {
       float xShape = 0 + cos(angle*i) * radius;
       float yShape = 0 + sin(angle*i) * radius;
       vertex(xShape, yShape);
     }
   endShape();
   popMatrix();
   }
   position(); // display song position in console
   if (song.isPlaying() == false) endRecord(); // stop pdf recording
}

// current song position in minutes and seconds
void position() { 
   int totalSeconds = (int)(song.length()/1000) % 60;
   int totalMinutes = (int)(song.length()/(1000*60)) % 60;
   int playheadSeconds = (int)(song.position()/1000) % 60;
   int playheadMinutes = (int)(song.position()/(1000*60)) % 60;
   String info = playheadMinutes + ":" + nf(playheadSeconds, 2 ) + "/" + totalMinutes + ":" +
   nf(totalSeconds, 2 );
   println(info);
}

void stop() {
   song.close();
   minim.stop();
   super.stop();
}

void keyReleased() {
 if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png"); // save png of current frame
 if ((song.isMuted() == false && key == ' ')) song.mute(); // mute song
 else if ((song.isMuted() == true && key == ' ')) song.unmute(); // unmute song
}

String timestamp() {
   Calendar now = Calendar.getInstance();
   return String.format("%1$tH%1$tM%1$tS", now);
}