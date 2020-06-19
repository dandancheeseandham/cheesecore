// vim: set nospell:
include <config.scad>
use <demo.scad>

module corner_cube(extrusion_type = $extrusion_type) {
  assert(extrusion_width(extrusion_type) != undef, "Must pass a valid extrusion type");

  color("#333333") {
    difference() {
      cube(extrusion_width(extrusion_type), center=true); // outer body
      cube(extrusion_width(extrusion_type) - 3, center=true); // inner hollow

      for(rot = [[0,0,0], [90,0,0], [0,90,0]]) {
        rotate(rot) {
          cylinder(d=extrusion_screw_size(extrusion_type),h=extrusion_width(extrusion_type)*2, center=true, $fn=12); // through-hole
          cylinder(d=extrusion_width(extrusion_type)*0.7,h=extrusion_width(extrusion_type)*2, $fn=20 ); // clearance hole
        }
      }
    }
  }
}

demo() {
corner_cube(extrusion_type);
}
