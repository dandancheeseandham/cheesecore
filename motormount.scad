
// vim: set nospell:
//include <config.scad>
//include <opencoreparts.scad>
include <core.scad>
include <screwholes.scad>

depth=6;  // depth of aluminium part in mm

difference () {
//main block
//FIXME: add rounded corner to the join
union() {
translate ([78/2,-47/2,0]) rounded_rectangle([78,47,depth], 3);
translate ([78,-39.5,0])  rounded_rectangle([30,15,depth], 3);
}


translate ([70.5,-41.8,0]) screwholes(row_distance=37,numberofscrewholes=6,Mscrew=3,screwhole_increase=0.1) ; //line of screwholes
translate ([23,-24,0])  motorhole(0,0,0);  //
translate ([85.5,-43.3,2]) rotate ([0,0,90]) longscrewhole(screwhole_length=8,Mscrew=3,screwhole_increase=0.15);
}
 
module motorhole(x,y,z) {
  NEMAhole=24;
  motoradjust=6;
 union() {
 longscrewhole(screwhole_length=10,Mscrew=NEMAhole,screwhole_increase=0.6);
 translate ([-13,-15.39,-2])  longscrewhole(screwhole_length=motoradjust, Mscrew=3,screwhole_increase=0.1);
 translate ([-13,+15.39,-2])  longscrewhole(screwhole_length=motoradjust, Mscrew=3,screwhole_increase=0.1);
  translate ([+18,-15.39,-2])  longscrewhole(screwhole_length=motoradjust, Mscrew=3,screwhole_increase=0.1);
  translate ([+18,+15.39,-2])  longscrewhole(screwhole_length=motoradjust, Mscrew=3,screwhole_increase=0.1);
  }
}