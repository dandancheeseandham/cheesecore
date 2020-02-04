// vim: set nospell:
include <constants.scad>
use <lib/layout.scad>
use <lib/holes.scad>
use <demo.scad>

module anti_backlash_nut(screw_size) {
  color("#b5a642") {
    difference() {
      union() {
        translate([0,0,32])
          cylinder(d=16, h=4);
          cylinder(d=12, h=36);
          cylinder(d=30, h=4);
        }

      // mount bolt pattern
      mirror_xy() {
        rotate([0,0, 45])
          translate([0, 11, 4])
            clearance_hole(nominal_d=3, h=10);
      }

      translate([0,0,-epsilon]) cylinder(d=8+5*epsilon, h=36+2*epsilon);
      }
  }
}

demo() {
  anti_backlash_nut(8);
}
