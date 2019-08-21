include <config.scad>
include <screwholes.scad>

// FIXME: add holes to secure this thing
// FIXME: describe the origin of this part ... and decide if it's right.  There isn't an obvious "right" place for this one
module z_bracket() {
 // extrusion=15; for testing the module on it's own
 z_bracket_screwsize = 3;
  leg_length = 10+extrusion*4;
  thickness = extrusion-0.05;


  translate ([0,-extrusion,0]) union()  //FIXME: not sure how I screwed the origin while developing, I'll incorporate into calculations below
  
  {
  color(printed_part_color()) {
  difference() {
  //translate([0, 0, 0]) cube([extrusion, leg_length, thickness]);  //cube version
  translate([extrusion/2,leg_length/2, thickness/2]) rounded_rectangle([extrusion, leg_length, thickness], 2);
  translate([extrusion/2, extrusion/2, 0])  screwholes(row_distance=extrusion*2.75,numberofscrewholes=4,Mscrew=z_bracket_screwsize,screwhole_increase=0.5);
  }
 # difference() {
 //translate([-extrusion, 0, -extrusion]) cube([extrusion, thickness, leg_length]);  //cube version
 //  translate([-extrusion, 0, -leg_length/2+extrusion]) rounded_rectangle([extrusion, thickness, leg_length],2);
  translate([-extrusion/2,extrusion*1.5, leg_length/2-extrusion]) rotate ([0,90,90])  rounded_rectangle([leg_length, extrusion, thickness], 2);
 # rotate ([90,0,0]) translate([-extrusion/2, extrusion, -extrusion*1.5])   screwholes(row_distance=extrusion*2,numberofscrewholes=3,Mscrew=z_bracket_screwsize,screwhole_increase=0.5);
  }
  }
  }
}

z_bracket();

