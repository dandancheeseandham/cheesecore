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

  translate ([0, 0, frame_size().z / 2 + enclosure_size().z/2 - extrusion_width() + halo_thickness() + enclosure_height_above_frame()]) {
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
  top_enclosure();
  report();
}

module report() {
  echo ("*================================================*");
  echo ("BRANDING NAME: " , $branding_name);
  echo ("Extrusion width:", extrusion_width());
  echo ("Extrusion _screw_size:", extrusion_screw_size());
  echo ("Frame total dimensions: " , frame_size());
  echo ("Extrusions only dimensions: " , frame_size() - [30,30,30]);
  echo ("Halo dimensions: " , halo_size());
  echo ("Top Enclosure total dimensions: ", enclosure_size());
  echo ("Top Enclosure extrusion dimensions: ", enclosure_size() - [30,30,30]);
  echo ("------------------------------------------");
  echo ("Leadscrew length: ",leadscrew_length());
  echo ("Leadscrew diameter: ",leadscrew_diameter());
  echo ("Rail lengths",rail_lengths());
  //echo ("Rail profiles",rail_profiles());
  echo ("------------------------------------------");
  echo ("NEMAtypeXY() :",NEMAtypeXY());
  echo ("NEMAtypeZ() :",NEMAtypeZ());
  echo ("------------------------------------------");
  echo ("bed_plate_size() :", bed_plate_size() );
  echo ("bed_ear_spacing() :", bed_ear_spacing() );
  echo ("bed_overall_size() :", bed_overall_size() );
  echo ("bed_thickness() :", bed_thickness() );
  echo ("------------------------------------------");
  echo ("ELECTRONICS BOX");
  echo ("box_size_y() :",  box_size_y() );
  echo ("box_size_z() :", box_size_z() );
  echo ("box_depth() ) :", box_depth() );
  echo ("------------------------------------------");
  echo ("panels:",$panels[1]);
  echo ("side_panel_thickness()",side_panel_thickness() );
  echo ("potatoes:",potato_thickness() );
  echo ("------------------------------------------");
}
