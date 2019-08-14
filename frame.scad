// vim: set nospell:
include <config.scad>
use <extrusion.scad>
use <corner_cube.scad>
use <lib/mirror.scad>

module z_extrusions() {
  mirror_xy() {
    translate([horizontalX/2+extrusion/2, horizontalY/2+extrusion/2, 0])
      extrusion(extrusion, corneruprightZ, 3.3, center=true);
  }
}

module x_extrusions() {
  mirror_yz() {
    translate([0, horizontalY/2+extrusion/2, corneruprightZ/2+extrusion/2])
      rotate([0,90,0])
        extrusion(extrusion, horizontalX, 3.3, center=true);
  }
}

module y_extrusions() {
  mirror_xz() {
    translate([horizontalX/2+extrusion/2, 0, corneruprightZ/2+extrusion/2])
      rotate([90,0,0])
        extrusion(extrusion, horizontalY, 3.3, center=true);
  }
}

module corner_cubes() {
  mirror_xyz() {
    translate([horizontalX/2+extrusion/2, horizontalY/2+extrusion/2, corneruprightZ/2+extrusion/2])
      rotate([0,0,90])
        corner_cube();
  }
}

module frame() {
  translate([horizontalX/2+extrusion, horizontalY/2+extrusion, corneruprightZ/2+extrusion]) {
    x_extrusions();
    y_extrusions();
    z_extrusions();
    corner_cubes();
  }
}

frame();
