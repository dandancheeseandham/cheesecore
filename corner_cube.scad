include <config.scad>

module corner_cube(size) {
  color("#333333") {
    difference() {
      cube(extrusion, center=true); // outer body
      cube(extrusion - 3, center=true); // inner hollow

      for(rot = [[0,0,0], [90,0,0], [0,90,0]]) {
        rotate(rot) {
          // FIXME: This should be based on screw size, not hard-coded 3.3
          cylinder(d=3.3,h=extrusion*2, center=true, $fn=12); // through-hole
          cylinder(d=extrusion-5,h=extrusion*2, $fn=20 ); // clearance hole
        }
      }
    }
  }
}

corner_cube(15);