// vim: set nospell:
include <config.scad>
use <extrusion.scad>
use <corner_cube.scad>
use <lib/layout.scad>
use <demo.scad>

module z_extrusions() {
//color("Black")  //Colours are for later documentation identification
  mirror_xy() {
    translate([frame_size().x / 2 - extrusion_width() / 2, frame_size().y / 2 - extrusion_width() / 2, 0])
      extrusion(frame_size().z - 2 * extrusion_width());
  }
}

module x_extrusions() {
//color("Purple")
  mirror_yz() {
    translate([0, frame_size().y / 2 - extrusion_width() / 2, frame_size().z / 2 - extrusion_width() / 2])
      rotate([0,90,0])
        extrusion(frame_size().x - 2 * extrusion_width());
  }
}

module y_extrusions() {
  //color("Blue")
  mirror_xz() {
    translate([frame_size().x / 2 - extrusion_width() / 2, 0, frame_size().z / 2 - extrusion_width() / 2])
      rotate([90,0,0])
        extrusion(frame_size().y - 2 * extrusion_width());
  }
}

module corner_cubes() {
  mirror_xyz() {
    translate([frame_size().x / 2 - extrusion_width() / 2, frame_size().y / 2 - extrusion_width() / 2, frame_size().z / 2 - extrusion_width() / 2])
      rotate([0,0,90])
        corner_cube();
  }
}

module frame() {
  x_extrusions();
  y_extrusions();
  z_extrusions();
  corner_cubes();

  // This cube is just for debugging - it makes sure the space between brace and outside extrusion is correct
  // #translate([-frame_size().x / 2 + extrusion_width(), 0, -frame_size().z / 2+ 40]) cube([40, 100, 100]);
  assert(leadscrew_x_offset() == 20, "leadscrew_x_offset() sets placement of stepper and bottom braces.  Must be 20 unless we do something besides NEMA17 z motors");

  if(include_bottom_braces()) {
    mirror_x() {
      //color("Blue")
      translate([frame_size().x / 2 - extrusion_width() * 2 - 2 * leadscrew_x_offset(), 0, extrusion_width() / 2 - frame_size().z / 2])
        rotate([90, 0, 0])
          extrusion(frame_size().y - 2 * extrusion_width());
    }
  }
}

demo() {
  frame();
}
