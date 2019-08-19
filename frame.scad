// vim: set nospell:
include <config.scad>
use <extrusion.scad>
use <corner_cube.scad>
use <lib/mirror.scad>

module z_extrusions() {
  mirror_xy() {
    translate([extrusion_length.x/2+extrusion/2, extrusion_length.y/2+extrusion/2, 0])
      extrusion(extrusion, extrusion_length.z, 3.3, center=true);
  }
}

module x_extrusions() {
  mirror_yz() {
    translate([0, extrusion_length.y/2+extrusion/2, extrusion_length.z/2+extrusion/2])
      rotate([0,90,0])
        extrusion(extrusion, extrusion_length.x, 3.3, center=true);
  }
}

module y_extrusions() {
  mirror_xz() {
    translate([extrusion_length.x/2+extrusion/2, 0, extrusion_length.z/2+extrusion/2])
      rotate([90,0,0])
        extrusion(extrusion, extrusion_length.y, 3.3, center=true);
  }
}

module corner_cubes() {
  mirror_xyz() {
    translate([extrusion_length.x/2+extrusion/2, extrusion_length.y/2+extrusion/2, extrusion_length.z/2+extrusion/2])
      rotate([0,0,90])
        corner_cube();
  }
}

module frame(bottom_braces=true) {
  translate([extrusion_length.x/2+extrusion, extrusion_length.y/2+extrusion, extrusion_length.z/2+extrusion]) {
    x_extrusions();
    y_extrusions();
    z_extrusions();
    corner_cubes();
  }

  translate([extrusion_length.x/2+extrusion, extrusion_length.y/2+extrusion, 0])
  if(bottom_braces) {
    mirror_x() {
      // FIXME: the -50 term here is based on NEMA17 motor size, if we make that parametric this should be a param as well
      translate([extrusion_length.x/2-50, 0, extrusion/2])
        rotate([90, 0, 0])
          extrusion(extrusion, extrusion_length.y, 3.3, center=true);
    }
  }
}

frame();
