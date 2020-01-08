// vim: set nospell:
use <lib/layout.scad>
use <lib/holes.scad>
include <config.scad>
use <demo.scad>

panel_outside_radius=panel_radius();

// FIXME: Need to add inserts for TPU foot bad
// FIXME: Could add some fileting?

// Modeled this foot upside down both for easier printing and because it's a little easier to think about.
module inverted_foot(height=50) {
  extrusion = extrusion_width();
  assert(extrusion != undef, "Unable to figure out extrusion size");
  color(printed_part_color())
    difference() {
      union() {
        hull(){
          // face that touches the bottom panel
          linear_extrude(5) {
            hull() {
              translate([panel_outside_radius, panel_outside_radius])
                circle(r=panel_outside_radius);

              translate([panel_screw_offset(), panel_outside_radius])
                circle(r=panel_outside_radius);
              translate([panel_screw_offset(), extrusion-panel_outside_radius])
                circle(r=panel_outside_radius);

              translate([panel_outside_radius, panel_screw_offset()])
                circle(r=panel_outside_radius);
              translate([extrusion-panel_outside_radius, panel_screw_offset()])
                circle(r=panel_outside_radius);
            }
          }
          // 25 = 5 of linear extrude above + 15 from the setback in the foot_base_profile()
          linear_extrude(20) foot_base_profile(extrusion);
        }
        // main, slimmer body
        linear_extrude(height) foot_base_profile(extrusion);
      }

      // z=5 is the thickness of the straight-walled base
      translate([panel_screw_offset(), extrusion/2, 5]) clearance_hole_with_counterbore(h=5+epsilon, nominal_d=3);
      translate([extrusion/2, panel_screw_offset(), 5]) clearance_hole_with_counterbore(h=5+epsilon, nominal_d=3);
    }
}

module foot_base_profile(extrusion_width) {
  assert(extrusion_width != undef, "Must specify extrusion_width");

  reduce_size = 15; //how far in from the panel screw to taper the foot
  hull() {
    translate([panel_outside_radius, panel_outside_radius])
      circle(r=panel_outside_radius);

    translate([panel_screw_offset() - reduce_size, panel_outside_radius])
      circle(r=panel_outside_radius);
    translate([panel_screw_offset() - reduce_size, extrusion_width- panel_outside_radius])
      circle(r=panel_outside_radius);

    translate([panel_outside_radius, panel_screw_offset() - reduce_size])
      circle(r=panel_outside_radius);
    translate([extrusion_width - panel_outside_radius, panel_screw_offset() - reduce_size])
      circle(r=panel_outside_radius);
  }
}

// This just flips and translates the foot for easy insertion into the assembled model.  No other manipulation of the part should happen here.
module foot(height = 50) {
  assert(height != undef, "Foot height is required");
  translate([0, 0, height]) mirror([0,0,-1]) inverted_foot(height);
}

module feet(height = 50) {
  extrusion = extrusion_width();
  translate([0, 0, -frame_size().z / 2 - panel_thickness()])
    mirror_xy() {
      translate([-frame_size().x / 2, -frame_size().y / 2, -height]) foot(height = height);
    }
}

demo() {
  // feet();
  foot(height=50);
  //foot_base_profile(15);
}
