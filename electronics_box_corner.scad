// vim: set nospell:
use <config.scad>
use <screwholes.scad>
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
use <lib/holes.scad>
use <lib/layout.scad>
use <demo.scad>

module electronics_box_corner(cornersize, acrylicdepth ,height, ledgewidth , ledgethickness, holesize) {
  color(printed_part_color())
    rotate ([90,270,0])
    translate ([cornersize+ledgewidth-(ledgewidth-10),cornersize+ledgewidth-(ledgewidth-10),-height]) {
      union() {
        difference () {
          cylinder(h=height, r1=cornersize, r2=cornersize, center=false);
          translate ([-5,-5,-height/2])
            cylinder(h=height*2, r1=holesize/2, r2=holesize/2, center=false);
        }

        // top left cube
        translate ([-cornersize,0,0])
          cube ([cornersize,cornersize,height]);
        //bottom right cube
        translate ([0,-cornersize,0])
          cube ([cornersize,cornersize,height]);

        // first "ledge"
        translate ([-cornersize,cornersize-ledgethickness-acrylicdepth,0])
          rotate ([0,0,90]) {
            ledge();
            rotate ([0,0,90])
              fillet (1.5,height);
          }

        // second "ledge"
        translate ([cornersize-ledgethickness-acrylicdepth,-ledgewidth-cornersize,0]) {
          ledge();
          translate ([0,ledgewidth,0])
            rotate ([0,0,180])
            fillet (1.5,height);
        }
      }
    }

  module ledge() {
    translate ([ledgethickness/2,ledgewidth/2,height/2])
      difference() {
        translate ([-ledgethickness/2,-ledgewidth/2,-height/2])
          cube ([ledgethickness,ledgewidth,height]);
        mirror_z() {
          translate ([-height/2,0,(height/2-15)])
            rotate ([0,90,0])
            cylinder(200,holesize/2,holesize/2);
        }
      }
  }
}

demo() {
  *translate ([60,0,-50])
    rotate ([0,0,90])
    import("railcorestls/lostapathy/electronics-box-corner.stl");
  *translate ([0,60,-50])
    rotate ([0,-90,90])
    import("railcorestls/Electronics_Box_Corner.stl");

  // "standard" box
  electronics_box_corner(cornersize = 15, acrylicdepth = 6,height = 60, ledgewidth = 10 , ledgethickness = 4, holesize = 3.5);

  //lostapathy version for heat inserts with thicker "ledge"
  translate ([60,0,0])
    electronics_box_corner(cornersize = 15, acrylicdepth = 6.6 ,height = 60, ledgewidth = 10 , ledgethickness = 7, holesize = 4.75);
}
