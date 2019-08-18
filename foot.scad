use <lib/mirror.scad>
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
            translate([panel_screw_offset, extrusion/2])
              circle(r=extrusion/2);
            translate([extrusion/2, panel_screw_offset])
              circle(r=extrusion/2);
          }
        }
        // FIXME: the profile here as well as the next profile are the same, need to extract out to their own module
        // angled part, slimmer body
        linear_extrude(foot_height-25) {
          hull() {
            translate([panel_outside_radius, panel_outside_radius])
              circle(r=panel_outside_radius);
            translate([panel_screw_offset-15, extrusion/2])
              circle(r=extrusion/2);
            translate([extrusion/2, panel_screw_offset-15])
              circle(r=extrusion/2);
          }
        }
      }
      // main, slimmer body
      linear_extrude(foot_height) {
        hull() {
          translate([panel_outside_radius, panel_outside_radius])
            circle(r=panel_outside_radius);
          translate([panel_screw_offset-15, extrusion/2])
            circle(r=extrusion/2);
          translate([extrusion/2, panel_screw_offset-15])
            circle(r=extrusion/2);
        }
      }
    }
    //cube([panel_screw_offset+extrusion/2, panel_screw_offset+extrusion/2, foot_height]);

    // FIXME: Need to add counterbore for mounting screws
    // FIXME:  This should be modeled using a hole and not a cylinder
    translate([panel_screw_offset, extrusion/2, -epsilon])cylinder(d=3.3, h=foot_height+2*epsilon);
    translate([extrusion/2, panel_screw_offset, -epsilon])cylinder(d=3.3, h=foot_height+2*epsilon);
    // This could be kept for clearance hole to access corner cube?
    *translate([extrusion/2, extrusion/2, -epsilon])cylinder(d=3.3, h=foot_height+2*epsilon);
  }
}

module foot() {
  translate([0,0,foot_height]) mirror([0,0,-1]) inverted_foot();
}

foot();

module feet() {
  translate([horizontalX/2+extrusion, horizontalY/2+extrusion,-paneldepth])
    mirror_xy() {
      translate([-horizontalX/2-extrusion, -horizontalY/2-extrusion,-foot_height]) foot();
  }
}

// feet();
