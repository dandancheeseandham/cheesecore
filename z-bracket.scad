// vim: set nospell:
include <config.scad>
use <lib/layout.scad>
use <lib/holes.scad>
use <demo.scad>

// The origin of this part is on the flat-side (i.e., printed down) at the corner of the printed part where the extrusion sits.
// There was no great/obvious way to orient this part - it's complicated.
module z_bracket(extrusion_type) {
  leg_length = extrusion_width()*4;
  thickness = extrusion_width()-5;
  corner_radius = 2;

  color(printed_part_color())
    render() // FIXME: this render() prevents an artifact in the assembled printer, but model seems put together fine on it's own?
      difference() {
        union() {

          // horizontal leg
          hull() {
            cube([extrusion_width(), 1, thickness]);
            translate([corner_radius, leg_length - corner_radius, 0])
              cylinder(r=corner_radius, h=thickness);
            translate([extrusion_width() - corner_radius, leg_length - corner_radius, 0])
              cylinder(r=corner_radius, h=thickness);
          }

          // material for fillets
          translate([-extrusion_width(), 0, 0])
            cube([2 * extrusion_width(), thickness + extrusion_width(), thickness + extrusion_width()]);
          translate([-extrusion_width()/2, extrusion_width()/2 - epsilon/2 + thickness, -extrusion_width()/2 + thickness/2])
            rotate ([0,90,90])
              rounded_rectangle([extrusion_width() + thickness, extrusion_width() + epsilon, extrusion_width()], 2);
          // vertical leg
          translate([-extrusion_width()/2,thickness/2, leg_length/2-extrusion_width()])
            rotate ([0,90,90])
              rounded_rectangle([leg_length, extrusion_width(), thickness], 2);
          }

          // fillets
          translate([extrusion_width(), -epsilon, thickness+extrusion_width()])
            rotate([-90,0,0])
              cylinder(r=extrusion_width(), h=leg_length);
          translate([-extrusion_width(), thickness+ extrusion_width(), -extrusion_width() - epsilon])
            cylinder(r=extrusion_width(), h=leg_length);
          translate([extrusion_width() + epsilon, thickness + extrusion_width(), thickness+extrusion_width()])
            rotate([-90,0,90])
              cylinder(r=extrusion_width(), h=leg_length);
          translate([extrusion_width() + epsilon, thickness + extrusion_width(), -extrusion_width()])
            rotate([-90,0,90])
              cylinder(r=extrusion_width(), h=leg_length);

        //screwholes removed from entire unioned object
        translate([extrusion_width()/2, extrusion_width()*1.5, thickness])
          linear_repeat(extent = [0, extrusion_width() * 2, 0], count = 3)
            clearance_hole_with_counterbore(nominal_d=3, h=thickness + epsilon);
        rotate ([-90, 0, 0])
          translate([-extrusion_width()/2, -2.5 * extrusion_width(), thickness])
            linear_repeat(extent = [0, extrusion_width() * 3, 0], count = 4)
              clearance_hole_with_counterbore(nominal_d=3, h=thickness + epsilon);
      }
}

demo() {
  z_bracket(extrusion_width());
}
