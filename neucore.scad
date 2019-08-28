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
  z_towers(extrusion_type, model[3].z, z_position = position[2]);
  all_side_panels();
  // FIXME: this is not a final height for belts
  translate ([0, 0, extrusion_length.z/2 + extrusion_width + 20]) corexy_belts([position.x-210, position.y]);

// bed
  // FIXME: This placement of the bed is arbitrary in z, but linked to  
  // "position = rail_length.z/2-50-z_position;" in z-tower
  translate ([bed_offset.x, bed_offset.y, extrusion_length.z/2 - position.z - 111]) bed();

//X-rail
  translate ([0, 0, extrusion_length.z/2 + extrusion_width / 2])
    x_rails(model[3].x, position.x);

// Y-rail
  // FIXME: x position here is an approximation to look decent
  translate ([-rail_length.x/2 + 3 + position.x, 0, extrusion_length.z/2 + extrusion_width / 2])
    rotate([270, 0, 90])
      rail_wrapper(model[3].y,rail_length.y, position = position.y-150);

//hotend
translate ([-rail_length.x/2+15 + position.x, position.y, extrusion_length.z/2 + extrusion_width / 2])
translate ([-50,-150,20]) // FIXME: arbitary move to look decentish
    rotate ([0,0,180]) hot_end(E3Dv6, naked=true);

//x-carriage temp object
// 12 = rail size

mirror_y() translate ([-rail_length.x/2+10 + position.x, extrusion_length.y/2-12, extrusion_length.z/2 + extrusion_width / 2]) x_carriage();   
    
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
      translate([49, -extrusion_length.y/2+8, 0])  NEMA(NEMA17);
    }
  }




//electronics box
*translate([extrusion_length.x/2+6+extrusion_width(extrusion_type), 0, extrusion_width(extrusion_type)]  ) rotate ([0,0,90]) electronics_box (298.9,238.9); // Old ZL size

translate([extrusion_length.x/2+6+extrusion_width(extrusion_type), 0,extrusion_width(extrusion_type)]  ) rotate ([0,0,90]) electronics_box (350,290); // New bigger ZL box


  if(render_electronics)
  {
    // FIXME - should not need to translate here just by paneldepth
translate([extrusion_length.x/2+6+extrusion_width(extrusion_type), 0, 0]  )
      electronics_box_contents();
  }
}


//FIXME: x=80 is around X0, y=-20 is around Y0, z=-50 is around Z0
//printer(render_electronics=false, position=[130, -20+100, -50]);


module rc300zl(position = [0, 0, 0]) {
  $extrusion_type = extrusion15;
  // TODO: perhaps extract out wrappers for "common" parts like frame_and_sides or something?
  frame();
}

module rc300zl40(position = [0, 0, 0]) {
  $extrusion_type = extrusion40;
  frame();
}

rc300zl();

translate([550, 0, 0]) rc300zl40();
