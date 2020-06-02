// vim: set nospell:
include <config.scad>
use <nopscadlib/vitamins/stepper_motor.scad>
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
include <nopscadlib/vitamins/stepper_motors.scad>
include <nopscadlib/vitamins/ssr.scad>
use <lib/holes.scad>
use <lib/layout.scad>
use <door_hinge.scad>
use <screwholes.scad>
use <halo.scad>
use <demo.scad>
use <electronics_box_panels.scad>
use <door_hinge.scad>
use <filament_holder.scad>
use <filament_holder2kg.scad>

module extrusion_spacers(sizex,sizey){
  //3.4mm to slot in from the top
  //5.7mm to slot in from the side_panel
  //2.6mm heigh (3.6 with slanted bit)
  //slotsize = 3.4 - 0.6; // 0.6 to shrink the part an arbitary amount
  slotsize = 5.7 - 0.6; // 0.6 to shrink the part an arbitary amount
  outer = 15 - (slotsize/2);
  inner = 15 + (slotsize/2);
  slot_height = 3;
  cube=15;
  //render()
  difference(){
  translate ([(-sizex+outer)/2,(-sizey+outer)/2,0]) cube([sizex-outer,sizey-outer,2.2]);
  translate ([(-sizex+inner)/2,(-sizey+inner)/2,-2]) cube([sizex-inner,sizey-inner,10]);
  extrusion_spacer_generation(sizex, sizey) ;
  mirror_xy() translate([sizex/2-cube,sizey/2-cube,-1]) cube([cube,cube,cube+2]); //corners
}


module extrusion_spacer_generation(x, y)
{

  // replace clearance_hole_size(extrusion_screw_size() with your own variable

  // How far from center of first hole to center of last hole
  extent_x = x - 2 * panel_screw_offset();
  extent_y = y - 2 * panel_screw_offset();

  // How many screws in each direction
  screws_x = ceil(extent_x / max_panel_screw_spacing()) + 1;
  screws_y = ceil(extent_y / max_panel_screw_spacing()) + 1;

  // How far between screws
  screw_spacing_x = extent_x / (screws_x - 1);
  screw_spacing_y = extent_y / (screws_y - 1);

  mirror_y() {
    for (a =[0:(screws_x - 1)]) {
      translate ([-x/2 + panel_screw_offset() + (screw_spacing_x * a), y / 2 - extrusion_width() / 2, -epsilon])
        // FIXME - this should be a hole() not a cylinder
        cylinder(h=side_panel_thickness() + 2 * epsilon, d=6);
    }
  }

  mirror_x() {
    for (a =[0:(screws_y - 1)]) {
      translate ([x / 2 - extrusion_width() / 2, -y / 2 + panel_screw_offset() + (screw_spacing_y * a), -epsilon])
        // FIXME - this should be a hole not a cylinder
        cylinder(h=side_panel_thickness() + 2 * epsilon, d=6);
    }
  }
}
}

module all_extrusion_spacers()
{
  translate ([0,0,-frame_size().y / 2+5]) extrusion_spacers(frame_size().x,frame_size().y);
   rotate ([0,90,0]) mirror_y() translate ([0,0,frame_size().y / 2+15]) extrusion_spacers(frame_size().z,frame_size().y);
 rotate ([90,0,0])  translate ([0,0,-frame_size().x / 2+18]) extrusion_spacers(frame_size().x,frame_size().z);
}

demo() {
translate ([0,0,-frame_size().y / 2+5]) extrusion_spacers(frame_size().x,frame_size().y);
  }
