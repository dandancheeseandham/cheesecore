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


module top_enclosure_panel_front(x, y) {
  assert(x != undef, "Must specify panel x dimension");
  assert(y != undef, "Must specify panel y dimension");

  difference() {
    //color(acrylic2_color())

      translate ([0, 0, side_panel_thickness()/2])
      rounded_rectangle([x-fitting_error()+extrusion_width()*2, y-fitting_error()+extrusion_width()*2, side_panel_thickness()], panel_radius());
    // Color the holes darker for contrast
    color(panel_color_holes()) {
      top_enclosure_panel_long_mounting_screws(x, y);
      // Access screws to corner cubes
    mirror_xy() {
        translate([x / 2 - extrusion_width() / 2, y / 2 - extrusion_width() / 2, -epsilon])
          cylinder(d=extrusion_width() * 0.5, h = side_panel_thickness() + 2 * epsilon);
      }
    }
  }
}



module top_enclosure_panel_sides(x, y,addx=0,addy=0) {
  assert(x != undef, "Must specify panel x dimension");
  assert(y != undef, "Must specify panel y dimension");

  difference() {

      translate ([0, 0, side_panel_thickness()/2])
      rounded_rectangle([x+addx-fitting_error(), y+addy-fitting_error(), side_panel_thickness()], panel_radius());
    // Color the holes darker for contrast
    translate ([0,-addy/2,0]) color(panel_color_holes()) {
      top_enclosure_panel_mounting_screws(x, y);
      // Access screws to corner cubes
      mirror_xy() {
        translate([(x - extrusion_width() ) / 2, (y - extrusion_width() ) / 2, -epsilon])
          cylinder(d=extrusion_width() / 2, h = side_panel_thickness() + 2 * epsilon);
      }
    }
  }
}




module top_enclosure_panel(x, y,long=false) {
  assert(x != undef, "Must specify panel x dimension");
  assert(y != undef, "Must specify panel y dimension");

  difference() {
    //color(acrylic2_color())

      translate ([0, 0, side_panel_thickness()/2])
      rounded_rectangle([x-fitting_error(), y-fitting_error(), side_panel_thickness()], panel_radius());
    // Color the holes darker for contrast
    color(panel_color_holes()) {
      if (long == false) {top_enclosure_panel_mounting_screws(x, y);}
      if (long == true) {top_enclosure_panel_long_mounting_screws(x, y);}
      // Access screws to corner cubes
    mirror_xy() {
        translate([x / 2 - extrusion_width() / 2, y / 2 - extrusion_width() / 2, -epsilon])
          cylinder(d=extrusion_width() * 0.5, h = side_panel_thickness() + 2 * epsilon);
      }
    }
  }
}

function panel_screw_extent(panel_length) = panel_length - 2 * panel_screw_offset() ;
function panel_screw_count(panel_length) = ceil(panel_screw_extent(panel_length) / max_panel_screw_spacing()) + 1 ;
function panel_screw_spacing(panel_length) = panel_screw_extent(panel_length) / (panel_screw_count(panel_length) - 1);

