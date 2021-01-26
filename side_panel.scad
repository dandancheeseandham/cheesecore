// vim: set nospell:
include <config.scad>
use <nopscadlib/vitamins/stepper_motor.scad>
include <nopscadlib/vitamins/stepper_motors.scad>
use <fan_guard_removal.scad>
use <lib/holes.scad>
use <lib/layout.scad>
use <door_hinge.scad>
use <screwholes.scad>
use <constants.scad>
use <demo.scad>

function window_radius() = 5;
function hole_from_edge() = 25;
function window_overlap() = 10*2;
function window_smaller_than_panel() = 20*2;

module universal_panel(x = 600,y=200,addx=0,addy=0, moveholex = 0,moveholey = 0, window = false){

  assert(x != undef, "Must specify panel x dimension");
  assert(y != undef, "Must specify panel y dimension");
  window_width  = x - window_smaller_than_panel() ;
  window_height = y - window_smaller_than_panel() ;
linear_extrude(side_panel_thickness())
  difference() {
    //translate ([0, 0, side_panel_thickness()/2])
      rounded_square([x+addx-fitting_error(), y+addy-fitting_error()],panel_radius());
      //rounded_rectangle([x+addx-fitting_error(), y+addy-fitting_error(), side_panel_thickness()], panel_radius());
    // Color the holes darker for contrast
    color(panel_color_holes())
      translate ([moveholex/2,moveholey/2])
        universal_panel_mounting_screws_2d(x-(sign(moveholex)*moveholex), y-(sign(moveholey)*moveholey));
    /*if (window){
      rounded_square ([window_width-hole_from_edge()-window_overlap(),window_height-hole_from_edge()-window_overlap()],window_radius());
      universal_panel_mounting_screws_2d(window_width,window_height,cornercubes=false);
      echo ("window_width:", window_width)
      echo ("window_height:", window_height);
      }
      */

  }
  //if (window) rounded_rectangle ([window_width,window_height,100],window_radius());
}

module window_2d(x = 600,y=200){
  rounded_square ([x - window_smaller_than_panel() - window_overlap(),y - window_smaller_than_panel() - window_overlap()],window_radius());
  universal_panel_mounting_screws_2d(x - window_smaller_than_panel() - window_overlap() + hole_from_edge(),y - window_smaller_than_panel() - window_overlap() + hole_from_edge(),cornercubes=false);
}

module window_real_2d(x = 600,y=200){
difference(){
  rounded_square ([x - window_smaller_than_panel(),y - window_smaller_than_panel()],window_radius());
  universal_panel_mounting_screws_2d(x - window_smaller_than_panel() - window_overlap() + hole_from_edge(),y - window_smaller_than_panel() - window_overlap() + hole_from_edge(),cornercubes=false);
  }
  echo ("WINDOW",x-hole_from_edge()-window_overlap(),y-hole_from_edge()-window_overlap());

}



module universal_panel_2d(x = 600,y=200, radius = panel_radius()) {

  assert(x != undef, "Must specify panel x dimension");
  assert(y != undef, "Must specify panel y dimension");

      rounded_square([x-fitting_error(), y-fitting_error()],radius);
    *echo ("window_width:", window_width)
    *echo ("window_height:", window_height);
  //}
  //}

}

module single_line_panel_mounting_screws_2d(x) {
  // How far from center of first hole to center of last hole
  extent_x = x - 2 * panel_screw_offset();

  // How many screws in each direction
  screws_x = ceil(extent_x / max_panel_screw_spacing()) + 1;

  // How far between screws
  screw_spacing_x = extent_x / (screws_x - 1);

  //echo ("top enclosure screw_spacing_x for ", x, " mm ",screw_spacing_x);
  //echo ("top enclosure screw_spacing_y for ", y, " mm ",screw_spacing_y);
  //mirror_y()
{
    for (a =[0:(screws_x - 1)])
      translate ([-x/2 + panel_screw_offset() + (screw_spacing_x * a), frame_size().z / 2 - extrusion_width() / 2-60])
        // FIXME - this should be a hole() not a cylinder
        circle (d=clearance_hole_size(extrusion_screw_size()));
}
}


module universal_panel_mounting_screws_2d(x, y, cornercubes = true) {
  // How far from center of first hole to center of last hole
  extent_x = x - 2 * panel_screw_offset();
  extent_y = y - 2 * panel_screw_offset();

  // How many screws in each direction
  screws_x = ceil(extent_x / max_panel_screw_spacing()) + 1;
  screws_y = ceil(extent_y / max_panel_screw_spacing()) + 1;

  // How far between screws
  screw_spacing_x = extent_x / (screws_x - 1);
  screw_spacing_y = extent_y / (screws_y - 1);



