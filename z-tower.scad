include <config.scad>
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
use <extrusion.scad>
use <lib/mirror.scad>
use <rail.scad>
use <opencoreparts.scad>
use <z-yoke.scad>
use <coupler.scad>
use <z-bracket.scad>

ztowerextrusions=extrusion_length.z+(2*extrusion);

leadscrewwidth=8;
tr8=4;  //pitch - currently unused

module z_tower(z_position=0) {
  translate ([-extrusion/2, leadscrew_y_offset, ztowerextrusions/2])
    rotate([0,0,0])
      extrusion(extrusion, ztowerextrusions, 3.3);

  // FIXME: This is an approximation, ideally we want to actually compute a
  // real rail position based on a nozzle-to-carriage offset, bed thickness,
  // and yoke-to-carriage offset
  position = rail_length.z/2-50-z_position;
  echo("Passing rail position of: ", position);

  // The z-translate here seems kinda arbitrary?
  translate ([-extrusion,leadscrew_y_offset,(extrusion_length.z)/2+couplerheight])
    rotate([90,-90,270])
      rail_wrapper(rail_length.z, position=position);

 color("#BBB")  translate ([-leadscrew_x_offset, 0,couplerheight])
    cylinder(leadscrew_length, leadscrewwidth/2,leadscrewwidth/2);  // LEADSCREW

  translate ([-leadscrew_x_offset, 0,-paneldepth])
    NEMA(NEMA17);

  // FIXME: this z position is fake, just to make it look decent-ish
  translate([-extrusion-carriage_height(carriage_type_z), leadscrew_y_offset, rail_length.z - z_position - 75])
    z_yoke();

  translate ([-leadscrew_x_offset, 0,couplerheight])
    coupler();

  // bottom z bracket
  translate([0, leadscrew_y_offset +extrusion/2, extrusion])
    z_bracket(extrusion,screwM);
  // top z bracket
  translate([0, leadscrew_y_offset +extrusion/2, extrusion_length.z +extrusion])
    mirror([0, 1, 0])
      rotate([180, 0, 0])
      z_bracket();
}

module z_towers(z_position = 0) {
  translate([bed_offset.x, bed_offset.y, -extrusion_length.z/2 - extrusion]) {
    translate([extrusion_length.x/2, 0, 0]) z_tower(z_position);
    mirror_y() {
      translate([-extrusion_length.x/2, 255/2, 0]) rotate([0,0,180]) z_tower(z_position);
    }
  }
}

z_tower(100);
//z_towers();
