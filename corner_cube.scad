include <config.scad>

module corner_cube(extrusion_type) {
  extrusion = extrusion_width(extrusion_type);
  color("#333333") {
    difference() {
      cube(extrusion, center=true); // outer body
      cube(extrusion - 3, center=true); // inner hollow

      for(rot = [[0,0,0], [90,0,0], [0,90,0]]) {
        rotate(rot) {
          // FIXME: This should be based on screw size, not hard-coded 3.3
          cylinder(d=extrusion_screw_size(extrusion_type),h=extrusion*2, center=true, $fn=12); // through-hole
          cylinder(d=extrusion*0.7,h=extrusion*2, $fn=20 ); // clearance hole
        }
      }
    }
  }
}

corner_cube(extrusion_type);