  //echo ("top enclosure screw_spacing_x for ", x, " mm ",screw_spacing_x);
  //echo ("top enclosure screw_spacing_y for ", y, " mm ",screw_spacing_y);
  //mirror_y()
mirror_xy(){
    for (a =[0:(screws_x - 1)])
      translate ([-x/2 + panel_screw_offset() + (screw_spacing_x * a), y / 2 - extrusion_width() / 2])
        // FIXME - this should be a hole() not a cylinder
        circle (d=clearance_hole_size(extrusion_screw_size()));

    for (a =[0:(screws_y - 1)])
      translate ([x / 2 - extrusion_width() / 2, -y / 2 + panel_screw_offset() + (screw_spacing_y * a)])
        // FIXME - this should be a hole not a cylinder
        circle (d=clearance_hole_size(extrusion_screw_size()));


    // Access screws to corner cubes
    if (cornercubes)
      translate([(x - extrusion_width() ) / 2, (y - extrusion_width() ) / 2])
        circle (d=extrusion_width() / 2);
        }
}




module universal_panel_xx(x = 600,y=200,addx=0,addy=0, moveholex = 0,moveholey = 0, window = true){
  assert(x != undef, "Must specify panel x dimension");
  assert(y != undef, "Must specify panel y dimension");
  difference() {
    translate ([0, 0, side_panel_thickness()/2])
      rounded_rectangle([x+addx-fitting_error(), y+addy-fitting_error(), side_panel_thickness()], panel_radius());
    // Color the holes darker for contrast
    translate ([moveholex,moveholey,0])
     color(panel_color_holes())
      universal_panel_mounting_screws(x-moveholex, y);
    if (window){
      holedia = 5;
      holefromedge = 20;
      overlap = 15;
      window_width = x - 60;
      window_height = y - 60;
    rounded_rectangle ([window_width-holefromedge-overlap,window_height-holefromedge-overlap,50],holedia);
    universal_panel_mounting_screws(window_width,window_height,cornercubes=false);
    echo ("window_width:", window_width)
    echo ("window_height:", window_height);
  }
  }
}

// Holes to mount panels to extrusion
module universal_panel_mounting_screws(x, y, cornercubes = true) {
  // How far from center of first hole to center of last hole
  extent_x = x - 2 * panel_screw_offset();
  extent_y = y - 2 * panel_screw_offset();

  // How many screws in each direction
  screws_x = ceil(extent_x / max_panel_screw_spacing()) + 1;
  screws_y = ceil(extent_y / max_panel_screw_spacing()) + 1;

  // How far between screws
  screw_spacing_x = extent_x / (screws_x - 1);
  screw_spacing_y = extent_y / (screws_y - 1);
  //echo ("top enclosure screw_spacing_x for ", x, " mm ",screw_spacing_x);
  //echo ("top enclosure screw_spacing_y for ", y, " mm ",screw_spacing_y);
  //mirror_y()
mirror_xy(){
    for (a =[0:(screws_x - 1)])
      translate ([-x/2 + panel_screw_offset() + (screw_spacing_x * a), y / 2 - extrusion_width() / 2, -epsilon])
        // FIXME - this should be a hole() not a cylinder
        cylinder(h=side_panel_thickness() + 2 * epsilon, d=clearance_hole_size(extrusion_screw_size()));

    for (a =[0:(screws_y - 1)])
      translate ([x / 2 - extrusion_width() / 2, -y / 2 + panel_screw_offset() + (screw_spacing_y * a), -epsilon])
        // FIXME - this should be a hole not a cylinder
        cylinder(h=side_panel_thickness() + 2 * epsilon, d=clearance_hole_size(extrusion_screw_size()));

    // Access screws to corner cubes
    if (cornercubes)
      translate([(x - extrusion_width() ) / 2, (y - extrusion_width() ) / 2, -epsilon])
        cylinder(d=extrusion_width() / 2, h = side_panel_thickness() + 2 * epsilon);
        }
}


// Holes to mount panels to extrusion
module top_enclosure_panel_long_mounting_screws(x, y) {
  // How far from center of first hole to center of last hole
  extent_x = x - 2 * panel_screw_offset();
  extent_y = y - 2 * panel_screw_offset();

  // How many screws in each direction
  screws_x = ceil(extent_x / max_panel_screw_spacing()) + 1;
  screws_y = ceil(extent_y / max_panel_screw_spacing()) + 1;

