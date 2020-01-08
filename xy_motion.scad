// vim: set nospell:
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
use <lib/layout.scad>
use <corexy_belts.scad>
use <nopscadlib/vitamins/pulleys.scad>
include <config.scad>
use <demo.scad>

module xy_motion(position = [0, 0, 0]) {
  // FIXME: this is not a final height for belts
  belt_height = 13;
  pulley_position_on_x_carriage = 208 ;
  translate ([0, 0, frame_size().z / 2 + belt_height])
    corexy_belts([position.x-  pulley_position_on_x_carriage, position.y]);

/* PENDING REMOVAL
// IDLER MOUNTS
  *translate ([-frame_size().x / 2 + extrusion_width(), 0, frame_size().z / 2]) {
    mirror_y() {
      translate([0, -frame_size().y / 2 + extrusion_width(), 0])
        aluminium_idler_mount();

    }
  }
  */
// MOTORS AND MOTOR MOUNTS
gap_for_screws = 6;
movefortension = 0;  //increase to move NEMA motor out for adjustments
horizontal_placement = 11 ;
 translate([frame_size().x / 2 - extrusion_width(), 0, frame_size().z / 2]){
  mirror_y() {
    translate([panel_thickness() + extrusion_width() + NEMA_width(NEMAtypeXY())/2 + movefortension + gap_for_screws, motor_pulley_link() + horizontal_placement , 0])
      rotate([0, 0, 180]) NEMA(NEMAtypeXY());
    }
  }
}

demo(){
  xy_motion(position = [0, 0, 0]);
}