// Holes to mount panels to extrusion
module top_enclosure_panel_mounting_screws(x, y) {
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


/*

module top_panel_door_old() {
color(acrylic2_color())
//color("red")
  intersection() {
    top_enclosure_panel(enclosure_size().x, enclosure_size().y );
    translate ([0, -extrusion_width()*2-doorgap/2, side_panel_thickness()/2-epsilon])
    rounded_rectangle([enclosure_size().x-extrusion_width()*4-doorgap, enclosure_size().y-extrusion_width()-doorgap,side_panel_thickness()+epsilon*4], panel_radius());
  }
}


module top_panel_door(){
  doorgap = 0.5;
  translate([0, 0 - side_panel_thickness(), enclosure_size().z / 2])
  color(acrylic2_color())
  intersection() {
    top_enclosure_panel(enclosure_size().x, enclosure_size().y );
    translate ([0, -extrusion_width()*2-doorgap/2, side_panel_thickness()/2-epsilon*2])
  *translate ([0, -extrusion_width()-side_panel_thickness()-12, side_panel_thickness()/2-epsilon*2])
  rounded_rectangle([frame_size().x+extrusion_width()*2, enclosure_size().y-extrusion_width()*3,side_panel_thickness()+epsilon], panel_radius());
  translate ([0, -$halo_size.x/2+extrusion_width(), 0])
          rounded_rectangle([frame_size().x-extrusion_width()*2-2, enclosure_size().y-extrusion_width()*3-side_panel_thickness()-1,side_panel_thickness()+epsilon*4], panel_radius());
}
}



module front_panel_door() {
//color(acrylic2_color())
color(acrylic2_color())
union(){
  intersection(){
    top_enclosure_panel(enclosure_size().x, enclosure_size().z-extrusion_width()  + side_panel_thickness() );
       *translate ([0, extrusion_width(), side_panel_thickness()/2-epsilon])
       rounded_rectangle([enclosure_size().x-extrusion_width()*2,enclosure_size().z-extrusion_width()*2 + side_panel_thickness()*2,side_panel_thickness()+epsilon*4], panel_radius());


}
   *translate ([-(enclosure_size().x)/2 + extrusion_width() + doorgap/2 , (enclosure_size().z-extrusion_width())/2-panel_radius()+doorgap/4 ,-(+epsilon*4)])
                    cube([enclosure_size().x-extrusion_width()*6 , panel_radius(),side_panel_thickness()+epsilon*4]);
  }
}

module top_top_enclosure_panel() {
//color("blue")
translate([0, 0, enclosure_size().z / 2])
  difference() {
    top_enclosure_panel(enclosure_size().x, enclosure_size().y);
    translate ([0, -extrusion_width()*2-doorgap/2, side_panel_thickness()/2-epsilon])
    *translate ([0, -extrusion_width()-side_panel_thickness()-12, side_panel_thickness()/2-epsilon])
        rounded_rectangle([frame_size().x+extrusion_width()*2, enclosure_size().y-extrusion_width()*3,side_panel_thickness()+epsilon*4], panel_radius());
    translate ([0, -$halo_size.x/2+extrusion_width(), side_panel_thickness()/2-epsilon])
            rounded_rectangle([frame_size().x-extrusion_width()*2, enclosure_size().y-extrusion_width()*3,side_panel_thickness()+epsilon*4], panel_radius());
          //color(acrylic2_color())
          //translate ([-(enclosure_size().x-60)/2, (enclosure_size().z-extrusion_width())/2-panel_radius() ,-(+epsilon)])
            //  cube([enclosure_size().x-60, panel_radius()+epsilon,side_panel_thickness()+epsilon*4]);
//            top_enclosure_panel($halo_size.x/2+extrusion_width(), enclosure_size().z-extrusion_width());

  }
}


module top_panel_old() {
//color("blue")
  difference() {
    top_enclosure_panel(enclosure_size().x, enclosure_size().y);
        #translate ([0, -extrusion_width()*2, side_panel_thickness()/2-epsilon])
        rounded_rectangle([enclosure_size().x-60, enclosure_size().y-extrusion_width()*3,side_panel_thickness()+epsilon*4], panel_radius());

          color(acrylic2_color())
          *translate ([-(enclosure_size().x-60)/2, (enclosure_size().z-extrusion_width())/2-panel_radius() ,-(+epsilon)])
              cube([enclosure_size().x-60, panel_radius()+epsilon,side_panel_thickness()+epsilon*4]);

  }
}

module front_top_enclosure_panel() {
  difference(){
    top_enclosure_panel(enclosure_size().x, enclosure_size().z-extrusion_width());
    translate ([0, extrusion_width(), side_panel_thickness()/2-epsilon]) rounded_rectangle([enclosure_size().x-60, enclosure_size().z-extrusion_width()*3,side_panel_thickness()+epsilon*4], panel_radius());

    color(acrylic2_color())
     translate ([-(enclosure_size().x-60)/2, (enclosure_size().z-extrusion_width())/2-panel_radius() ,-(+epsilon)])
        cube([enclosure_size().x-60, panel_radius()+epsilon,side_panel_thickness()+epsilon*4]);
}
}


module front_mini_top_enclosure_panel() {
top_enclosure_panel($halo_size.x/2+extrusion_width(), enclosure_size().z-extrusion_width());
}
*/

module top_panel_half1()
{

  {
color(panel_color()) render()
    difference(){
    top_enclosure_panel(enclosure_size().x, enclosure_size().y/2-epsilon,long=true);
    *top_enclosure_window();
  }
  }
}


module top_panel_half2()
{

