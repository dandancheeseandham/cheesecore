// vim: set nospell:
include <config.scad>
use <extrusion.scad>
use <corner_cube.scad>
use <lib/mirror.scad>

// FIXME: this may need to be copied into each module, or wrapped in a function
offset = extrusion_width() / 2;

module z_extrusions() {
  mirror_xy() {
    translate([extrusion_length.x/2 + offset, extrusion_length.y/2 + offset, 0])
      extrusion(extrusion_length.z);
  }
}

module x_extrusions() {
  mirror_yz() {
    translate([0, extrusion_length.y/2+ offset, extrusion_length.z/2 + offset])
      rotate([0,90,0])
        extrusion(extrusion_length.x);
  }
}

module y_extrusions() {
  mirror_xz() {
    translate([extrusion_length.x/2+ offset, 0, extrusion_length.z/2 + offset])
      rotate([90,0,0])
        extrusion(extrusion_length.y);
  }
}

module corner_cubes() {
  mirror_xyz() {
    translate([extrusion_length.x/2 + offset, extrusion_length.y/2 + offset, extrusion_length.z/2 + offset])
      rotate([0,0,90])
        corner_cube();
  }
}

module frame(bottom_braces=true) {
  x_extrusions();
  y_extrusions();
  z_extrusions();
  corner_cubes();

  if(bottom_braces) {
    mirror_x() {
      translate([extrusion_length.x/2 - offset - leadscrew_x_offset*2, 0, -offset - extrusion_length.z / 2])
        rotate([90, 0, 0])
          extrusion(extrusion_length.y);
    }
  }
}

frame($extrusion_type = extrusion15);
