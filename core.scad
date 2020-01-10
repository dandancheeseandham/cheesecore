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
use <validation.scad>
use <top_enclosure_parts.scad>
use <top_enclosure_side_panels.scad>
use <top_enclosure_frame.scad>
use <xy_motion.scad>
use <y_carriage.scad>

ver = version();
if(ver[0]<2019||(ver[0]==2019&&ver[1]<5)) {
    echo("<font color='red'>You need to update OpenSCAD.</font>");
    echo(str("<font color='red'>This OpenSCAD model was made with version 2019.5.0, you are using version ", str(version()[0]), ".",str(version()[1]), ".",str(version()[2]), "</font>"));
}



//CORE MODULES
module enclosure() {
  bottom_braces = false ;
  frame(bottom_braces);
  all_side_panels(bottom_braces);
  hinges();
  %doors();
  feet(height=50);
 }

//FIXME: position isn't quite right
module kinematics(position) {
  xy_motion(position);
  z_towers(z_position = position[2]);
  bed(offset_bed_from_frame(position));
  x_rails(position.x);
  y_carriage(position);
}

//FIXME 45 is L height from topenclosure part
module top_enclosure() {
  enclosure_height_above_frame = 4;
  translate ([0, 0, frame_size().z / 2 + enclosure_size().z/2 - extrusion_width() + enclosure_height_above_frame]) {
    enclosure_frame();
     %enclosure_side_panels();
    enclosure_hinges();
    enclosure_handle();
  }
  *printed_interface_arrangement();
}

module printer(position = [0, 0, 0]) {
  validate();
  enclosure();
  kinematics(position);
  *electronics_box_contents();
  electronics_box_panels_assembly();
  *top_enclosure();
  report();
}

module report() {
  echo ("Extrusions dimensions: " , frame_size());
  echo ("Halo dimensions: " , halo_size());
  echo ("Top Enclosure dimensions: ", enclosure_size());
  echo ("Leadscrew length: ",leadscrew_length());
  echo ("Leadscrew diameter: ",leadscrew_diameter());
  echo ("Rail lengths",rail_lengths());
  echo ("NEMAtypeXY() :",NEMAtypeXY());
  echo ("NEMAtypeZ() :",NEMAtypeZ());
  echo ("Bed")
  echo ("===")
  echo ("bed_plate_size() :", bed_plate_size() );
  echo ("bed_ear_spacing() :", bed_ear_spacing() );
  echo ("bed_overall_size() :", bed_overall_size() );
  echo ("bed_thickness() :", bed_thickness() );
}
