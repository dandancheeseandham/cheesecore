include <config.scad>
include <screwholes.scad>

// FIXME: add holes to secure this thing
// FIXME: describe the origin of this part ... and decide if it's right.  There isn't an obvious "right" place for this one
module z_bracket() {
  leg_length = 5+extrusion*4;
  thickness = extrusion-0.05;

  color(printed_part_color()) {
  difference() {
  //translate([0, 0, 0]) cube([extrusion, leg_length, thickness]);  //cube version
  translate([extrusion/2,leg_length/2, thickness/2]) rounded_rectangle([extrusion, leg_length, thickness], 2);
  translate([extrusion/2, extrusion/2, 0])  screwholes(row_distance=extrusion*2.75,numberofscrewholes=4,Mscrew=3,screwhole_increase=0.5);
  }
  difference() {
 //translate([-extrusion, 0, -extrusion]) cube([extrusion, thickness, leg_length]);  //cube version
 //  translate([-extrusion, 0, -leg_length/2+extrusion]) rounded_rectangle([extrusion, thickness, leg_length],2);
  translate([-extrusion/2,extrusion*1.5, leg_length/2-extrusion]) rotate ([0,90,0])  rounded_rectangle([leg_length, extrusion, thickness], 2);
  rotate ([90,0,0]) translate([-extrusion/2, extrusion/2, -extrusion])   screwholes(row_distance=extrusion*2,numberofscrewholes=3,Mscrew=3,screwhole_increase=0.5);
  }
  }
}

z_bracket();

