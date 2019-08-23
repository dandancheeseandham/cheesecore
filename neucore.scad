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
use <electronicsbox_panels.scad>
use <electronics_box_contents.scad>
use <x-carriage.scad>

$fullrender=false;


module printer(render_electronics=false, position=[0, 0, 0]) {
  extrusion_width = extrusion_width(extrusion_type);

  frame(extrusion_type);
  feet(extrusion_type, height=50);
  z_towers(extrusion_type, z_position = position[2]);
  all_side_panels();
  // FIXME: this is not a final height for belts
  translate ([0, 0, extrusion_length.z/2 + extrusion_width + 11]) corexy_belts([position.x-150, position.y]);

  // FIXME: This placement of the bed is arbitrary in z.
  translate ([bed_offset.x, bed_offset.y, extrusion_length.z/2 - position.z - 100]) bed();

  translate ([0, 0, extrusion_length.z/2 + extrusion_width / 2])
    x_rails(position.x);

  // FIXME: x position here is an approximation to look decent
  translate ([-rail_length.x/2+55 + position.x, 0, extrusion_length.z/2 + extrusion_width / 2])
    rotate([270, 0, 90])
      rail_wrapper(rail_length.y, position = position.y-150);

//x-carriage temp object
// 12 = rail size

translate ([-rail_length.x/2+55 + position.x, extrusion_length.y/2-12, extrusion_length.z/2 + extrusion_width / 2]) x_carriage();
mirror_y() translate ([-rail_length.x/2+55 + position.x, extrusion_length.y/2-12, extrusion_length.z/2 + extrusion_width / 2]) x_carriage();   
    
  // Idler mounts
  translate ([-extrusion_length.x/2, 0, extrusion_length.z/2 + extrusion_width]) {
    mirror_y() {
      translate([0, -extrusion_length.y/2, 0])
        aluminium_idler_mount();
    }
  }

  // motor mounts
  translate([extrusion_length.x/2, 0, extrusion_length.z/2 + extrusion_width]){
    mirror_y() {
      translate([0, extrusion_length.y/2, 0])
        aluminium_motor_mount();
      translate([49, extrusion_length.y/2-8, 0])  NEMA(NEMA17);
    }
  }

//hotend
  translate ([-170,-140,230]) rotate ([0,0,180]) hot_end(E3Dv6);


//electronics box
translate([extrusion_length.x/2+6+extrusion_width(extrusion_type), 0, extrusion_width(extrusion_type)]  ) rotate ([0,0,90]) electronics_box (298.9,238.9); // Old ZL size

*translate([extrusion_length.x/2+6+extrusion_width(extrusion_type), 0,extrusion_width(extrusion_type)]  ) rotate ([0,0,90]) electronics_box (350,290); // New bigger ZL box


  if(render_electronics)
  {
    // FIXME - should not need to translate here just by paneldepth
translate([extrusion_length.x/2+6+extrusion_width(extrusion_type), 0, 0]  )
      electronics_box_contents();
  }
}

printer(render_electronics=true, position=[0, 0, 150]);
