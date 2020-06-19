// MIT license
epsilon = 0.01;

// Generates a hole from x/y plane down, with counterbore going up
// FIXME: this should use a polygon around the hole d, not inside of it
module hole_with_counterbore(d, h, counterbore_d) {
  translate([0, 0, -h]) cylinder(d=d, h=h+epsilon);
  cbore_d = counterbore_d == undef ? d * 2 : counterbore_d;
  cylinder(d=cbore_d, h=100);
}

module hole(d, h) {
  translate([0,0, -h]) cylinder(d=d, h=h+epsilon);
}

module clearance_hole(nominal_d, h) {
  hole(d=clearance_hole_size(nominal_d), h=h);
}

module clearance_hole_with_counterbore(nominal_d, h, counterbore_d) {
  true_hole_size = clearance_hole_size(nominal_d);
  true_counterbore_d = is_undef(counterbore_d) ? button_counterbore_hole_size(true_hole_size) : counterbore_d;

  hole_with_counterbore(d=true_hole_size, h = h, counterbore_d = true_counterbore_d);
}

function clearance_hole_size(nominal_d) = lookup(nominal_d, [
  // This table "Medium Fit Series" from Machinery's Handbook
  [1.6, 1.8],
  [2, 2.4],
  [2.5, 2.9],
  [3, 3.4],
  [4, 4.5],
  [5, 5.5],
  [6, 6.6],
  [7, 7.6]
]);

function button_counterbore_hole_size(nominal_d) = lookup(nominal_d, [
  // Based on diameter of button head screw
  // If there is a better reference for this we should redo it
  [3, 5.7*1.1],
]);
