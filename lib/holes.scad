// MIT license
epsilon = 0.01;

// Generates a hole from x/y plane down, with counterbore going up
// FIXME: this should use a polygon around the hole d, not inside of it
module hole_with_counterbore(d, h) {
  translate([0, 0, -h]) cylinder(d=d, h=h+epsilon);
  cylinder(d=d*2, h=100);
}

module clearance_hole_with_counterbore(nominal_d, h) {
  hole_with_counterbore(d=nominal_d * 1.1, h = h);
}
