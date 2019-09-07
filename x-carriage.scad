include <config.scad>
use <demo.scad>
use <lib/mirror.scad>
use <nopscadlib/vitamins/rail.scad>

// The origin of the x-carriage is the center of the mounting point on the face of the linear rail carriage
module x_carriage()
{
  translate([50,0,0])
    rotate([0,-90,0])
        carriage_hole_positions(carriage_type) {
          cylinder(d=3.3,h=100);
          }
}

demo() {
x_carriage();
}