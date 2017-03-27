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


void setup() {
  size(displayWidth, displayHeight, P3D);

  kinect = new KinectPV2(this);

  //Enables depth and Body tracking (mask image)
  kinect.enableDepthMaskImg(true);
  kinect.enableSkeletonDepthMap(true);

  kinect.init();
}

void draw() {
  background(0);
  
 // image(kinect.getDepthMaskImage(), 0, 0);
  //image(kinect.getDepthImage(), width/2, 0);
scale(3);
  //get the skeletons as an Arraylist of KSkeletons
  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonDepthMap();

  //individual joints
  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    //if the skeleton is being tracked compute the skleton joints
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();

      color col  = skeleton.getIndexColor();
      fill(255);
      stroke(255);

      drawBody(joints);
      drawHandState(joints[KinectPV2.JointType_HandRight]);
      drawHandState(joints[KinectPV2.JointType_HandLeft]);
    
    }
  }


  fill(255, 0, 0);
  text(frameRate, 50, 50);
}

//draw the body
void drawBody(KJoint[] joints) {
  //drawBone(joints, KinectPV2.JointType_Head, KinectPV2.JointType_Neck);
  //drawBone(joints, KinectPV2.JointType_Neck, KinectPV2.JointType_SpineShoulder);
  //drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_SpineMid);
  //drawBone(joints, KinectPV2.JointType_SpineMid, KinectPV2.JointType_SpineBase);
  //drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderRight);
  //drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderLeft);
  //drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipRight);
  //drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipLeft);

  // Right Arm
  //drawBone(joints, KinectPV2.JointType_ShoulderRight, KinectPV2.JointType_ElbowRight);
  //drawBone(joints, KinectPV2.JointType_ElbowRight, KinectPV2.JointType_WristRight);
  //drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_HandRight);
  //drawBone(joints, KinectPV2.JointType_HandRight, KinectPV2.JointType_HandTipRight);
  //drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_ThumbRight);

  //draw horizontal lines
  drawBone(joints, KinectPV2.JointType_ShoulderLeft, KinectPV2.JointType_ShoulderRight);
  drawBone(joints, KinectPV2.JointType_ElbowLeft, KinectPV2.JointType_ElbowRight);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_WristRight);
  drawBone(joints, KinectPV2.JointType_HandLeft, KinectPV2.JointType_HandRight);
  

  drawBone(joints, KinectPV2.JointType_HipLeft, KinectPV2.JointType_HipRight);
  drawBone(joints, KinectPV2.JointType_HandTipLeft, KinectPV2.JointType_HandTipRight);
  drawBone(joints, KinectPV2.JointType_ThumbLeft, KinectPV2.JointType_ThumbRight);
  drawBone(joints, KinectPV2.JointType_KneeLeft, KinectPV2.JointType_KneeRight);
  drawBone(joints, KinectPV2.JointType_AnkleLeft, KinectPV2.JointType_AnkleRight);
  drawBone(joints, KinectPV2.JointType_FootLeft, KinectPV2.JointType_FootRight);
  
  //draw verticle lines
  

 
  drawBone(joints, KinectPV2.JointType_HandLeft, KinectPV2.JointType_FootLeft);
  drawBone(joints, KinectPV2.JointType_HandRight, KinectPV2.JointType_FootRight);
  drawBone(joints, KinectPV2.JointType_Head, KinectPV2.JointType_FootLeft);
  drawBone(joints, KinectPV2.JointType_Head, KinectPV2.JointType_FootRight);
 

  




  

  
  


  //Single joints
  //drawJoint(joints, KinectPV2.JointType_HandTipLeft);
  //drawJoint(joints, KinectPV2.JointType_HandTipRight);
  //drawJoint(joints, KinectPV2.JointType_FootLeft);
  //drawJoint(joints, KinectPV2.JointType_FootRight);

  //drawJoint(joints, KinectPV2.JointType_ThumbLeft);
  //drawJoint(joints, KinectPV2.JointType_ThumbRight);

  //drawJoint(joints, KinectPV2.JointType_Head);
  //drawHeadState(joints,KinectPV2.JointType_HandRight);
}

//draw a single joint
void drawJoint(KJoint[] joints, int jointType) {
  pushMatrix();
  translate(joints[jointType].getX(), joints[jointType].getY(), joints[jointType].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
}

//draw a bone from two joints
void drawBone(KJoint[] joints, int jointType1, int jointType2) {
  pushMatrix();
  translate(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ());
  ellipse(0, 0, 1, 1);
  popMatrix();
  pushMatrix();
  translate(joints[jointType2].getX(), joints[jointType2].getY(), joints[jointType2].getZ());
  ellipse(0, 0, 1, 1);
  popMatrix();
  line(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ(), joints[jointType2].getX(), joints[jointType2].getY(), joints[jointType2].getZ());
}

//draw a ellipse depending on the hand state
void drawHandState(KJoint joint) {
  noStroke();
  handState(joint.getState());
  pushMatrix();
  translate(joint.getX(), joint.getY(), joint.getZ());
  ellipse(0, 0, 15, 15);
  popMatrix();
}

void drawHeadState(KJoint[] joints, int jointType) {
  noStroke();
  
  

  line(joints[jointType].getX(), joints[jointType].getY(), joints[jointType].getZ(),200,0,0);
 
}

/*
Different hand state
 KinectPV2.HandState_Open
 KinectPV2.HandState_Closed
 KinectPV2.HandState_Lasso
 KinectPV2.HandState_NotTracked
 */

//Depending on the hand state change the color
void handState(int handState) {
  switch(handState) {
  case KinectPV2.HandState_Open:
    fill(0, 255, 0);
    break;
  case KinectPV2.HandState_Closed:
    fill(255, 0, 0);
    break;
  case KinectPV2.HandState_Lasso:
    fill(0, 0, 255);
    break;
  case KinectPV2.HandState_NotTracked:
    fill(100, 100, 100);
    break;
  }
}