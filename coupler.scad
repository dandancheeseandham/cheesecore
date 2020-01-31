// Simple and fully customizable stepper motor / threaded rod coupler.
// Variable names should be self-explanatory, the default values are meant for a NEMA17 motor and a M8 rod.
// Creative Commons - Public Domain Dedication
// Parametric Z-axis coupler (stepper and threaded rod coupling) by aspesilorenzo is licensed under the
// Creative Commons - Public Domain Dedication license.
// https://www.thingiverse.com/thing:1329750

use <demo.scad>

// Height of the coupler, half for the motor shaft and half for the rod
function coupler_height() = 30;
// External diameter of the coupler
coupler_external_diameter = 20;
// Diameter of the motor shaft
motor_shaft_diameter = 5;
// Diameter of the rod
threaded_rod_diameter = 7.9;
// Diameter of the screw thread
screw_diameter = 3.4;
screw_head_diameter = 7;
screwThreadLength = 10;
// Width across flats of the nut (wrench size)
nut_width = 5.7;
nut_thickness = 3;
// Gap between the two halves
halves_distance = 0.5;
// Portion of the shaft inside the coupler
shaft_length = coupler_height()/2;
// Portion of the rod inside the coupler
rod_length = coupler_height()/2;
shaft_screws_distance = motor_shaft_diameter+screw_diameter+1;
rod_screws_distance = threaded_rod_diameter+screw_diameter+1;

just_a_little_number = 0.01; // just a little number
just_a_big_number = 100; // just a big number

module coupler() {
  color(alum_commercial_part_color()) {
    difference() {
      // main body
      cylinder(d=coupler_external_diameter, h=shaft_length + rod_length);
      // shaft
      translate([0,0,-just_a_little_number])
        cylinder(d=motor_shaft_diameter, h=shaft_length+2*just_a_little_number);
      // rod
      translate([0,0,shaft_length])
        cylinder(d=threaded_rod_diameter, h=rod_length+just_a_little_number);
      // screws
      translate([0,shaft_screws_distance/2,shaft_length/2])
        rotate([90,0,90])
          screw();
      translate([0,-shaft_screws_distance/2,shaft_length/2])
        rotate([90,0,270])
          screw();
      translate([0,rod_screws_distance/2,shaft_length+rod_length/2])
        rotate([90,0,90])
          screw();
      translate([0,-rod_screws_distance/2,shaft_length+rod_length/2])
        rotate([90,0,270])
          screw();
      // cut between the two halves
      cube([halves_distance,just_a_big_number,just_a_big_number], center=true);
    }
  }
}

module screw() {
  // thread
  cylinder(d=screw_diameter, h=just_a_big_number, center=true);
  // head
  translate([0,0,(screwThreadLength-nut_thickness)/2])
    cylinder(d=screw_head_diameter, h=just_a_big_number);
  // nut
  translate([0,0,-(screwThreadLength-nut_thickness)/2])
    rotate([180,0,30])
      cylinder(d=nut_width*2*tan(30), h=just_a_big_number, $fn=6);
}

demo() {
  coupler();
}
