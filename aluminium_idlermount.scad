// Initially based onSimple-idler-FRONT-R1.DXF

// vim: set nospell:
include <config.scad>
//include <core.scad>
include <lib.scad>
include <screwholes.scad>
* translate ([0,0,-4])  projection (cut=true) rotate ([0,180,0]) mirror ([0,1,0]) linear_extrude(height = 6.35, center = true, convexity = 10) import (file = "railcorestls/Simple-idler-FRONT-R1.DXF", convexity=1);

// Origin is at the inside corner where the extrusions meet under the mount
module aluminium_idler_mount() {
  mainx = 48.52 ;
  mainy = 49.2 ;
  posx= 71 ;
  posy= 9.5 ;
  motoradjustspacing = 4 ;
  screwsize= 3 ;
  NEMAscrew = 3 ;
  // FIXME: this sets a nice x/y for placement, but would probably be better if we modeled it in that position from the start
  translate([-mainx - extrusion/2 + 1, -extrusion+1, 0])
  color("#777") render() // call render here to get artifacts out of larger model
    difference () {
      translate ([80/2, 57/2, 6/2])  rounded_rectangle ([80-3, 57-3, 6], r=3);
      translate ([(80-24/2),(57-42/2),-epsilon]) rounded_rectangle ([24+3/2,42+3/2,6*3],3);
      translate ([7,18,-6]) cylinder(h=15, r1=3/2, r2=3/2, center=false);
      translate ([23.6,33,-6]) cylinder(h=15, r1=3/2, r2=3/2, center=false);
      translate ([-25,0,-6])  rotate ([0,0,45])  cube ([100,30,20]);
      translate ([posx,posy-motoradjustspacing,-2])  rotate ([0,0,90]) longscrewhole(screwhole_length=motoradjustspacing, Mscrew=NEMAscrew,screwhole_increase=0.1);
      translate ([mainx,mainy-30,0]) screwholes(row_distance=30,numberofscrewholes=3,Mscrew=screwsize,screwhole_increase=0.1) ; //line of screwholes
    }
}

aluminium_idler_mount();
