// vim: set nospell:
include <config.scad>
use <extrusion.scad>
use <corner_cube.scad>
use <lib/mirror.scad>

// FIXME: this may need to be copied into each module, or wrapped in a function
offset = extrusion_width() / 2;

module z_extrusions() {
  mirror_xy() {
    translate([frame_size().x / 2 - offset, frame_size().y / 2 - offset, 0])
      extrusion(frame_size().z - 2 * extrusion_width());
  }
}

module x_extrusions() {
  mirror_yz() {
    translate([0, frame_size().y / 2 - offset, frame_size().z / 2 - offset])
      rotate([0,90,0])
        extrusion(frame_size().x - 2 * extrusion_width());
  }
}

module y_extrusions() {
  mirror_xz() {
    translate([frame_size().x / 2 - offset, 0, frame_size().z / 2 - offset])
      rotate([90,0,0])
        extrusion(frame_size().y - 2 * extrusion_width());
  }
}

module corner_cubes() {
  mirror_xyz() {
    translate([frame_size().x / 2 - offset, frame_size().y / 2 - offset, frame_size().z / 2 - offset])
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
      translate([frame_size().x / 2 + offset - leadscrew_x_offset*2, 0, offset - frame_size().z / 2])
        rotate([90, 0, 0])
          extrusion(frame_size().y - 2 * extrusion_width());
    }
  }
}

frame($extrusion_type = extrusion15);
