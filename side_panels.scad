// vim: set nospell:
include <config.scad>
include <nopscadlib/core.scad>
use <lib/holes.scad>
use <lib/mirror.scad>
use <door_hinge.scad>
use <screwholes.scad>


module panel(x, y)
{
  assert(x != undef, "Must specify panel x dimension");
  assert(y != undef, "Must specify panel y dimension");

  difference() {
    color(panel_color())
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

function panel_screw_extent(panel_length) = panel_length - 2 * panel_screw_offset();
function panel_screw_count(panel_length) = ceil(panel_screw_extent(panel_length) / max_panel_screw_spacing()) + 1;
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
  module motor_holes() {
    cylinder(h=15, d=NEMA_boss_radius(NEMA17) * 2 + 1);
    mirror_xy() {
      translate([ NEMA_hole_pitch(NEMA17)/2, NEMA_hole_pitch(NEMA17)/2, -1 ])
        // FIXME: this diameter should be driven by stepper size. (Looked in modules, there is no definition for this.-dan)
        // FIXME this needs to be a hole() not a cylinder
        cylinder(d=3.3, h=panel_thickness() + 2 * epsilon);
    }
  }

  difference() {
    panel(frame_size().x, frame_size().y);

    color(panel_color_holes()) {
      translate([bed_offset.x, bed_offset.y, 0]) {
        // left side holes
        mirror_y() {
          translate([-frame_size().x / 2 - extrusion_width() + leadscrew_x_offset, 255/2, -1])
            motor_holes();
        }
        // right side holes
        translate([frame_size().x / 2 - leadscrew_x_offset, 0, -1])
          motor_holes();
      }

      // Deboss a name in the bottom panel
      deboss_depth = 3;
      translate([0, -frame_size().y/2 + 50, panel_thickness() - deboss_depth + epsilon])
        linear_extrude(deboss_depth)
        text(branding_name, halign="center", size=35);
    }
  }
}

module front_panel() {
  assert(front_window_size().x <= frame_size().x - 2 * extrusion_width(), str("Window cannot overlap extrusion in X: "));
  assert(front_window_size().y <= frame_size().z - 2 * extrusion_width(), "Window cannot overlap extrusion in Z");
  // FIXME to make this assert work again
  //assert(Zwindowspacingbottom >= extrusion_width(), "Window cannot overlap extrusion in Z");

  difference() {
    panel(frame_size().x, frame_size().z);

    color(panel_color_holes())
      translate ([front_window_offset().x, front_window_offset().y, panel_thickness() / 2])
      rounded_rectangle([front_window_size().x, front_window_size().y, panel_thickness() + 2 * epsilon], front_window_radius());
  }

  // panel hinges
  panelrounding = 5 ;
  hole_distance_from_edge = 7.5 ;
}

module hinges() {
  translate([0, -frame_size().y/2 - panel_thickness(), 0]) rotate([90, 0, 0]) {
    mirror_xy() {
      // FIXME: the -5 term here is bogus
      translate([-frame_size().x / 2, frame_size().y / 2 - panel_screw_offset() - 5, panel_thickness()])
        front_panel_doors_hinge(screw_distance = panel_screw_spacing(frame_size().z), acrylic_door_thickness=5, screw_type=3);
    }

    color(printed_part_color())
      mirror_xy() {
        // FIXME: the -1 and -50 here are bogus, but this component will get replaced anyway
        translate([-(frame_size().x / 2) - 1, frame_size().z / 2 - 50, panel_thickness()])
          import("./railcorestls/lostapathy/doors/railcore-hinge-doorside.stl");
      }
  }
}

// One door - the right side as facing printer
// Origin is the centerline between the doors at the middle of the height. So not quite on the door, but rather in the gap between where they meet together
module door() {
  door_gap = 1; // How far do we want between doors?
  door_overlap = 10; // How far do we want the doors to overlap the panel edges?
  door_radius_mating_corners = 2.5; // radius of the corners where the panels come together
  door_radius_outside_corners = front_window_radius() + door_overlap;
  difference() {
    // Outline of the door
    color(acrylic2_color()) {
      // FIXME - make door thickness parametric
      linear_extrude(1/8 * inch) {
        hull() {
          mirror_y() {
            // The smaller corners where the doors meet
            translate([door_radius_mating_corners + door_gap / 2, front_window_size().y / 2 + door_overlap - door_radius_mating_corners])
              circle(r = door_radius_mating_corners);
            // Larger corners that mirror the opening
            translate([front_window_size().x / 2 - front_window_radius(), front_window_size().y / 2 - door_overlap])
              circle(r = door_radius_outside_corners);
          }
        }
      }
    }

    // Hinge holes
    // FIXME: add these

    // Door pull holes
    // FIXME: add these
  }
}

module doors() {
  rotate([90, 0, 0])
    translate(front_window_offset())
    mirror_x()
    %door();
}

module side_panel() {
  panel(frame_size(). y, frame_size().z);
}

module back_panel(){
  panel(frame_size().x, frame_size().z);
}

module all_side_panels()
{
  // FIXME this is not right
  translate([0, 0, -frame_size().z / 2 - panel_thickness()]) bottom_panel();
  translate([0, -(frame_size().y)/2, 0]) rotate([90,0,0]) front_panel(); // ZL spacing
  translate([-frame_size().x / 2 - panel_thickness(), 0, 0]) rotate([90,0,90]) side_panel();
  translate ([frame_size().x / 2, 0, 0]) rotate([90,0,90]) side_panel();
  translate ([0, frame_size().y / 2 + panel_thickness(),0]) rotate([90,0,0]) back_panel();
}

module all_side_panels_dxf()
{
  projection(cut = true) translate([0, 0, 0]) bottom_panel();
  projection(cut = true) translate([0, -(frame_size().y)-30, -6])  bottom_panel();
  projection(cut = true) translate([0, -(frame_size().y)*2-30, 0])  front_panel(Xwindowspacing=35,Zwindowspacingtop=25, Zwindowspacingbottom=35,screwhole_X = 5, screwhole_Y = 5, corner_radius = 5); // ZL spacing
  // projection(cut = true) translate([0, -(frame_size().y)*2-30, 0])  front_panel(Xwindowspacing=35,Zwindowspacingtop=50, Zwindowspacingbottom=50,screwhole_X = 5, screwhole_Y = 7, corner_radius = 5) // ZLT spacing
  projection(cut = true) translate([-(frame_size().x)-30,0,0])  side_panel();
  projection(cut = true) translate ([(frame_size().x)+30,0,0])  side_panel();
  projection(cut = true) translate ([0,(frame_size().y)+30,0])  back_panel();
}

//all_side_panels_dxf();
//all_side_panels();
//bottom_panel();
// Must supply these params when calling this and not define it global to the file
front_panel($extrusion_type = extrusion15, $front_window_size = front_window_zl);
//hinges();
//doors();
