include <config.scad>
use <lib/mirror.scad>
use <screwholes.scad>
use <demo.scad>
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
include <nopscadlib/vitamins/stepper_motors.scad>

bearing_radius = 11 + 0.1 ;  //  0.1 for hole shrinkage use polyholes
counter_bore_radius = 3.5 ;
leadscrew = 8 ;  //use polyhole
leg_height = 35 ;
block_height = 45 ;
block_xy = 39 ;  // 39 is the existing blocks, but the counterbores break the outside wall.

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
           * translate([0, 0, -5-epsilon]) rounded_rectangle([block_xy + epsilon ,23,leg_height], 0);
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
      translate([ NEMA_hole_pitch(NEMA17)/2, NEMA_hole_pitch(NEMA17)/2, -500 ])
        // FIXME: this diameter should be driven by stepper size. (Looked in modules, there is no definition for this.-dan)
        // FIXME this needs to be a hole() not a cylinder
        cylinder(d=3.3, h=1000);
        //counter-hore

     translate([ NEMA_hole_pitch(NEMA17)/2, NEMA_hole_pitch(NEMA17)/2, 20 ])
        cylinder(r=counter_bore_radius, h=20 + 2 * epsilon);
    }
}

demo() {
bearing_block();
*translate ([50,0,0]) bearing_block_v2();
translate ([100,0,0]) bearing_block_v3();
}
