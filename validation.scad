// vim: set nospell:
include <config.scad>

module validate() {
  assert(panel_screw_offset() > extrusion_width() + 10, "Panel Screws must be offset clear of the corner cubes");
  // Need to also check that there is enough room for the anti-backlash nut in the yoke
  //FIXME: not sure why this broke
  //assert(leadscrew_y_offset >= leadscrew_x_offset + extrusion_width() / 2, str("Z stepper screws will be hidden. ", leadscrew_y_offset, " vs ", leadscrew_x_offset + extrusion_width() /2));
}
