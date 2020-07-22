// vim: set nospell:
include <config.scad>
use <lib/layout.scad>
use <screwholes.scad>
use <demo.scad>
use <lib/holes.scad>
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
include <nopscadlib/vitamins/stepper_motors.scad>

bearing_radius = 11 + 0.1;  //  0.1 for hole shrinkage use polyholes FIXME: this should not need a fudge factor, should probably be a diameter
counter_bore_d = 7;
leadscrew = 8;  //use polyhole
leg_height = 35;
// add ability to an extra 5mm for sourcingmap 5mmx8mm Clamp Tight Motor Shaft 2 Diaphragm Coupling Coupler
block_height = 45;
block_xy = 39;  // 39 is the existing blocks.  This could probably be 40 and still assemble just fine, assuming panels are cut correctly

module bearing_block()
{
translate([0,0,block_height/2+epsilon])
  color(printed_part_color())
difference(){
    union(){
        difference() {
            translate([0, 0, 0])
            rounded_rectangle([block_xy ,block_xy,block_height], 5.5);  // MAIN BLOCK

            //remove bottom parts between legs
            translate([0, 0, -5-epsilon]) rounded_rectangle([23,block_xy + epsilon,leg_height+epsilon], 0);
            translate([0, 0, -5-epsilon]) rounded_rectangle([block_xy + epsilon ,23,leg_height], 0);
            //remove part of legs that need rounding
            translate([0, 0, -5-epsilon]) rounded_rectangle([28,28,leg_height+epsilon], 0);
            translate([0, 0, -5-epsilon]) rounded_rectangle([28,28,leg_height+epsilon], 0);
        }
      //add the rounding of legs
      mirror_xy() translate ([14,14,-5]) cylinder(h=35,d=5,center=true);
    }
     //motor holes
    translate([0, 0, -500]) cylinder(h=1000, d = leadscrew);  //lead screw size

    translate([0, 0, (block_height/2)-7]) cylinder(h=14, r=bearing_radius, center=false);  // bearing

    motor_holes();
  }
}

module bearing_block_v2()
{
  translate([0,0,block_height/2])
  color(printed_part_color())
difference(){
    union(){
        difference() {
            translate([0, 0, 0])
            rounded_rectangle([block_xy ,block_xy,block_height], 5.5);  // MAIN BLOCK

            //remove bottom parts between legs
            *translate([0, 0, -5-epsilon]) rounded_rectangle([23,block_xy + epsilon,leg_height+epsilon], 0);
           * translate([0, 0, -5-epsilon]) rounded_rectangle([block_xy + epsilon ,23,leg_height], 0);
            translate([0, 0, -5-epsilon]) rounded_rectangle([34 ,23,leg_height], 0);
            translate([0, 0, -5-epsilon]) rounded_rectangle([23,34,leg_height], 0);

            //window
            translate([0, -10, -2.5-epsilon]) rounded_rectangle([23,34,leg_height-5], 0);
           translate([-10, 0, -2.5-epsilon]) rounded_rectangle([34,23,leg_height-5], 0);


            //remove part of legs that need rounding
            translate([0, 0, -5-epsilon]) rounded_rectangle([28,28,leg_height+epsilon], 0);
        }
      //add the rounding of legs
      mirror_xy() translate ([14,14,-5]) cylinder(h=35,d=5,center=true);
    }
     //motor holes
    translate([0, 0, -500]) cylinder(h=1000, d = leadscrew);  //lead screw size

     translate([0, 0, (block_height/2)-7]) cylinder(h=14, r=bearing_radius, center=false);  // bearing

    motor_holes();
  }
}


module bearing_block_v3()
{
  translate([0,0,block_height/2+epsilon])
  color(printed_part_color())
difference(){
    union(){
        difference() {
            translate([0, 0, 0])
            rounded_rectangle([block_xy ,block_xy,block_height], 5.5);  // MAIN BLOCK

            //remove bottom parts between legs
            *translate([0, 0, -5-epsilon]) rounded_rectangle([23,block_xy + epsilon,leg_height+epsilon], 0);
            *translate([0, 0, -5-epsilon]) rounded_rectangle([block_xy + epsilon ,23,leg_height], 0);
            translate([0, 0, -5-epsilon]) rounded_rectangle([34 ,23,leg_height-10], 0);
            translate([0, 0, -5-epsilon]) rounded_rectangle([23,34,leg_height-10], 0);

            //window
            translate([0, 0, -2.5-epsilon]) rounded_rectangle([23,44,leg_height-5], 0);
            translate([0, 0, -2.5-epsilon]) rounded_rectangle([44,23,leg_height-5], 0);

            //remove part of legs that need rounding
            translate([0, 0,-2.5-epsilon]) rounded_rectangle([28,28,leg_height+epsilon-5], 0);
        }
      //add the rounding of legs
      mirror_xy() translate ([14,14,-5]) cylinder(h=35,d=5,center=true);
    }
     //motor holes
    translate([0, 0, -500]) cylinder(h=1000, d = leadscrew);  //lead screw size
    translate([0, 0, (block_height/2)-7]) cylinder(h=14, r=bearing_radius, center=false);  // bearing
    motor_holes();
  }
}

module motor_holes()
{
  translate([0, 0, -(block_height/2)-7]) cylinder(h=20, d=NEMA_boss_radius(NEMA17) * 2 + 1); // motor hole
    mirror_xy() {
      translate([ NEMA_hole_pitch(NEMA17)/2, NEMA_hole_pitch(NEMA17)/2, 20 ]) {
        // through-hole
        translate([0,0, 10]) clearance_hole(nominal_d = 3, h=100);
        // rather than a true counterbore, carve out the whole corner
        linear_extrude(10) {
          hull() {
            circle(d=counter_bore_d);
            translate([0, counter_bore_d]) square(counter_bore_d, center = true);
            translate([counter_bore_d, 0]) square(counter_bore_d, center = true);
          }
        }
      }
   }
}

demo() {
  bearing_block();
  translate ([50,0,0]) bearing_block_v2();
  translate ([100,0,0]) bearing_block_v3();
}
