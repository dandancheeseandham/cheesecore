include <config.scad>

// FIXME: add holes to secure this thing
// FIXME: describe the origin of this part ... and decide if it's right.  There isn't an obvious "right" place for this one
module z_bracket() {
  leg_length = 60;
  thickness = 12;

  color(printed_part_color()) {
    translate([0, 0, 0]) cube([extrusion, leg_length, thickness]);
    translate([-extrusion, 0, -extrusion]) cube([extrusion, thickness, leg_length]);
  }
}

z_bracket();
