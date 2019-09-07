include <config.scad>
use <demo.scad>
use <lib/mirror.scad>
use <nopscadlib/vitamins/rail.scad>

// The origin of the z-yoke is the center of the mounting point on the linear rail carriage
module z_yoke() {
  extrusion_width = extrusion_width($extrusion_type);
  carriage_type = rail_carriage(rail_profiles().z);

  // FIXME: need a fillet between horizontal and vertical surfaces to brace it
  // FIXME: this thickness(10) was just arbitrary to mock something up
  part_thickness = 7.5;
  color(printed_part_color()) {
    difference() {
      // mount face on carriage
      translate([-part_thickness/2,0,0]) cube([part_thickness, carriage_width(carriage_type), carriage_length(carriage_type)], center=true);

      // need to use holes, not cylinders.  counterbore?
      translate([50,0,0])
        rotate([0,-90,0])
          carriage_hole_positions(carriage_type) {
            cylinder(d=3.3,h=100);
          }
    }


    translate([0,0,-carriage_length(carriage_type/2)]) {
      linear_extrude(part_thickness) {
        difference() {
          z_yoke_bed_mount_profile(extrusion_width);
          z_yoke_holes_profile(extrusion_width);
        }
      }
    }
  }
}

ear_extent = 40; // How far from the carriage face the ear should extend.

module z_yoke_bed_mount_profile(extrusion_width) {
  assert(extrusion_width != undef, "Must specify extrusion_width");
  carriage_type = rail_carriage(rail_profiles().z);

  // around leadscrew out to bed ear
  hull() {
    // FIXME: base this on the leadscrew anti-backlash nut size
    translate([carriage_height(carriage_type) + extrusion_width - leadscrew_x_offset, -leadscrew_y_offset])
      circle(d=leadscrew_y_offset);
    translate([-30, -leadscrew_y_offset])
      rounded_square([20, 30], r=2.5);
  }
  // bridge from bed ear to upright bracket
  hull() {
    translate([-ear_extent+2.5, carriage_width(carriage_type)/2 - 2.5]) circle(r=2.5);
    translate([-1, carriage_width(carriage_type)/2 - 1]) square(1);
    translate([-ear_extent,-leadscrew_y_offset]) square([ear_extent, epsilon]);
  }
}

module z_yoke_holes_profile(extrusion_width) {
  assert(extrusion_width != undef, "Must specify extrusion_width");
  carriage_type = rail_carriage(rail_profiles().z);

  // FIXME: should be driven off leadscrew nut size
  translate([carriage_height(carriage_type) + extrusion_width - leadscrew_x_offset, -leadscrew_y_offset]) circle(d=10); // leadscrew nut hole

  // slot for bed moungint screws
  // FIXME: the +10 term here and in the lower translate is made up.  Should derive this from
  // ear extent and bed tab length
  translate([-ear_extent+10, -leadscrew_y_offset]) {
    hull() {
      circle(d=3.3);
      translate([-ear_extent + 10, 0]) circle(d=3.3);
    }
  }

  // the holes to screw the leadscrew in
  // FIXME: made up this pattern
  translate([carriage_height(carriage_type) + extrusion_width - leadscrew_x_offset, -leadscrew_y_offset]) {
    mirror_xy() {
      rotate(45) translate([11, 0]) circle(d=3.3);
    }
  }
}

*difference() {
  z_yoke_bed_mount_profile();
  z_yoke_holes_profile();
}

demo() {
  z_yoke();
}
