// vim: set nospell:
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
use <lib/mirror.scad>
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
use <top_enclosure.scad>

$fullrender=false;

module enclosure() {
  frame();
  all_side_panels();
  hinges();
  %doors();
  feet(height=50);
 }


module printer() {

Yrail_vector = [-rail_lengths().x/2 + position.x, 0, frame_size().z / 2 - extrusion_width() / 2]; // Since a lot of things are tied to the Y-rail, I thought it might be worth investigating a base vector to simplify the code.

  // Y-RAIL
  // FIXME: x position here is an approximation to look decent
  translate (Yrail_vector + [3 , 0, 0])
    rotate([270, 0, 90])
      rail_wrapper(rail_profiles().y, rail_lengths().y, position = position.y-150);

  // HOTEND
  translate(Yrail_vector + [-35, position.y-150, 5]) // FIXME: arbitary move to look decentish
    rotate([0,0,180]) hot_end(E3Dv6, naked=true);

  // X-CARRIAGE
  // 12 = rail size
  xcarriagevector = [-rail_lengths().x/2 + position.x, frame_size().y / 2 - extrusion_width() , frame_size().z / 2 - extrusion_width() / 2];
  mirror_y() translate (xcarriagevector + [13,-12,0]) x_carriage();


  translate ([0, 0, frame_size().z / 2 + 150]) top_enclosure_all();

}

//FIXME: x=80 is around X0, y=-20 is around Y0, z=-50 is around Z0
//printer(render_electronics=false, position=[130, -20+100, -50]);


// x/y motion stage.  So belts, pulleys, x/y motors, and mounts.
// Position is the printhead position
module xy_motion(position = [0, 0]) {
  // FIXME: this is not a final height for belts
  translate ([0, 0, frame_size().z / 2 + 20]) corexy_belts([position.x-210, position.y]);

  // IDLER MOUNTS
  translate ([-frame_size().x / 2 + extrusion_width(), 0, frame_size().z / 2]) {
    mirror_y() {
      translate([0, -frame_size().y / 2 + extrusion_width(), 0])
        aluminium_idler_mount();
    }
  }

  // MOTOR MOUNTS
  translate([frame_size().x / 2 - extrusion_width(), 0, frame_size().z / 2]){
    mirror_y() {
      translate([0, frame_size().y / 2 - extrusion_width(), 0]) aluminium_motor_mount();
      translate([49, 38 - frame_size().y / 2 - extrusion_width(), 0])  NEMA(NEMA17);
    }
  }
}

module rc300zl(position = [0, 0, 0]) {
  $front_window_size = front_window_zl;
  $extrusion_type = extrusion15;
  $frame_size = frame_rc300zl;
  $rail_specs = rails_rc300zl;
  $leadscrew_specs = leadscrew_rc300zl ;
  $bed = bed_rc300;
  $elecbox = elec_ZL ; //electronics box size and placements
  $branding_name = "Original ZL";
  $enclosure_size = enclosure_rc300zl;
  validate();
  enclosure();
  xy_motion(position);
  z_towers(z_position = position[2]);
  bed(offset_bed_from_frame(position));
  x_rails(position.x);
  electronics_box_contents();
  electronics_box ();
  //printer();
  top_enclosure_all();
}

module rc300zlt(position = [0, 0, 0]) {
  $front_window_size = front_window_zlt;
  $extrusion_type = extrusion15;
  $frame_size = frame_rc300zlt;
  $rail_specs = rails_rc300zlt;
  $leadscrew_specs = leadscrew_rc300zlt ;
  $bed = bed_rc300;
  $elecbox = elec_ZLT ; //electronics box size and placements
  $branding_name = "Original ZLT";
  $enclosure_size = enclosure_rc300zl;
  validate();
  enclosure();
  xy_motion(position);
  z_towers(z_position = position[2]);
  bed(offset_bed_from_frame(position));
  x_rails(position.x);
  electronics_box_contents();
  electronics_box();
  top_enclosure_all();
  //printer();
}

module rc300zl40(position = [0, 0, 0]) {
  $front_window_size = front_window_zl;
  $extrusion_type = extrusion40;
  $frame_size = frame_rc300zl4040;
  $rail_specs = rails_rc300zl;
  $leadscrew_specs = leadscrew_rc300zl ;
  $bed = bed_rc300;
  $elecbox = elec_ZL ; //electronics box size and placements
  $branding_name = "4040 ZL";
  $enclosure_size = enclosure_rc300zl;
  validate();
  enclosure();
  xy_motion(position);
  z_towers(z_position = position[2]);
  bed(offset_bed_from_frame(position));
  x_rails(position.x);
  electronics_box_contents();
  electronics_box();
  top_enclosure_all();
  //printer();
}

module dancore(position = [0, 0, 0]) {
  $front_window_size = front_window_zl;
  $extrusion_type = extrusion20;
  $frame_size = [510, 475, 465];
  $rail_specs = [[420, MGN12], [420, MGN12], [420, MGN12]];
  $leadscrew_specs = ["LEADSCREW_SPECS", 450, 10];
  $bed = bed_rc300;
  $elecbox = elec_new_ZL ; //electronics box size and placements
  $branding_name = "CHEESECore ZL";
  $enclosure_size = enclosure_rc300zl;
  validate();
  enclosure();
  xy_motion(position);
  z_towers(z_position = position[2]);
  bed(offset_bed_from_frame(position));
  x_rails(position.x);
  electronics_box_contents();
  electronics_box ();
  top_enclosure_all();
  //printer();
}



$leadscrew_specs = leadscrew_rc300zl;
$bed = bed_rc300;
$front_window_size = front_window_zl;
$frame_size = frame_rc300zl;
$rail_specs = rails_rc300zl;

*printer(render_electronics=true, position=[150, 50, 0]);


rc300zl(position = [150, 150, 130]);
translate([800, 0, 0]) rc300zlt(position = [150, 150, 130]);
translate([0, 800, 0]) dancore(position = [150, 150, 130]);
translate([800, 800, 0]) rc300zl40();
