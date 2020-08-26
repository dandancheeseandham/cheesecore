// vim: set nospell:
include <config.scad>
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
use <lib/holes.scad>
use <lib/layout.scad>
use <door_hinge.scad>
use <screwholes.scad>
use <electronics_box_panels.scad>
include <nopscadlib/vitamins/stepper_motor.scad>
include <nopscadlib/vitamins/stepper_motors.scad>
use <demo.scad>

module gromet(){

height = 10.4;
translate ([0,0,-height/2])
difference(){
difference(){
  cylinder (d=26,h=height);
  translate ([0,0,-epsilon]) cylinder (d=20,h=height+2*epsilon);
  translate ([0,0,-epsilon]) cylinder (d=20,h=height+2*epsilon);
  translate ([0,0,-epsilon+2]) cylinder (r1=0, r2 = 28,h=2*height+2*epsilon);
  translate ([0,0,-height-epsilon-2]) cylinder (r1=28, r2 = 0,h=2*height+2*epsilon);
  translate ([-1.5,0,-epsilon]) cube ([3,30,20]);
  }

  union(){
  difference(){
  translate ([0,0,2]) cylinder (d=28,h=6.4);
  #translate ([0,0,2-epsilon]) cylinder (d=24,h=6.4+2*epsilon);
  }
  }

}


}

demo(){
  gromet();
}
