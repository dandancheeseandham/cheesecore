//FIXME: this lib should not need to depend on the machine config
include <config.scad>
include <core.scad>

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

// FIXME: would like to have center=true be default on this
module extrusion(extrusion_size, length, slot_width=3.3, center=false) {
  color("silver", 0.9) {
    linear_extrude(length, center=center) {
      extrusion_profile(extrusion_size, slot_width);
    }
  }
}

// FIXME: Would like to phase this out in favor of extrusion() module, as
// that module is oriented centered on the axis rather than having the axis
// on a corner.
module aluminiumextrusion(length,height) {
  translate([extrusion/2, 0, extrusion/2])
    rotate([-90,0,0])
      extrusion(extrusion, length, 3.3);
}

translate([15,0,0]) aluminiumextrusion(100,0);
extrusion_profile(15, 3.3);
translate([50,0,0]) extrusion(15, 100, 3.3);
