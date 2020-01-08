// vim: set nospell:
include <config.scad>
use <lib/layout.scad>
include <nopscadlib/vitamins/stepper_motor.scad>
include <nopscadlib/vitamins/stepper_motors.scad>


//  this really means "slot"
module longscrewhole(screwhole_length,Mscrew,screwhole_increase) {
  translate([0,0,-50]) linear_extrude(height = 100, twist = 0) {
    hull() {
          translate([screwhole_length,0,0])
                  circle((Mscrew/2)+screwhole_increase);
                        circle((Mscrew/2)+screwhole_increase);
    }
  }
}
module motor_holes(type = NEMA17) {
  translate([0, 0, -epsilon])
    cylinder(h=panel_thickness() + 2 * epsilon, d=NEMA_boss_radius(NEMA17) * 2 + 1);

  mirror_xy() {
    translate([NEMA_hole_pitch(type)/2, NEMA_hole_pitch(type)/2, -epsilon-30 ])
      // FIXME this needs to be a hole() not a cylinder
      //cylinder(d=3.3, h=panel_thickness() + 2 * epsilon);
      cylinder(d=3.3, h=60);
      *echo("hole pitch",NEMA_hole_pitch(type));
  }
}
