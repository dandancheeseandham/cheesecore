// MIT license
epsilon = 0.01;

// Generates a hole from x/y plane down, with counterbore going up
// FIXME: this should use a polygon around the hole d, not inside of it
module hole_with_counterbore(d, h, counterbore_d) {
  translate([0, 0, -h]) cylinder(d=d, h=h+epsilon);
  cbore_d = counterbore_d == undef ? d * 2 : counterbore_d;
  cylinder(d=cbore_d, h=100);
}

module hole_d(d, h) {
  translate([0,0, -h/2]) cylinder(d=d, h=h+epsilon);
}

module hole(d, h) {
  translate([0,0, -h]) cylinder(d=d, h=h+epsilon);
}

module tapping_hole(nominal_d,h = 50){
    hole_d(d=tapping_hole_size(nominal_d), h=h);
}


module clearance_hole(nominal_d, h, fit = "normal") {

if (fit == "normal") {
  hole(d=clearance_hole_size(nominal_d), h=h);
}

if (fit == "close") {
 hole(d=clearance_hole_size_close(nominal_d), h=h);
}
if (fit == "loose") {
hole(d=clearance_hole_size_loose(nominal_d), h=h);
}


  //base_stepper_motors = 3.5 fit = loose
  //panel screw holes = 3.5 fit = loose
  //halo or button screw clearance in al = 3.2 fit = close
}


module clearance_hole_2d(nominal_d, fit = "normal") {
circle (d=clearance_hole_size(nominal_d));
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
  [7, 7.6],
  [8, 9],
  [10, 11]
]);

function clearance_hole_size_close(nominal_d) = lookup(nominal_d, [
  // This table https://amesweb.info/Screws/Metric-Clearance-Hole-Chart.aspx
  [1.6, 1.7],
  [2, 2.2],
  [2.5, 2.7],
  [3, 3.2],
  [4, 4.3],
  [5, 5.3],
  [6, 6.4],
  [8, 8.4],
  [10, 10.5]
]);

function clearance_hole_size_loose(nominal_d) = lookup(nominal_d, [
  // This table https://amesweb.info/Screws/Metric-Clearance-Hole-Chart.aspx
  [1.6, 2],
  [2, 2.6],
  [2.5, 3.1],
  [3, 3.6],
  [4, 4.8],
  [5, 5.8],
  [6, 7],
  [8, 10],
  [10, 12]
]);


function tapping_hole_size(nominal_d) = lookup(nominal_d, [
  // This table https://amesweb.info/Screws/Metric-Clearance-Hole-Chart.aspx
  [1.6, 1.5],
  [2, 1.6],
  [2.5, 2],
  [3, 2.5],
  [4, 3.3],
  [5, 4.2],
  [6, 5],
  [8, 6.8],
  [10, 8.5]
]);



function button_counterbore_hole_size(nominal_d) = lookup(nominal_d, [
  // Based on diameter of button head screw
  // If there is a better reference for this we should redo it
  //[3, 5.7*1.1],
  [3, 8],
]);
