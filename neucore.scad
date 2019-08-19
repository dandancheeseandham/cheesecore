// vim: set nospell:
include <core.scad>
include <lib.scad>
use <extrusion.scad>
use <opencoreparts.scad>
use <side_panels.scad>
use <frame.scad>
include <config.scad>
use <foot.scad>
use <bed.scad>
use <z-tower.scad>
use <rail.scad>
use <aluminium_idlermount.scad>
use <aluminium_motormount.scad>

$fullrender=false;

// BOM Item Name: 16 tooth 5mm bore GT2 Pulley
// BOM Quantity: 2
// BOM Link: http://railco.re/motion
// Notes: For X/Y/Z steppers (Only 2 needed for the ZL Build)

// BOM Item Name: Gt2 smooth idlers 5mm ID
// BOM Quantity: 2
// BOM Link: http://railco.re/motion
// Notes:

// BOM Item Name: Gt2 20 tooth idlers 5mm ID
// BOM Quantity: 6
// BOM Link: http://railco.re/motion
// Notes: for corexy motion gear

// BOM Item Name: 5mm I.D. x 6mm O.D. x 0.40mm Shim
// BOM Quantity: 1 pack
// BOM Link: http://railco.re/motion
// Notes: For shimming the bearings

// BOM Item Name: GT2 Belt (5m)
// BOM Quantity: 1
// BOM Link: http://railco.re/motion
// Notes: X/Y Motion belts (4400mm total, 2200mm per side)
// FIXME: we should probably position all of these onto a more convenient plane and rotation - like flat on x/y, centered about z axis
// Then we have simplier translations here, and we can rotate/translate the whole contents as a unit when assembling the machine
module electronics_box_contents() {
  //
  //BOM ELECTRONICS
  //

  // BOM Item Name: 24v PSU 350w PSU (needs to be 200w or greater with AC bed)
  // BOM Quantity: 1
  // BOM Link: http://railco.re/sidepanels
  // Notes: DAny 24v PSU > 200W works with the AC bed.
  panelY=extrusion_length.y+extrusion*2;
  panelZ=extrusion_length.z+extrusion*2;

  translate([panelY+40,panelZ-100,280]) rotate([90,90,90])  psu(S_250_48);
  translate([panelY+40,panelZ-300,330]) rotate([90,0,90])  pcb(DuetE);
  translate([panelY+40,panelZ-200,430]) rotate([90,0,90])  translate ([-100,-220,0]) pcb(Duex5);
  translate([panelY+40,panelZ-200,130]) rotate([90,0,90])  ssr_assembly(ssrs[1], M3_cap_screw, 3);
  translate ([50,-220,0]) hot_end(E3Dv6);
  translate ([50,-150,0]) iec(IEC_fused_inlet);
  translate ([50,-120,0]) leadnut(LSN8x8);
  //translate ([50,-320,0]) psu(S_250_48);
}


module printer(render_electronics=false, position=[0, 0, 0]) {
  frame();
  feet();
  z_towers(position[2]);
  all_side_panels();
  // FIXME: this z translate is very crude but looks better with extrusion != 15
  translate ([0, 0, extrusion_length.z/2 + extrusion+20]) rotate ([0,0,90])  corexy_belt();

  // FIXME - extract this -13 term to a new variable like bed_offset and use it to drive everything
  // related to bed and z-tower placement
  // This placement of the bed is approximate in x/y, and arbitrary in z.
  translate ([0, -13, extrusion_length.z/2 - position.z - 100]) bed();

  translate ([0, 0, extrusion_length.z/2 + extrusion/2])
    x_rails(position.x);

  // FIXME: x position here is an approximation to look decent
  translate ([-rail_length.x/2+55 + position.x, 0, extrusion_length.z/2 + extrusion/2])
    rotate([270, 0, 90])
      rail_wrapper(rail_length.y);

  // Idler mounts
  translate ([-extrusion_length.x/2, 0, extrusion_length.z/2 + extrusion]) {
    mirror_y() {
      translate([0, -extrusion_length.y/2, 0])
        aluminium_idler_mount();
    }
  }

  // motor mounts
  translate([extrusion_length.x/2, 0, extrusion_length.z/2 + extrusion]  ){
    mirror_y() {
      translate([0, extrusion_length.y/2, 0])
        aluminium_motor_mount();
      translate([49, extrusion_length.y/2-8, 0])  NEMA(NEMA17); // I've popped NEMA's here until a better place is found (probably when you educate me :P 
    }
  }

  if(render_electronics)
  {
    // FIXME - should not need to translate here just by paneldepth
    translate([paneldepth, 0, 0])
      electronics_box_contents();
  }
}

printer(render_electronics=false, position=[300, 0, 150]);
