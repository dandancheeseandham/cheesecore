// vim: set nospell:
include <constants.scad>
include <nopscadlib/core.scad>
use <lib/holes.scad>
use <demo.scad>

module extrusion_profile(extrusion_size, slot_width) {
  difference() {
    // outside profile
    rounded_square(extrusion_size, r=0.5, $fn=12);

    // center hole
    circle(d=slot_width, $fs=slot_width/4);

    // slots
    translate([extrusion_size/2-slot_width/2+epsilon,0])
      square([slot_width, slot_width], center=true);
    translate([-extrusion_size/2+slot_width/2-epsilon,0])
      square([slot_width, slot_width], center=true);
    translate([0, extrusion_size/2-slot_width/2+epsilon])
      square([slot_width, slot_width], center=true);
    translate([0, -extrusion_size/2+slot_width/2-epsilon])
      square([slot_width, slot_width], center=true);
  }
}

module extrusion(length, center=true, extrusion_type = $extrusion_type) {
  extrusion_size = extrusion_width(extrusion_type);
  slot_width = extrusion_screw_size(extrusion_type);

  assert(extrusion_size != undef, "Could not look up extrusion_size");

  color(alum_commercial_part_color()) {
    linear_extrude(length, center=center) {
      extrusion_profile(extrusion_size, slot_width);
    }
  }
}


demo() {
extrusion_profile(extrusion_width($extrusion_type), 3.3);
translate([50,0,0])
  extrusion(length=100);
}
