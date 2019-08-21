//FIXME: this lib should not need to depend on the machine config
include <config.scad>
include <nopscadlib/core.scad>

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

module extrusion(extrusion_size, length, slot_width=3.3, center=true) {
  color("silver") {
    linear_extrude(length, center=center) {
      extrusion_profile(extrusion_size, slot_width);
    }
  }
}

extrusion_profile(15, 3.3);
translate([50,0,0]) extrusion(15, 100, 3.3);
