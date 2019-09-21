// vim: set nospell:
include <config.scad>
use <nopscadlib/vitamins/stepper_motor.scad>
include <nopscadlib/vitamins/stepper_motors.scad>
use <lib/holes.scad>
use <lib/mirror.scad>
use <door_hinge.scad>
use <screwholes.scad>
use <demo.scad>


module panel(x, y) {
  assert(x != undef, "Must specify panel x dimension");
  assert(y != undef, "Must specify panel y dimension");

  difference() {
    color(acrylic2_color())
      translate ([0, 0, panel_thickness()/2])
      rounded_rectangle([x, y, panel_thickness()], panel_radius());
    // Color the holes darker for contrast
    color(panel_color_holes()) {
      panel_mounting_screws(x, y);
      // Access screws to corner cubes
      mirror_xy() {
        translate([x / 2 - extrusion_width() / 2, y / 2 - extrusion_width() / 2, -epsilon])
          cylinder(d=extrusion_width() * 0.5, h = panel_thickness() + 2 * epsilon);
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

  mirror_y() {
    for (a =[0:(screws_x - 1)]) {
      translate ([-x/2 + panel_screw_offset() + (screw_spacing_x * a), y / 2 - extrusion_width() / 2, -epsilon])
        // FIXME - this should be a hole() not a cylinder
        cylinder(h=panel_thickness() + 2 * epsilon, d=clearance_hole_size(extrusion_screw_size()));
    }
  }

  mirror_x() {
    for (a =[0:(screws_y - 1)]) {
      translate ([x / 2 - extrusion_width() / 2, -y / 2 + panel_screw_offset() + (screw_spacing_y * a), -epsilon])
        // FIXME - this should be a hole not a cylinder
        cylinder(h=panel_thickness() + 2 * epsilon, d=clearance_hole_size(extrusion_screw_size()));
    }
  }
}

module bottom_panel() {

  difference() {
    panel(enclosure_size().x, enclosure_size().y);
    // Deboss instructions on panel
    deboss_depth = 3;
    color("#333333")
      translate([0, -enclosure_size().y/2 + 50, panel_thickness() - deboss_depth + epsilon])
        linear_extrude(deboss_depth)
          text("lid lifts up", halign="center", size=25);
  }
}

module front_panel() {
  difference()
    panel(enclosure_size().x, enclosure_size().z-extrusion_width($extrusion_type));
    // Deboss instructions on panel
    deboss_depth = 3;
    color("#333333")
      translate([0, -enclosure_size().z/2 + 150, panel_thickness() - deboss_depth + epsilon])
        linear_extrude(deboss_depth)
          text("lid lifts up", halign="center", size=25);
}

module enclosure_hinges() {
  mirror_x()
    translate ([enclosure_size().x/2-extrusion_width($extrusion_type)/2-50-86.25/2, enclosure_size().y/2+6,enclosure_size().z/2-extrusion_width($extrusion_type)/2])
      rotate([0, 270, 270])
        panelside_hinge(screw_distance = 86.25 ,acrylic_door_thickness=6,extension = 5,screw_type=3 , $draft = false);

  mirror_x()
    translate ([enclosure_size().x/2-extrusion_width($extrusion_type)/2-50-86.25/2, enclosure_size().y/2+30,enclosure_size().z/2-extrusion_width($extrusion_type)/2+15])
      rotate([0, 270, 270])
        rotate([0, 90, 0])  doorside_hinge();
}


module side_panel() {
  panel(frame_size(). y, enclosure_size().z-extrusion_width($extrusion_type)/2);
}

module back_panel() {
  panel(enclosure_size().x, enclosure_size().z-extrusion_width($extrusion_type)/2);
}

module enclosure_side_panels() {
  translate([0, 0, enclosure_size().z / 2]) bottom_panel();
  translate([0, -(enclosure_size().y)/2, extrusion_width($extrusion_type)/2]) rotate([90,0,0]) front_panel();
  translate([-enclosure_size().x / 2 - panel_thickness(), 0, extrusion_width($extrusion_type)/2]) rotate([90,0,90]) side_panel();
  // FIXME: should move this into a right_side_panel() module and call that.
  translate ([enclosure_size().x / 2, 0, extrusion_width($extrusion_type)/2]) rotate([90,0,90]) side_panel();
  translate ([0, enclosure_size().y / 2 + panel_thickness(),extrusion_width($extrusion_type)/2]) rotate([90,0,0]) back_panel();
}

module all_side_panels_dxf() {
  projection(cut = true) translate([0, 0, 0]) bottom_panel();
  projection(cut = true) translate([0, -(enclosure_size().y)-30, -6])  bottom_panel();
  projection(cut = true) translate([0, -(enclosure_size().y)*2-30, 0])  front_panel(Xwindowspacing=35,Zwindowspacingtop=25, Zwindowspacingbottom=35,screwhole_X = 5, screwhole_Y = 5, corner_radius = 5); // ZL spacing
  // projection(cut = true) translate([0, -(enclosure_size().y)*2-30, 0])  front_panel(Xwindowspacing=35,Zwindowspacingtop=50, Zwindowspacingbottom=50,screwhole_X = 5, screwhole_Y = 7, corner_radius = 5) // ZLT spacing
  projection(cut = true) translate([-(enclosure_size().x)-30,0,0])  side_panel();
  projection(cut = true) translate ([(enclosure_size().x)+30,0,0])  side_panel();
  projection(cut = true) translate ([0,(enclosure_size().y)+30,0])  back_panel();
}

front_panel($extrusion_type = extrusion15, $front_window_size = front_window_zl, $frame_size = frame_rc300zl);
