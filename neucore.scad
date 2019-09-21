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
use <top_enclosure_parts.scad>
use <top_enclosure_side_panels.scad>
use <top_enclosure_frame.scad>


$fullrender=false;



// x/y motion stage.  So belts, pulleys, x/y motors, and mounts.
// Position is the printhead position
module xy_motion(position = [0, 0, 0]) {
  // FIXME: this is not a final height for belts
  translate ([0, 0, frame_size().z / 2 + 10])
    corexy_belts([position.x-210, position.y]);
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
    translate([0, frame_size().y / 2 - extrusion_width(), 0])
      aluminium_motor_mount();
    translate([extrusion_width() + NEMA_width(NEMAtype())/2, motor_pulley_link() + extrusion_width()/2 + 3.5, 0])  //FIXME what is 3.5?

      NEMA(NEMAtype());
    }
  }

}

module y_carriage(position) {
  // messy bit!
  Yrail_vector = [-rail_lengths().x/2 + position.x, 0, frame_size().z / 2 - extrusion_width() / 2]; // Since a lot of things are tied to the Y-rail, I thought it might be worth investigating a base vector to simplify the code.

  // HOTEND
  *translate(Yrail_vector + [-35, position.y-150, 5]) // FIXME: arbitary move to look decentish
    rotate([0,0,180]) hot_end(E3Dv6, naked=true);

  // Y-RAIL
  // FIXME: x position here is an approximation to look decent
  translate (Yrail_vector + [3 , 0, 0])
    rotate([270, 0, 90])
      rail_wrapper(rail_profiles().y, rail_lengths().y, position = position.y-150);

  // X-CARRIAGE
  // 12 = rail size
  xcarriagevector = [-rail_lengths().x/2 + position.x, frame_size().y / 2 - extrusion_width() , frame_size().z / 2 - extrusion_width() / 2];
  *mirror_y()
    translate (xcarriagevector)
      x_carriage();
      //+ [13,-12,0]
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
  kinematics(position);
  electronics();
  top_enclosure();
}


module rc300zlv2(position = [0, 0, 0]) {
  $front_window_size = front_window_zl;
  $extrusion_type = extrusion15;
  $frame_size = frame_rc300zl;
  $rail_specs = rails_rc300zl;
  $leadscrew_specs = leadscrew_rc300zl ;
  $bed = bed_rc300;
  $elecbox = elec_new_ZL ; //electronics box size and placements
  $branding_name = "ZLv2";
  $enclosure_size = enclosure_rc300zl;
  validate();
  enclosure();
  *kinematics(position);
  electronics();
  *top_enclosure();
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
  kinematics(position);
  electronics();
  top_enclosure();
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
  kinematics(position);
  electronics();
  top_enclosure();
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
  kinematics(position);
  electronics();
  top_enclosure();
}

// CUSTOMCORE FOR DEBUGGING/QUICK RENDERING
module customcore(position = [0, 0, 0]) {
  $front_window_size = front_window_custom;
  $extrusion_type = extrusion30;
  $frame_size = frame_rc300_custom;
  $rail_specs = rails_custom;
  $leadscrew_specs = leadscrew_rc_custom;
  $bed = bed_rc300;
  $elecbox = elec_custom ; //electronics box size and placements
  $branding_name = "Custom";
  $enclosure_size = enclosure_custom;
  validate();
  frame();
  all_side_panels();
  *hinges();
  *doors();
  feet(height=50);
  kinematics(position);
  *electronics();
  top_enclosure();
}

module enclosure() {
  frame();
  all_side_panels();
  *hinges();
  * doors();
  feet(height=50);
 }

module electronics() {
  electronics_box_contents();
  electronics_box ();
}

//FIXME: position isn't quite right
module kinematics(position) {
  // the tidy bit
  xy_motion(position);
  z_towers(z_position = position[2]);
  bed(offset_bed_from_frame(position));
  x_rails(position.x);
  y_carriage(position);
}

//FIXME 45 is L height from topenclosure part
module top_enclosure() {
  translate ([0, 0, frame_size().z / 2 + enclosure_size().z/2 - extrusion_width() + 42]) {
    enclosure_frame();
     %enclosure_side_panels();
    *encolosure_hinges();
    //handle();
  }
  printed_interface_arrangement();
}

customcore(position = [150, 150, 130]);
*translate([0, 800, 0]) rc300zl(position = [80, 90, 30]);
translate([800, 0, 0]) rc300zlt(position = [150, 150, 130]);
*translate([0, 800, 0]) dancore(position = [150, 150, 130]);
*translate([0, 800, 0]) rc300zlv2(position = [80, 90, 30]);
*translate([800, 800, 0]) rc300zl40();
