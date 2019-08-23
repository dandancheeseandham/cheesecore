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


electronicsbox_size_x = 400; //for PSU
electronicsbox_size_y = 1;


module electronics_box_contents() {
extrusion=15;
  translate([0,200-100,200]) rotate([90,90,90]) psu(S_250_48);
  translate([0,200-300,330]) rotate([90,0,90])  pcb(DuetE);
  translate([0,200-200,430]) rotate([90,0,90])  translate ([-100,-220,0]) pcb(Duex5);
  translate([0,200-200,50]) rotate([90,0,90])  ssr_assembly(ssrs[1], M3_cap_screw, 3);
 
  translate ([0,electronicsbox_size_x/2,0])  rotate([90,0,180]) iec(IEC_fused_inlet);
  
}

electronics_box_contents();