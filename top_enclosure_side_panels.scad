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


module panel(x, y) {
  assert(x != undef, "Must specify panel x dimension");
  assert(y != undef, "Must specify panel y dimension");

  difference() {
    //color(acrylic2_color())
    color(panel_color())
      translate ([0, 0, side_panel_thickness()/2])
      rounded_rectangle([x-fitting_error(), y-fitting_error(), side_panel_thickness()], panel_radius());
    // Color the holes darker for contrast
    color(panel_color_holes()) {
      panel_mounting_screws(x, y);
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
module panel_mounting_screws(x, y) {
  // How far from center of first hole to center of last hole
  extent_x = x - 2 * panel_screw_offset();
  extent_y = y - 2 * panel_screw_offset();

  // How many screws in each direction
  screws_x = ceil(extent_x / max_panel_screw_spacing()) + 1;
  screws_y = ceil(extent_y / max_panel_screw_spacing()) + 1;

  // How far between screws
  screw_spacing_x = extent_x / (screws_x - 1);
  screw_spacing_y = extent_y / (screws_y - 1);

  {
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

module top_panel_door() {
color(acrylic2_color())
//color("red")
  intersection() {
    panel(enclosure_size().x, enclosure_size().y );
    translate ([0, -extrusion_width()*2-doorgap/2, side_panel_thickness()/2-epsilon])
    rounded_rectangle([enclosure_size().x-extrusion_width()*4-doorgap, enclosure_size().y-extrusion_width()-doorgap,side_panel_thickness()+epsilon*4], panel_radius());
  }
}

module front_panel_door() {
//color(acrylic2_color())
color(acrylic2_color())
union(){
  intersection(){
    panel(enclosure_size().x, enclosure_size().z-extrusion_width()  + side_panel_thickness() );
       translate ([0, extrusion_width(), side_panel_thickness()/2-epsilon])
       rounded_rectangle([enclosure_size().x-extrusion_width()*2,enclosure_size().z-extrusion_width()*2 + side_panel_thickness()*2,side_panel_thickness()+epsilon*4], panel_radius());


}
   *translate ([-(enclosure_size().x)/2 + extrusion_width() + doorgap/2 , (enclosure_size().z-extrusion_width())/2-panel_radius()+doorgap/4 ,-(+epsilon*4)])
                    cube([enclosure_size().x-extrusion_width()*6 , panel_radius(),side_panel_thickness()+epsilon*4]);
  }
}


module top_panel() {
//color("blue")
  difference() {
    panel(enclosure_size().x, enclosure_size().y);
        translate ([0, -extrusion_width()*2, side_panel_thickness()/2-epsilon]) rounded_rectangle([enclosure_size().x-60, enclosure_size().y-extrusion_width()*3,side_panel_thickness()+epsilon*4], panel_radius());

          color(acrylic2_color())
          *translate ([-(enclosure_size().x-60)/2, (enclosure_size().z-extrusion_width())/2-panel_radius() ,-(+epsilon)])
              cube([enclosure_size().x-60, panel_radius()+epsilon,side_panel_thickness()+epsilon*4]);

  }
}

module front_panel() {
  difference(){
    panel(enclosure_size().x, enclosure_size().z-extrusion_width());
    translate ([0, extrusion_width(), side_panel_thickness()/2-epsilon]) rounded_rectangle([enclosure_size().x-60, enclosure_size().z-extrusion_width()*3,side_panel_thickness()+epsilon*4], panel_radius());

    color(acrylic2_color())
     translate ([-(enclosure_size().x-60)/2, (enclosure_size().z-extrusion_width())/2-panel_radius() ,-(+epsilon)])
        cube([enclosure_size().x-60, panel_radius()+epsilon,side_panel_thickness()+epsilon*4]);
}
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


module right_side_panel() {
  panel(enclosure_size().y, enclosure_size().z-extrusion_width());
}

module left_side_panel() {
  panel(enclosure_size().y, enclosure_size().z-extrusion_width());
}


module back_panel() {
  difference(){
  panel(enclosure_size().x, enclosure_size().z-extrusion_width());
mirror_x(){
  translate([-100,0,side_panel_thickness()-epsilon])
    fan_guard_removal(size = 80,thickness = side_panel_thickness()*2);
  }
  }
}

module enclosure_side_panels() {
  explode = 0;
  translate([0, -explode - side_panel_thickness(), enclosure_size().z / 2 + explode + side_panel_thickness()]) top_panel_door();
  translate([0, 0, enclosure_size().z / 2]) top_panel();
  *translate([0, -(enclosure_size().y)/2 - explode -side_panel_thickness(), extrusion_width()/2 + side_panel_thickness()/2 + explode]) rotate([90,0,0]) front_panel_door();
  *translate([0, -(enclosure_size().y)/2, extrusion_width()/2]) rotate([90,0,0]) front_panel();
  translate ([-enclosure_size().x /2 - side_panel_thickness(), 0, extrusion_width()/2]) rotate([90,0,90]) left_side_panel();
  translate ([enclosure_size().x / 2, 0, extrusion_width()/2]) rotate([90,0,90]) right_side_panel();
  translate ([0, enclosure_size().y / 2 + side_panel_thickness(),extrusion_width()/2]) rotate([90,0,0]) back_panel();
}

demo()
{
  enclosure_side_panels();
}