  // How far between screws
  screw_spacing_x = extent_x / (screws_x - 1);
  screw_spacing_y = extent_y / (screws_y - 1);
  //echo ("top enclosure screw_spacing_x for ", x, " mm ",screw_spacing_x);
  //echo ("top enclosure screw_spacing_y for ", y, " mm ",screw_spacing_y);
  {mirror_y()
    for (a =[0:(screws_x - 1)]) {
      //echo ([-x/2 + panel_screw_offset() , (screw_spacing_x ),a , y / 2 , extrusion_width() / 2, -epsilon]);
      translate ([-x/2 + panel_screw_offset() + (screw_spacing_x * a), y / 2 - extrusion_width() / 2, -epsilon])
        // FIXME - this should be a hole() not a cylinder
        //cylinder(h=side_panel_thickness() + 2 * epsilon, d=clearance_hole_size(extrusion_screw_size()));
        translate ([-20,0,0]) longscrewhole(40,3,0.15);
    }
  }

  mirror_x() {
    for (a =[0:(screws_y - 1)]) {
      translate ([x / 2 - extrusion_width() / 2, -y / 2 + panel_screw_offset() + (screw_spacing_y * a), -epsilon])
        // FIXME - this should be a hole not a cylinder
        //cylinder(h=side_panel_thickness() + 2 * epsilon, d=clearance_hole_size(extrusion_screw_size()));
        translate ([0,-20,0]) rotate ([0,0,90]) longscrewhole(40,3,0.15);
    }
  }
}


module top_enclosure_window(window_width = 550,window_height = 140,holedia = 5,holefromedge = 20,overlap = 15){
//plasticsheets.com 5mm holes 20mm from edge
//210 x 297mm a4
//window_width =  550;
//window_height = 140;
//holedia = 5;
//holefromedge = 20;
//overlap = 15;
//mirror_xy()
  //translate ([window_width/2-holefromedge/2,window_height/2-holefromedge/2,-10])
    //cylinder(d=5,h=20);
    //rounded_rectangle ([window_width-overlap,window_height-overlap,50],5);
    rounded_rectangle ([window_width-holefromedge-overlap,window_height-holefromedge-overlap,50],5);
    universal_panel_mounting_screws(window_width,window_height,cornercubes=false);
}


module elp_camera_mount_holes(){
// 28mm inside holes , 34mm outside holes
  mirror_xy() {
     cylinder (d=15.2, h=20);
    translate ([28/2,28/2,0])
      cylinder (d=3.2, h=20);
    translate ([34/2,34/2,0])
      cylinder (d=3.2, h=20);
  }
}

module panel(x, y,addx=0,addy=0) {
  assert(x != undef, "Must specify panel x dimension");
  assert(y != undef, "Must specify panel y dimension");

  difference() {

      translate ([0, -addy/2, side_panel_thickness()/2])
      rounded_rectangle([x+addx-fitting_error(), y+addy-fitting_error(), side_panel_thickness()], panel_radius());
    // Color the holes darker for contrast
    color(panel_color_holes())  {
      panel_mounting_screws(x, y);
      // Access screws to corner cubes
      mirror_xy() {
        translate([(x - extrusion_width() ) / 2, (y - extrusion_width() ) / 2, -epsilon])
          cylinder(d=extrusion_width() / 2, h = side_panel_thickness() + 2 * epsilon);
      }
    }
  }
}

// Holes to mount panels to extrusion
module panel_mounting_screws(x, y)
{
  // How far from center of first hole to center of last hole
  extent_x = x - 2 * panel_screw_offset();
  extent_y = y - 2 * panel_screw_offset();

  // How many screws in each direction
  screws_x = ceil(extent_x / max_panel_screw_spacing()) + 1;
  screws_y = ceil(extent_y / max_panel_screw_spacing()) + 1;

  // How far between screws
  screw_spacing_x = extent_x / (screws_x - 1);
  screw_spacing_y = extent_y / (screws_y - 1);

  mirror_y() {
    for (a =[0:(screws_x - 1)]) {
      translate ([-x/2 + panel_screw_offset() + (screw_spacing_x * a), y / 2 - extrusion_width() / 2, -epsilon])
        // FIXME - this should be a hole() not a cylinder
        cylinder(h=side_panel_thickness() + 2 * epsilon, d=clearance_hole_size(extrusion_screw_size()));
    }
  }

  mirror_x() {
    for (a =[0:(screws_y - 1)]) {
      translate ([x / 2 - extrusion_width() / 2, -y / 2 + panel_screw_offset() + (screw_spacing_y * a), -epsilon])
        // FIXME - this should be a hole not a cylinder
        cylinder(h=side_panel_thickness() + 2 * epsilon, d=clearance_hole_size(extrusion_screw_size()));
    }
  }
}



demo(){
difference(){
  universal_panel(x = 600,y=300,addx=0,addy=0, moveholex = 0,moveholey = 0, window = true);
  //top_enclosure_window();
}
}
