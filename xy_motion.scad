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
  belt_height = 13;  //height - do not change
  pulley_position_on_x_carriage = 208 ; //constant value until linked properly
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
gap_for_screws = 15;   //moves motor left and right
movefortension = 0;  //temp adjustment, move to 0 for closest.
horizontal_placement = 11; //"right" for NEMA17s
//vertical_placement = 4 ; //nema motor plates ontop
vertical_placement = -6 ;  //nema motor plates underneath

//translate([frame_size().x / 2 - extrusion_width(), 0, frame_size().z / 2])
//translate([])
//NEMA(NEMAtypeXY());

translate([frame_size().x / 2 - extrusion_width(), 0, frame_size().z / 2 + vertical_placement]){
  mirror_y() {
    translate([side_panel_thickness() + extrusion_width() + NEMA_width(NEMAtypeXY())/2 + movefortension + gap_for_screws, motor_pulley_link() + horizontal_placement , 0])
      rotate([0, 0, 180]) NEMA(NEMAtypeXY());
    }
  }
}

demo(){
  xy_motion(position = [0, 0, 0]);
}