    {
      color(panel_color()) render()
      difference(){
    top_enclosure_panel(enclosure_size().x, enclosure_size().y/2-epsilon,long=true);
    top_enclosure_window();

  }
}
}


module full_front_top_enclosure_panel()
{
   {
color(panel_color()) render()
      difference () {
        top_enclosure_panel_front(enclosure_size().x-extrusion_width()*2, enclosure_size().z-extrusion_width());
        top_enclosure_window();
      }
    }
  }

module top_enclosure_window(){
//plasticsheets.com 5mm holes 20mm from edge
//210 x 297mm a4
window_width =  550;
window_height = 140;
holedia = 5;
holefromedge = 20;
overlap = 15;
//mirror_xy()
  //translate ([window_width/2-holefromedge/2,window_height/2-holefromedge/2,-10])
    //cylinder(d=5,h=20);
rounded_rectangle ([window_width-holefromedge-overlap,window_height-holefromedge-overlap,50],5);
top_enclosure_panel_mounting_screws(window_width,window_height);
}

module enclosure_hinges() {
  mirror_x()
    translate ([enclosure_size().x/2-extrusion_width()/2-50-86.25/2, enclosure_size().y/2+6,enclosure_size().z/2-extrusion_width()/2])
      rotate([0, 270, 270])
        panelside_hinge(screw_distance = 86.25 ,acrylic_door_thickness=6,extension = 5,screw_type=3);

  mirror_x()
    translate ([enclosure_size().x/2-extrusion_width()/2-50-86.25/2, enclosure_size().y/2+30,enclosure_size().z/2-extrusion_width()/2+15])
      rotate([0, 270, 270])
        rotate([0, 90, 0])  doorside_hinge();
}


module right_side_top_enclosure_panel() {
color(panel_color()) render()
difference(){
  top_enclosure_panel_sides(enclosure_size().y, enclosure_size().z,addx=0,addy=extrusion_width());
  translate([125,0,side_panel_thickness()-epsilon])
    fan_guard_removal(size = 120,thickness = side_panel_thickness()*2);
  *elp_camera_mount_holes();
}
}

module left_side_top_enclosure_panel() {
  color(panel_color()) render()
    top_enclosure_panel_sides(enclosure_size().y, enclosure_size().z,addx=0,addy=extrusion_width());
}


module back_top_enclosure_panel() {
color(panel_color()) render()
  difference(){
  top_enclosure_panel_sides (enclosure_size().x, enclosure_size().z,addx=0,addy=extrusion_width());
//mirror_x()
{
  translate([-150,0,side_panel_thickness()-epsilon])
    fan_guard_removal(size = 120,thickness = side_panel_thickness()*2);
  }
  *elp_camera_mount_holes();
  }

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

module enclosure_side_panels() {
/*  explode = 0;

   *top_panel_door();
   *top_top_enclosure_panel();
  *translate([0, -(enclosure_size().y)/2 - explode -side_panel_thickness(), extrusion_width()/2 + side_panel_thickness()/2 + explode]) rotate([90,0,0]) front_panel_door();
  *translate([0, -(enclosure_size().y)/2, extrusion_width()/2]) rotate([90,0,0]) front_top_enclosure_panel();

  *mirror_x()
    translate([enclosure_size().y/2+$halo_size.x/2-extrusion_width()*2, -(enclosure_size().y)/2 - side_panel_thickness(), extrusion_width()/2 ])
      rotate([90,0,0])
        front_mini_top_enclosure_panel();
*/
  translate([0, enclosure_size().y/4, enclosure_size().z / 2 + extrusion_width()])
    top_panel_half1();

  rotate ([0,0,180])
    translate([0, enclosure_size().y/4, enclosure_size().z / 2 + extrusion_width()])
      top_panel_half2();

  translate([0, -(enclosure_size().y)/2, extrusion_width()/2])
    rotate([90,0,0]) full_front_top_enclosure_panel();

  translate ([-enclosure_size().x /2 - side_panel_thickness(), 0, extrusion_width()/2])
    rotate([90,0,90]) left_side_top_enclosure_panel();

  translate ([enclosure_size().x / 2, 0, extrusion_width()/2])
    rotate([90,0,90]) right_side_top_enclosure_panel();

  translate ([0, enclosure_size().y / 2 + side_panel_thickness(),extrusion_width()/2]) rotate([90,0,0])
    back_top_enclosure_panel();
}

demo()
{
  enclosure_side_panels();
}
