include <config.scad>
include <core.scad>
include <lib.scad>
use <extrusion.scad>
use <lib/mirror.scad>
use <rail.scad>
use <opencoreparts.scad>
use <z-yoke.scad>

ztowerextrusions=fullZsize+(2*extrusion);

leadscrewwidth=8;
tr8=4;  //pitch - currently unused

module z_tower(z_position=0) {
  // FIXME: make this parametric
  leadscrewheight=400; // (3) BOM

  translate ([-extrusion/2, leadscrew_y_offset, 0])
    rotate([0,0,0])
      extrusion(extrusion, ztowerextrusions, 3.3);

  // FIXME: This is an approximation, ideally we want to actually compute a
  // real rail position based on a nozzle-to-carriage offset, bed thickness,
  // and yoke-to-carriage offset
  position = railZlength/2-50-z_position;
  echo("Passing rail position of: ", position);

  // The z-translate here seems kinda arbitrary?
  translate ([-extrusion,leadscrew_y_offset,(fullZsize)/2+couplerheight])
    rotate([90,-90,270])
      rail_wrapper(railZlength, position=position);

  translate ([-leadscrew_x_offset, 0,couplerheight])
    cylinder(leadscrewheight, leadscrewwidth/2,leadscrewwidth/2);

  translate ([-leadscrew_x_offset, 0,-paneldepth])
    NEMA(NEMA17);

  // FIXME: this z position is fake, just to make it look decent-ish
  translate([-extrusion-carriage_height(carriage_type_z), leadscrew_y_offset, 388-z_position])
    z_yoke();
}

module z_towers(z_position = 0) {
  // FIXME: the +2 y shift is made up value - but the railcore really does want the bed slightly offcenter toward the rear
  translate([horizontalX/2+extrusion, horizontalY/2+2, 0]) {
    translate([horizontalX/2, 0, 0]) z_tower(z_position);
    mirror_y() {
      translate([-horizontalX/2, 255/2, 0]) rotate([0,0,180]) z_tower(z_position);
    }
  }
}

z_tower(100);
//z_towers();
