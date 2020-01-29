// vim: set nospell:
include <config.scad>
use <demo.scad>
use <lib/layout.scad>
use <lib/holes.scad>
use <nopscadlib/vitamins/rail.scad>
use <nopscadlib/utils/fillet.scad>

// The origin of the z-yoke is the center of the mounting point on the linear rail carriage
module z_yoke() {
  extrusion_width = extrusion_width();
  carriage_type = rail_carriage(rail_profiles().z);
  railmount = 12.5;
  part_thickness = 7.8;
  extra_mount_length = 0; // how much longer to make the mount so we can have the horizontal pieces below the mounting screws
  color(printed_part_color()) {
    difference() {
      // "mounted face" to attach to rail carriage
      translate([-part_thickness/2, 0, -extra_mount_length/2-railmount])
        rotate ([0,90,0])
          rounded_rectangle([carriage_length(carriage_type) + extra_mount_length-8,carriage_width(carriage_type),part_thickness], 2);

      // remove screwholes from mounted face
      // FIXME: This needs to match rail screw M size
      translate([50,0,-railmount])
        rotate([0,90,0])
          carriage_hole_positions(carriage_type) {
            clearance_hole(nominal_d=3, h=100);
            }
    }
//fillet rail to leadscrew
translate([0,-16,-railmount+epsilon/2])
  fillet(1.6, part_thickness, center = true);
//fillet removal
  translate([-17,-16,-railmount+epsilon/2])
  rotate([0,180,0])
    fillet(1.6, part_thickness, center = true);



//fillets to connect mounted face to main body
color(printed_part_color())
  translate([-part_thickness, 0, -extra_mount_length/2-railmount+3.8])
    rotate ([90,0,180])
      fillet(4, carriage_width(carriage_type), center = true);

translate([-part_thickness, 0, -extra_mount_length/2-railmount-3.8])
  rotate ([270,0,180])
    fillet(4, carriage_width(carriage_type), center = true);

    // flat bed mounting ear
    translate([0,0,-carriage_length(carriage_type/2) - extra_mount_length+1]) {
      linear_extrude(part_thickness) {
        difference() {
          z_yoke_bed_mount_profile(extrusion_width);
          z_yoke_holes_profile(extrusion_width);

          }
      }
    }

    // reinforcing rib
    *hull() {
      // top corner
      translate([- part_thickness, -part_thickness/2, carriage_length(carriage_type) /2 - epsilon]) cube([epsilon, part_thickness, epsilon]);
      // corner near ear
      translate([-ear_extent(), -part_thickness/2, - carriage_length(carriage_type) / 2 +extra_mount_length/2 - epsilon]) cube([epsilon, part_thickness, epsilon]);
      // base/inside corner
      translate([- part_thickness, -part_thickness/2, -carriage_length(carriage_type) / 2 - epsilon]) cube([epsilon, part_thickness, epsilon]);
    }
  }
}

// How far from the carriage face the ear should extend.
// The -1 term provides a bit of clearance to allow misalignment
function ear_extent() = (frame_size().x - 4 * extrusion_width() - 2 * carriage_height(rail_carriage(rail_profiles().z)) - $bed[1][0]) / 2 - 1;

module z_yoke_bed_mount_profile(extrusion_width) {
  assert(extrusion_width != undef, "Must specify extrusion_width");
  carriage_type = rail_carriage(rail_profiles().z);
shrink = 2;
  // around leadscrew out to bed ear
  hull() {
    // FIXME: base this on the leadscrew anti-backlash nut size
    translate([carriage_height(carriage_type) + extrusion_width - leadscrew_x_offset, -leadscrew_y_offset])
      circle(d=leadscrew_y_offset-shrink);

    translate([-ear_extent() + 20 / 2, -leadscrew_y_offset])
      rounded_square([10.1, 30-shrink], r=2.5);
  }
  minimise = 21.5;
  // bridge from bed ear to upright bracket
  hull() {
    translate([-ear_extent()+2.5+minimise, carriage_width(carriage_type)/2 - 2.5]) circle(r=2.5);
    translate([-1, carriage_width(carriage_type)/2 - 1]) square(1);
    translate([-ear_extent()+minimise,-leadscrew_y_offset]) square([ear_extent()-minimise, epsilon]);
  }
}

module z_yoke_holes_profile(extrusion_width) {
  assert(extrusion_width != undef, "Must specify extrusion_width");
  carriage_type = rail_carriage(rail_profiles().z);

  // FIXME: should be driven off leadscrew nut size
  translate([carriage_height(carriage_type) + extrusion_width - leadscrew_x_offset, -leadscrew_y_offset])
    circle(d=leadscrew_diameter()+leadscrew_clearance()); // leadscrew nut hole

  // slot for bed moungint screws
  // FIXME: the +10 term here and in the lower translate is made up.  Should derive this from
  // ear extent and bed tab length
  derivedearextentbedtablength = 12 ;
  //6.5 = move
  // 27.5 = long
  movehole = 8.5 ;
  translate([-ear_extent()+derivedearextentbedtablength+movehole, -leadscrew_y_offset]) {
    hull() {
      circle(d=3.3);
      translate([-ear_extent()+18+movehole, 0]) circle(d=3.3);
    }
  }

holes(leadscrew_number_of_holes());

module holes(number_holes){
    // the holes to screw the leadscrew in
    // FIXME: made up this pattern, should come from anti-backlash nut
if (number_holes == 4) {
  translate([carriage_height(carriage_type) + extrusion_width - leadscrew_x_offset, -leadscrew_y_offset]) {
    mirror_xy() {
      rotate(45) translate([leadscrew_pcd1()/2, 0]) circle(d=leadscrew_nut_screwholes());
    }
  }
}

if (number_holes == 6) {
  translate([carriage_height(carriage_type) + extrusion_width - leadscrew_x_offset, -leadscrew_y_offset]) {
    mirror_xy() {
      rotate(60) translate([leadscrew_pcd1()/2, 0]) circle(d=leadscrew_nut_screwholes());
      translate([leadscrew_pcd1()/2, 0]) circle(d=3.4);
    }
  }
}

if (number_holes == 8) {
  translate([carriage_height(carriage_type) + extrusion_width - leadscrew_x_offset, -leadscrew_y_offset]) {
    rotate ([0,0,45])
    mirror_xy() {
      rotate(45) translate([leadscrew_pcd2()/2, 0]) circle(d=leadscrew_nut_screwholes());
      *translate([leadscrew_pcd1()/2, 0]) circle(d=3.4);
    }
    mirror_xy(){
      rotate(45) translate([leadscrew_pcd1()/2, 0]) circle(d=leadscrew_nut_screwholes());
    }
  }
}

}
    }



demo() {
  z_yoke();
}
