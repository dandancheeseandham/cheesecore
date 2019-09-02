// vim: set nospell:
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
use <extrusion.scad>
use <belts_pulleys.scad>
use <side_panels.scad>
use <frame.scad>
include <config.scad>
use <foot.scad>
use <bed.scad>
use <z-tower.scad>
use <rail.scad>
use <aluminium_idlermount.scad>
use <aluminium_motormount.scad>
use <electronics_box_panels.scad>
use <electronics_box_contents.scad>
use <x-carriage.scad>
use <validation.scad>

$fullrender=false;

module enclosure(){
  frame();
  all_side_panels();
  hinges();
  translate([0, -frame_size().y / 2 - panel_thickness() - epsilon, 0]) doors();
  feet(height=50);
}

module printer(render_electronics=false, position=[0, 0, 0]) {

  enclosure();

  z_towers(model[3].z, z_position = position[2]);
  // FIXME: this is not a final height for belts
  translate ([0, 0, frame_size().z / 2 + 20]) corexy_belts([position.x-210, position.y]);

  // bed
  // FIXME: This placement of the bed is arbitrary in z, but linked to
  // "position = rail_length.z/2-50-z_position;" in z-tower
  translate ([bed_offset.x, bed_offset.y, frame_size().z / 2 - position.z - 100]) bed();

  Yrail_vector = [-rail_length.x/2 + position.x, 0, frame_size().z / 2 - extrusion_width() / 2]; // Since a lot of things are tied to the Y-rail, I thought it might be worth investigating a base vector to simplify the code.

  //X-rail
  translate ([0, 0, frame_size().z / 2 - extrusion_width() / 2])
    x_rails(model[3].x, position.x);

  // Y-rail
  // FIXME: x position here is an approximation to look decent
  translate (Yrail_vector + [3 , 0, 0])
    rotate([270, 0, 90])
    rail_wrapper(model[3].y,rail_length.y, position = position.y-150);

  //hotend
  translate (Yrail_vector + [-35, position.y-150, 20]) // FIXME: arbitary move to look decentish
    rotate ([0,0,180]) hot_end(E3Dv6, naked=true);

  // x-carriage
  // 12 = rail size
  xcarriagevector = [-rail_length.x/2 + position.x, frame_size().y / 2 - extrusion_width() , frame_size().z / 2 - extrusion_width() / 2];
  mirror_y() translate (xcarriagevector + [10,-12,0]) x_carriage();


  // Idler mounts
  translate ([-frame_size().x / 2 + extrusion_width(), 0, frame_size().z / 2]) {
    mirror_y() {
      translate([0, -frame_size().y / 2 + extrusion_width(), 0])
        aluminium_idler_mount();

    }
  }

  // motor mounts
  translate([frame_size().x / 2 - extrusion_width(), 0, frame_size().z / 2]){
    mirror_y() {
      translate([0, frame_size().y / 2 - extrusion_width(), 0]) aluminium_motor_mount();
      translate([49, 8 - frame_size().y / 2 - extrusion_width(), 0])  NEMA(NEMA17);
    }
  }

  //electronics box
  %translate([frame_size().x / 2 + panel_thickness(), 0, 0]  ) rotate ([0,0,90]) electronics_box (box_size_y = 298.9, box_size_z = 238.9, box_depth = 59, acrylic_thickness = 6); // Old ZL size




  if(render_electronics)
  {
    // FIXME - should not need to translate here just by panel_thickness()
    translate([frame_size().x / 2 + panel_thickness(), 0, 0]  )
      electronics_box_contents();
  }
}

//FIXME: x=80 is around X0, y=-20 is around Y0, z=-50 is around Z0
//printer(render_electronics=false, position=[130, -20+100, -50]);

module rc300zl(position = [0, 0, 0]) {
  $extrusion_type = extrusion15;
  // TODO: perhaps extract out wrappers for "common" parts like frame_and_sides or something?
  validate();
  enclosure();
  //printer();
}

module rc300zlt(position = [0, 0, 0]) {
  $front_window_size = front_window_zlt;
  $extrusion_type = extrusion15;
  // TODO: perhaps extract out wrappers for "common" parts like frame_and_sides or something?
  validate();
  enclosure();
  //printer();
}
module rc300zl40(position = [0, 0, 0]) {
  $extrusion_type = extrusion40;
  validate();
  enclosure();
  //printer();
}
$front_window_size = front_window_zl;
printer(render_electronics=true, position=[50, 50, 0],$extrusion_type = extrusion15);
translate([600, 0, 0]) rc300zl();
*translate([1250, 0, 0]) rc300zlt();
translate([1900, 0, 0]) rc300zl40();
