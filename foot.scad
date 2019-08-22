use <lib/mirror.scad>
use <lib/holes.scad>
include <config.scad>


foot_height = 50;// FIXME: Just a guess, should make that parametric
panel_outside_radius=5; // FIXME: this needs unified with panel

// FIXME: the profiles use a radius of extrusion/2, should probably use panel_outside_radius everywhere for better visual look.
// FIXME: Need to add inserts for TPU foot bad
// FIXME: Could add some fileting?

// Modeled this foot upside down both for easier printing and because it's a little easier to think about.
module inverted_foot() {
  color(printed_part_color())
  difference() {
    union() {
      hull(){
        // face that touches the bottom panel
        linear_extrude(5) {
          hull() {
            translate([panel_outside_radius, panel_outside_radius])
              circle(r=panel_outside_radius);

            translate([panel_screw_offset, panel_outside_radius])
              circle(r=panel_outside_radius);
            translate([panel_screw_offset, extrusion-panel_outside_radius])
              circle(r=panel_outside_radius);

            translate([panel_outside_radius, panel_screw_offset])
              circle(r=panel_outside_radius);
            translate([extrusion-panel_outside_radius, panel_screw_offset])
              circle(r=panel_outside_radius);
          }
        }
        // 25 = 5 of linear extrude above + 20 from the setback in the foot_base_profile()
        linear_extrude(25) foot_base_profile();
      }
      // main, slimmer body
      linear_extrude(foot_height) foot_base_profile();
    }

    // FIXME: Need to add counterbore for mounting screws
    // FIXME:  This should be modeled using a hole and not a cylinder
    // z=5 is the thickness of the straight-walled base
    translate([panel_screw_offset, extrusion/2, 5]) clearance_hole_with_counterbore(h=5+epsilon, nominal_d=3);
    translate([extrusion/2, panel_screw_offset, 5]) clearance_hole_with_counterbore(h=5+epsilon, nominal_d=3);

    // Access to corner cube
    *translate([extrusion/2, extrusion/2, -epsilon])cylinder(d=7.5, h=foot_height+2*epsilon);
  }
}

module foot_base_profile() {
  hull() {
    translate([panel_outside_radius, panel_outside_radius])
      circle(r=panel_outside_radius);

    translate([panel_screw_offset-20, panel_outside_radius])
      circle(r=panel_outside_radius);
    translate([panel_screw_offset-20, extrusion - panel_outside_radius])
      circle(r=panel_outside_radius);

    translate([panel_outside_radius, panel_screw_offset-20])
      circle(r=panel_outside_radius);
    translate([extrusion - panel_outside_radius, panel_screw_offset-20])
      circle(r=panel_outside_radius);
  }
}

module foot() {
  translate([0,0,foot_height]) mirror([0,0,-1]) inverted_foot();
}

module feet() {
  translate([0, 0, -extrusion_length.z/2 - extrusion -paneldepth])
    mirror_xy() {
      translate([-extrusion_length.x/2-extrusion, -extrusion_length.y/2-extrusion,-foot_height]) foot();
  }
}

// feet();
 foot();
// foot_base_profile();
