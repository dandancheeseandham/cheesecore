// vim: set nospell:
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
use <lib/layout.scad>
use <extrusion.scad>
use <side_panels.scad>
use <frame.scad>
include <config.scad>
use <foot.scad>
use <bed.scad>
use <z-tower.scad>
use <rail.scad>
use <electronics_box_panels.scad>
use <electronics_box_contents.scad>
use <electronics_box_assembly.scad>
use <validation.scad>
use <top_enclosure_parts.scad>
use <top_enclosure_side_panels.scad>
use <top_enclosure_frame.scad>
use <xy_motion.scad>
use <y_carriage.scad>
use <door_hinge.scad>
include <report.scad>

ver = version();
if(ver[0]<2019||(ver[0]==2019&&ver[1]<5)) {
    echo("<font color='red'>You need to update OpenSCAD.</font>");
    echo(str("<font color='red'>This OpenSCAD model was made with version 2019.5.0, you are using version ", str(version()[0]), ".",str(version()[1]), ".",str(version()[2]), "</font>"));
}

//CORE MODULES
module enclosure() {
  frame();
  all_side_panels();
  feet();
 }

//FIXME: position isn't quite right
module kinematics(position) {
  xy_motion(position);
  z_towers(z_position = position[2]);
  flex_plate(offset_bed_from_frame(position));
  bed(offset_bed_from_frame(position));
  x_rails(position.x);
  y_carriage(position);
}

module door_assembly() {
  hinges();
  //single_door();
  doors();
}

//FIXME 45 is L height from topenclosure part
module top_enclosure() {
  translate ([0, 0, frame_size().z / 2 + enclosure_size().z/2 - extrusion_width() + halo_size().z + enclosure_height_above_frame()]) {
    enclosure_frame();
    enclosure_side_panels();
    *enclosure_hinges();  //FIXME: Hinges need replacing, or perhaps change to long misumi hinges for neatness.
    *enclosure_handle();
  }
  *printed_interface_arrangement();  // do not need the printed interface arrangement with the cheesecore halo. Left for backwards compatibility.
}

module printer(position = [90, 90, 0]) {
  validate();
  enclosure();
  kinematics(position);
  *door_assembly();
  *electronics_box_contents();
  electronics_box_assembly(panelon = true);
  top_enclosure();
    report();

}

module justdoors() {
  hinges();
  doors();
}
