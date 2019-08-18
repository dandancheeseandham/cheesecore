include <config.scad>
use <vitamins/rail.scad>

// The origin of the z-yoke is the center of the mounting point on the linear rail carriage
module z_yoke() {
  // FIXME: need a fillet between horizontal and vertical surfaces to brace it
  // FIXME: this thickness(10) was just arbitrary to mock something up
  part_thickness = 7.5;
  color(printed_part_color()) {
    difference() {
      // mount face on carriage
      translate([-part_thickness/2,0,0]) cube([part_thickness, carriage_width(carriage_type_z), carriage_length(carriage_type_z)], center=true);

      // need to use holes, not cylinders.  counterbore?
      translate([50,0,0])
        rotate([0,-90,0])
          carriage_hole_positions(carriage_type_z) {
            cylinder(d=3.3,h=100);
          }
    }

    // flat bed mounting ear
    // FIXME: need to make slot/hole for bed to mount through
    // FIXME: the overall extend of the mount toward the bed is just made up - needs to be made parametric
    // FIXME: need to model in holes for the leadscrew anti-backlash nut
    // FIXME: this whole ear probably needs to sit lower than the flush with the z-carriage so it can be made
    // thicker and still have clearance to install screws
    translate([0,0,-carriage_length(carriage_type_z/2)]) {
      linear_extrude(part_thickness) {
        // around leadscrew out to bed ear
        hull() {
          // FIXME: base this on the leadscrew anti-backlash nut size
          translate([leadscrew_x_offset-30/2, -leadscrew_y_offset])
            circle(d=30);
          translate([-30, -leadscrew_y_offset])
            rounded_square([20, 30], r=2.5);
        }
        // bridge from bed ear to upright bracket
        bracket_w=50;
        #translate([-20, -bracket_w/2+carriage_width(carriage_type_z)/2])
          rounded_square([40, bracket_w], r=2.5);
      }
    }
  }
}

z_yoke();
