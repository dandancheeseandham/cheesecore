include <config.scad>
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
use <lib/holes.scad>
use <lib/layout.scad>
use <door_hinge.scad>
use <screwholes.scad>
use <demo.scad>
use <stencilla.ttf>
/*
ECHO: "panel_screw_offset(): ", 50
ECHO: "panel_screw_spacing(frame_size().x): ", 97.5
ECHO: "panel_screw_spacing(frame_size().y): ", 88.75
ECHO: "panel_screw_spacing(frame_size().z): ", 86.25
*/

module screw_comb()
{
  //comb body
  sizeofcomb = 505;
  //425 full 365 printable
  width = 25;
  number=5-1; //5 = zl and 7 = zlt
  thickness = 0.6;

  // spacings
  spacex = 97.5;
  spacey = 88.75;
  spacez = 86.25;
  clearance_hole = 3.1;
  color(panel_color())
  difference(){
    translate ([-50,0,0])
      translate ([sizeofcomb/2,width/2,1/2])
        rounded_rectangle ([sizeofcomb,width,thickness],5);

    linear_extrude(2) translate ([-45,6,0]) letter ("0");
    linear_extrude(2) translate ([-38,6,0]) letter ("x");
    linear_extrude(2) translate ([-31,6,0]) letter ("z");

    linear_extrude(2) translate ([443,6,0]) letter ("y");
    linear_extrude(2) translate ([450,6,0]) letter ("0");

    linear_extrude(2) translate ([0,20,0]) letter ("x");
    for (a =[1:(number)]) {
      translate ([(spacex * a), 0, -epsilon])
      // FIXME - this should be a hole() not a cylinder
        linear_extrude(2){
          hull(){
            circle(clearance_hole/2);
            translate ([0,7.5,0])
              circle(clearance_hole/2);
          }
          translate ([0,-4]) rotate ([0,0,45]) square(5,5);
          translate ([0,13,0])
            letter ("x");
        }
    }
    for (a =[0:(number)]) {
      translate ([(spacez * a), 0, -epsilon])
      // FIXME - this should be a hole() not a cylinder
        linear_extrude(2){
          hull(){
            circle(clearance_hole/2);
            translate ([0,7.5,0])
              circle(clearance_hole/2);
            }
          translate ([0,-4]) rotate ([0,0,45]) square(5,5);
          translate ([0,13,0])
            letter ("z");
        }
    }

    for (a =[0:(number)]) {
      translate ([(spacey * a)+50, width-7.5, -epsilon])
      // FIXME - this should be a hole() not a cylinder
        linear_extrude(2){
          hull(){
            circle(clearance_hole/2);
            translate ([0,7.5,0])
              circle(clearance_hole/2);
            }
            translate ([0,4]) rotate ([0,0,45]) square(5,5);
            translate ([0,-6,0])
              letter ("y");
        }
    }
  }
}

module letter(l) {
  letter_size = 6;
  letter_height = 2;
  font = "stencilla:style=Regular";
	// Use linear_extrude() to make the letters 3D objects as they
	// are only 2D shapes when only using text()
	//linear_extrude(height = letter_height)
  text(l, size = letter_size, font = font, halign = "center", valign = "center", $fn = 16);
}

demo(){
  //projection()
  screw_comb();
}
