/*
Thomas Sanchez Lengeling.
 http://codigogenerativo.com/
 
 KinectPV2, Kinect for Windows v2 library for processing
 
 Skeleton depth tracking example
 */

import java.util.ArrayList;
import KinectPV2.KJoint;
import KinectPV2.*;

KinectPV2 kinect;
int mode = 1;
int cuantos = 400;
Pelo[] lista ;
float radio = 20;



void setup() {
  size(displayWidth, displayHeight, P3D);
  
   radio = height/3.5;

  lista = new Pelo[cuantos];
  for (int i = 0; i < lista.length; i++) {
    lista[i] = new Pelo();
  }
  noiseDetail(3);

  kinect = new KinectPV2(this);

  //Enables depth and Body tracking (mask image)
  kinect.enableDepthMaskImg(true);
  kinect.enableSkeletonDepthMap(true);

  kinect.init();
}

void draw() {
  background(0);
  scale(1.0);
  PImage img = kinect.getDepthMaskImage();
  //image(img, 0, 0);
  img.loadPixels();
  
 

  for (int x = 0; x < img.width; x+=10) {
    for (int y = 0; y < img.height; y+=10) {
      int offset = y * img.width + x;
      color c = img.pixels[offset];
      
      // Check to see if pixel is NOT grayscale-ish
      if (abs(((red(c) + green(c) + blue(c)) / 3) - red(c)) > 1 ) {
        PVector point = new PVector(x, y);
        PVector end = new PVector();
        
        //switch(mode) {
        //case 0:
          end = PVector.random2D().mult(5);
          end.add(point);
          //break;
        //case 1:
        //  end = PVector.random2D().mult(100);
        //  end.add(point);
        //  break;
        //case 2:
        //    end = new PVector(width, height);
          
        
         

         
        //  break;
        //}
        pushMatrix();
        translate(end.x+width/3,end.y+height/4);
         for (int i = 0; i < lista.length; i++) {
    lista[i].dibujar();
  }
  popMatrix();
        //stroke(255, 32);
        //strokeWeight(5);
        //line(point.x, point.y, end.x, end.y);
        
        
        
      }
    }
  


  //textSize(18);
  //text("Press keyboard to change modes. " + mode, 10, 20);
}

//void keyPressed() {
//  mode++;
//  mode%=3;
//}
}

class Pelo
{
  float z = random(-radio, radio);
  float phi = random(TWO_PI);
  float largo = random(1.15, 1.2);
  float theta = asin(z/radio);

  Pelo() { // what's wrong with a constructor here
    z = random(-radio, radio);
    phi = random(TWO_PI);
    largo = random(1.15, 1.2);
    theta = asin(z/radio);
  }

  void dibujar() {

    float off = (noise(millis() * 0.0005, sin(phi))-0.5) * 0.3;
    float offb = (noise(millis() * 0.0007, sin(z) * 0.01)-0.5) * 0.3;

    float thetaff = theta+off;
    float phff = phi+offb;
    float x = radio * cos(theta) * cos(phi);
    float y = radio * cos(theta) * sin(phi);
    float z = radio * sin(theta);

    float xo = radio * cos(thetaff) * cos(phff);
    float yo = radio * cos(thetaff) * sin(phff);
    float zo = radio * sin(thetaff);

    float xb = xo * largo;
    float yb = yo * largo;
    float zb = zo * largo;

    strokeWeight(1);
    beginShape(LINES);
    stroke(0);
    vertex(x, y, z);
    stroke(200, 150);
    vertex(xb, yb, zb);
    endShape();
  }
}