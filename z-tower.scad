include <config.scad>
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
use <extrusion.scad>
use <lib/mirror.scad>
use <rail.scad>
use <z-yoke.scad>
use <coupler.scad>
use <anti-backlash-nut.scad>
use <z-bracket.scad>


leadscrewwidth=8;
tr8=4;  //pitch - currently unused

module z_tower(extrusion_type, z_position=0) {
  extrusion_width = extrusion_width(extrusion_type);
  overall_length = extrusion_length.z + 2 * extrusion_width;

  translate ([-extrusion_width/2, leadscrew_y_offset, overall_length / 2])
    rotate([0,0,0])
      extrusion(extrusion_type,  overall_length);

  // FIXME: This is an approximation, ideally we want to actually compute a
  // real rail position based on a nozzle-to-carriage offset, bed thickness,
  // and yoke-to-carriage offset
  position = rail_length.z/2-50-z_position;
  echo("Passing rail position of: ", position);

  // The z-translate here seems kinda arbitrary?
  translate ([-extrusion_width,leadscrew_y_offset,(extrusion_length.z)/2+couplerheight])
    rotate([90,-90,270])
      rail_wrapper(rail_length.z, position=position);

 color("#BBB")  translate ([-leadscrew_x_offset, 0,couplerheight])
    cylinder(leadscrew_length, leadscrewwidth/2,leadscrewwidth/2);  // LEADSCREW

  translate ([-leadscrew_x_offset, 0,-paneldepth])
    NEMA(NEMA17);

  // FIXME: z position is fake
  translate([-leadscrew_x_offset, 0, rail_length.z - z_position - 85])
    anti_backlash_nut(8);

  // FIXME: this z position is fake, just to make it look decent-ish
  translate([-extrusion_width-carriage_height(carriage_type_z), leadscrew_y_offset, rail_length.z - z_position - 75])
    z_yoke(extrusion_type);

  translate ([-leadscrew_x_offset, 0,couplerheight])
    coupler();

  // bottom z bracket
  translate([0, leadscrew_y_offset +extrusion_width/2, extrusion_width])
    z_bracket(extrusion_type);
  // top z bracket
  translate([0, leadscrew_y_offset +extrusion_width/2, extrusion_length.z +extrusion_width])
    mirror([0, 1, 0])
      rotate([180, 0, 0])
        z_bracket(extrusion_type);
}

module z_towers(extrusion_type, z_position = 0) {
  translate([bed_offset.x, bed_offset.y, -extrusion_length.z/2 - extrusion_width(extrusion_type)]) {
    translate([extrusion_length.x/2, 0, 0]) z_tower(extrusion_type, z_position);
    mirror_y() {
      translate([-extrusion_length.x/2, 255/2, 0]) rotate([0,0,180]) z_tower(extrusion_type, z_position);
    }
  }
}

//z_tower(extrusion_type, 100);
z_towers(extrusion_type);
