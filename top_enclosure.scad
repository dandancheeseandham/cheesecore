// vim: set nospell:
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
use <lib/mirror.scad>
use <extrusion.scad>
use <top_enclosure_side_panels.scad>
use <top_enclosure_frame.scad>
include <config.scad>
use <validation.scad>
use <door_hinge.scad>

$fullrender=false;

module top_enclosure_all(){
  frame();
  all_side_panels();
  hinges();
}

$front_window_size = front_window_zl;
$frame_size = [490, 455, 250];
// $frame_size = frame_rc300zl;
$rail_specs = rails_rc300zl;
top_enclosure_all($extrusion_type = extrusion15);

