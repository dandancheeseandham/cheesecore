include <config.scad>
include <core.scad>
include <lib.scad>
use <extrusion.scad>
use <lib/mirror.scad>
include <opencoreparts.scad>

ztowerextrusions=fullZsize+(2*extrusion);

leadscrewwidth=8;
tr8=4;  //pitch - currently unused

module z_tower() {
  // FIXME: make this parametric
  leadscrewheight=400; // (3) BOM

  leadscrew_x_offset = 20;
  leadscrew_y_offset = 30.013; // taken off z yoke in fusion

  translate ([-extrusion/2, leadscrew_y_offset, 0])
    rotate([0,0,0])
      extrusion(extrusion, ztowerextrusions, 3.3);

  // The z-translate here seems kinda arbitrary?
  translate ([-extrusion,leadscrew_y_offset,(fullZsize)/2+couplerheight])
    rotate([90,-90,270])
      rail(railZlength);

  translate ([-leadscrew_x_offset, 0,couplerheight])
    cylinder(leadscrewheight, leadscrewwidth/2,leadscrewwidth/2);

  translate ([-leadscrew_x_offset, 0,-paneldepth])
    NEMA(NEMA17);
}

module z_towers() {
  // FIXME: the +2 y shift is made up value - but the railcore really does want the bed slightly offcenter toward the rear
  translate([horizontalX/2+extrusion, horizontalY/2+2, 0]) {
    translate([horizontalX/2, 0, 0]) z_tower();
    mirror_y() {
      translate([-horizontalX/2, 255/2, 0]) rotate([0,0,180]) z_tower();
    }
  }
}

//#z_tower();
z_towers();
