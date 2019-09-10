include <config.scad>
use <screwholes.scad>
use <demo.scad>

// FIXME: describe the origin of this part ... and decide if it's right.  There isn't an obvious "right" place for this one
module z_bracket(extrusion_type)
{

  z_bracket_screwsize = extrusion_screw_size() /2 + 0.25;
  leg_length = extrusion_width()*4;
  thickness = extrusion_width()-5;
  corner_radius = 2;

  color(printed_part_color())
    difference()
    {
      union()
      {
        // horizontal leg
        hull() {
          cube([extrusion_width(), 1, thickness]);
          translate([corner_radius, leg_length - corner_radius, 0]) cylinder(r=corner_radius, h=thickness);
          translate([extrusion_width() - corner_radius, leg_length - corner_radius, 0]) cylinder(r=corner_radius, h=thickness);
        }
        // material for fillets
        cube([extrusion_width(), thickness+extrusion_width(), thickness + extrusion_width()]);
        translate([-extrusion_width(), 0, 0]) cube([2 * extrusion_width(), thickness + extrusion_width(), thickness + extrusion_width()]);

        // vertical leg
        translate([-extrusion_width()/2,thickness/2, leg_length/2-extrusion_width()]) rotate ([0,90,90])  rounded_rectangle([leg_length, extrusion_width(), thickness], 2);
        translate([-extrusion_width()/2,thickness/2 + thickness, -extrusion_width()/2 + 5]) rotate ([0,90,90])  rounded_rectangle([extrusion_width() + 10, extrusion_width(), extrusion_width()], 2);
      }

      // fillets
      translate([extrusion_width(), -epsilon, thickness+extrusion_width()]) rotate([-90,0,0]) cylinder(r=extrusion_width(), h=leg_length);
      translate([-extrusion_width(), thickness+ extrusion_width(), -extrusion_width() - epsilon]) cylinder(r=extrusion_width(), h=leg_length);
      translate([extrusion_width() + epsilon, thickness + extrusion_width(), thickness+extrusion_width()]) rotate([-90,0,90]) cylinder(r=extrusion_width(), h=leg_length);
      translate([extrusion_width() + epsilon, thickness + extrusion_width(), -extrusion_width()]) rotate([-90,0,90]) cylinder(r=extrusion_width(), h=leg_length);

      //screwholes removed from entire unioned object
      // FIXME: at some point we lost the counterbores on these screws
      translate([extrusion_width()/2, extrusion_width()*1.75-z_bracket_screwsize, 0])  screwholes(row_distance=extrusion_width()*2,numberofscrewholes=3,Mscrew=z_bracket_screwsize,screwhole_increase=0.5);
      rotate ([90,0,0]) translate([-extrusion_width()/2, -extrusion_width()/2, -extrusion_width()*0.5])   screwholes(row_distance=extrusion_width()*3,numberofscrewholes=4,Mscrew=z_bracket_screwsize,screwhole_increase=0.5);
    }
}

demo() {
  z_bracket(extrusion_width($extrusion_type));
}
