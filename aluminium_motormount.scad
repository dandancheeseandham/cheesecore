// Initially based on Motor-mount-V2-rear-V1-SW-SIMPLE.DXF
//changed number of screwholes from 6 to 5 and made extrusion adjust a big bigger

// vim: set nospell:
include <config.scad>
include <nopscadlib/core.scad>
include <screwholes.scad>

// FIXME: rather than parameterize on screwsize, we could parameterize on NEMA size of motor - that would set all of
// a screw size, main motor hole size, and screw pattern from one variable
module raw_aluminium_motor_mount(screwsize,motoradjustspacing) {
  part_thickness =6;  // part_thickness  of aluminium part in mm
  part_corner_rounding = 3;
  NEMAhole=24; // size of hole required for NEMA17 motor

  color("#777") {
  difference () {
  //main block
  //FIXME: add rounded corner to the join
  mainx = 78 ;
  mainy = 47 ;
  addonx = extrusion+15 ;
  addony = 12 ;


  union() {
  translate ([mainx/2,-mainy/2,0]) rounded_rectangle([mainx,mainy,part_thickness ], part_corner_rounding);
  translate ([mainx,-mainy+addony/2+screwsize,0])  rounded_rectangle([addonx,addony+screwsize*2,part_thickness ], part_corner_rounding);
  }


  translate ([mainx-(extrusion/2),-41.8,0]) screwholes(row_distance=37,numberofscrewholes=5,Mscrew=screwsize,screwhole_increase=0.1) ; //line of screwholes
  translate ([23,-24,0])  motorhole(0,0,0);  //motor holes
  translate ([mainx+(extrusion/2),-43.3+(screwsize/2),2]) rotate ([0,0,90]) longscrewhole(screwhole_length=8,Mscrew=screwsize,screwhole_increase=0.15); //extrusion adjust
  }
}

module motorhole(x,y,z) {
 union() {
  posx= 13 ;
  posy= 15.39 ;
  NEMAadjust = 10 ;
  NEMAscrew = 3 ;
  longscrewhole(screwhole_length=NEMAadjust,Mscrew=NEMAhole,screwhole_increase=0.6);
  translate ([-posx,-posy,-2])  longscrewhole(screwhole_length=motoradjustspacing, Mscrew=NEMAscrew,screwhole_increase=0.1);
  translate ([-posx,+posy,-2])  longscrewhole(screwhole_length=motoradjustspacing, Mscrew=NEMAscrew,screwhole_increase=0.1);
  translate ([posx+(NEMAadjust/2),-posy,-2])  longscrewhole(screwhole_length=motoradjustspacing, Mscrew=NEMAscrew,screwhole_increase=0.1);
  translate ([posx+(NEMAadjust/2),+posy,-2])  longscrewhole(screwhole_length=motoradjustspacing, Mscrew=NEMAscrew,screwhole_increase=0.1);
    }
  }
}
// wraps raw_aluminium_motor_mount() and rotates part to convenient orientation and placement for placing on model
module aluminium_motor_mount(screwsize=3, motoradjustspacing=6) {
  translate([48+30, -47+extrusion, 6/2])
    rotate([0,0,180])
      raw_aluminium_motor_mount(screwsize=screwsize, motoradjustspacing=motoradjustspacing);
}

* mirror([0,1,0]) translate ([0,-10,0]) z_yoke(screwsize=3,motoradjustspacing=6) ; //mirrored version
aluminium_motor_mount(screwsize=3,motoradjustspacing=6) ;
