// vim: set nospell:
use <lib/layout.scad>
use <lib/holes.scad>
include <config.scad>
use <demo.scad>

// FIXME: Need to add inserts for TPU foot bad
// FIXME: Could add some fileting?

// Modeled this foot upside down both for easier printing and because it's a little easier to think about.
module inverted_foot() {
  assert(extrusion_width() != undef, "Unable to figure out extrusion size");
  color(printed_part_color())
    difference() {
      union() {
        hull() {
          // face that touches the bottom panel
          linear_extrude(5) {
            hull() {
              translate([panel_radius(), panel_radius()])
                circle(r=panel_radius());

              translate([panel_screw_offset(), panel_radius()])
                circle(r=panel_radius());
              translate([panel_screw_offset(), extrusion_width()-panel_radius()])
                circle(r=panel_radius());

              translate([panel_radius(), panel_screw_offset()])
                circle(r=panel_radius());
              translate([extrusion_width()-panel_radius(), panel_screw_offset()])
                circle(r=panel_radius());
            }
          }
          // 25 = 5 of linear extrude above + 15 from the setback in the foot_base_profile()
          linear_extrude(20) foot_base_profile();
        }
        // main, slimmer body
        linear_extrude(feetheight()) foot_base_profile();
      }

      // z=5 is the thickness of the straight-walled base
      translate([panel_screw_offset(), extrusion_width()/2, 5]) clearance_hole_with_counterbore(h=5+epsilon, nominal_d=3);
      translate([extrusion_width()/2, panel_screw_offset(), 5]) clearance_hole_with_counterbore(h=5+epsilon, nominal_d=3);
    }
}

module foot_base_profile() {
  assert(extrusion_width != undef, "Must specify extrusion_width");

  foot_taper = 15; //how far in from the panel screw to taper the foot
  hull() {
    translate([panel_radius(), panel_radius()])
      circle(r=panel_radius());

    translate([panel_screw_offset() - foot_taper, panel_radius()])
      circle(r=panel_radius());
    translate([panel_screw_offset() - foot_taper, extrusion_width() - panel_radius()])
      circle(r=panel_radius());

    translate([panel_radius(), panel_screw_offset() - foot_taper])
      circle(r=panel_radius());
    translate([extrusion_width() - panel_radius(), panel_screw_offset() - foot_taper])
      circle(r=panel_radius());
  }
}

// This just flips and translates the foot for easy insertion into the assembled model.  No other manipulation of the part should happen here.
module foot() {
  assert(feetheight() != undef, "Foot feetheight() is required");
  translate([0, 0, feetheight()]) mirror([0,0,-1]) inverted_foot();
}

module feet() {
  translate([0, 0, -frame_size().z / 2 - side_panel_thickness()])
    mirror_xy() {
      translate([-frame_size().x / 2, -frame_size().y / 2, -feetheight()]) foot();
    }
}

demo() {
  // feet();
  inverted_foot();
  //foot_base_profile(15);
}
