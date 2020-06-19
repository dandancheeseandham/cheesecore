// vim: set nospell:
include <config.scad>
use <extrusion.scad>
use <corner_cube.scad>
use <lib/layout.scad>
use <demo.scad>
use <extrusion_spacers.scad>

module z_extrusions() {
  mirror_xy() {
    translate([enclosure_size().x / 2 - extrusion_width() / 2, enclosure_size().y / 2 - extrusion_width() / 2, 0])
      extrusion(enclosure_size().z - 2 * extrusion_width());
  }
mirror_x(){
  translate([enclosure_size().x / 2 - extrusion_width() / 2 - $halo_size.x/2, -enclosure_size().y / 2 + extrusion_width() / 2, 0])
  extrusion(enclosure_size().z - 2 * extrusion_width());
}
}

module x_extrusions() {

    translate([0, enclosure_size().y / 2 - extrusion_width() / 2, enclosure_size().z / 2 - extrusion_width() / 2])
      rotate([0,90,0])
        extrusion(enclosure_size().x - 2 * extrusion_width());
/*
  *  translate([0, enclosure_size().y / 2 - extrusion_width() / 2, enclosure_size().z / 2 - extrusion_width() / 2])
          rotate([0,90,0])
            extrusion(enclosure_size().x - 2 * extrusion_width()-$halo_size.x);


  {
   *translate([0, -enclosure_size().y / 2 + extrusion_width() / 2 - side_panel_thickness(), enclosure_size().z / 2 - extrusion_width() / 2 + side_panel_thickness()])
     rotate([0,90,0])
       extrusion(enclosure_size().x - 5 * extrusion_width());
 }
*mirror_xy()
{
 translate([(-enclosure_size().x + $halo_size.x/2)/ 2 + extrusion_width()/2, -enclosure_size().y / 2 + extrusion_width() / 2 - side_panel_thickness(), enclosure_size().z / 2 - extrusion_width() / 2 ])
   rotate([0,90,0])
     extrusion($halo_size.x/2-extrusion_width());
//enclosure_size().x / 2 - extrusion_width() / 2, enclosure_size().y / 2 - extrusion_width() / 2, enclosure_size().z / 2 - extrusion_width() / 2

}
*/

}

module y_extrusions() {
  mirror_x() {
    translate([enclosure_size().x / 2 - extrusion_width() / 2, 0, enclosure_size().z / 2 - extrusion_width() / 2])
     rotate([90,0,0]) {
        extrusion(enclosure_size().y - 2 * extrusion_width());
        *translate ([-$halo_size.x/2,0,0]) extrusion(enclosure_size().y - 2 * extrusion_width());
      }

  }
}

module corner_cubes() {
  mirror_xy() {
    translate([enclosure_size().x / 2 - extrusion_width() / 2, enclosure_size().y / 2 - extrusion_width() / 2, enclosure_size().z / 2 - extrusion_width() / 2])
      rotate([0,0,90])
        corner_cube();
  }

  mirror_x()
  translate([enclosure_size().x / 2 - extrusion_width() / 2 - $halo_size.x/2, -enclosure_size().y / 2 + extrusion_width() / 2, enclosure_size().z / 2 - extrusion_width() / 2])
    rotate([0,0,90])
      corner_cube();

}

module enclosure_frame() {
  x_extrusions();
  y_extrusions();
  z_extrusions();
  corner_cubes();

  // This cube is just for debugging - it makes sure the space between brace and outside extrusion is correct
  //translate([-enclosure_size().x / 2 + extrusion_width(), 0, -enclosure_size().z / 2+ 40]) cube([40, 100, 100]);
  assert(leadscrew_x_offset() == 20, "leadscrew_x_offset() sets placement of stepper and bottom braces.  Must be 20 unless we do something besides NEMA17 z motors");
}

demo(){
enclosure_frame();
}
