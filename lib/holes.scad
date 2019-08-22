// MIT license
epsilon = 0.01;

// Generates a hole from x/y plane down, with counterbore going up
// FIXME: this should use a polygon around the hole d, not inside of it
module hole_with_counterbore(d, h, counterbore_d) {
  translate([0, 0, -h]) cylinder(d=d, h=h+epsilon);
  cbore_d = counterbore_d == undef ? d * 2 : counterbore_d;
  cylinder(d=cbore_d, h=100);
}

module clearance_hole_with_counterbore(nominal_d, h, d) {
  assert(!(nominal_d == undef && d == undef), "Must pass d or nominal_d");
  assert(!(nominal_d != undef && d !=undef), "Can only pass d or nominal_d");

  if(nominal_d != undef)
    hole_with_counterbore(d=clearance_hole_size(nominal_d), h = h, counterbore_d = button_counterbore_hole_size(nominal_d));
   else
     hole_with_counterbore(d=d, h = h, counterbore_d = button_counterbore_hole_size(d));
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
