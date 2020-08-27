// vim: set nospell:
include <config.scad>
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
use <lib/holes.scad>
use <lib/layout.scad>
use <screwholes.scad>
use <demo.scad>

module camera_mount_holes(){
movedown = 15;
sizeoflens = 55;
screwclearance = 3.2;
translate ([0,-movedown,0]) {
    mirror_xy() {
        //ELP
    translate ([(sizeoflens+3)/2,(sizeoflens+3)/2,0])
      cylinder (d=screwclearance, h=20);
  }
cylinder (d=sizeoflens, h=20);
}
}

module camera_mount_cover(){
  movedown = 15;
  sizeoflens = 55;
  screwclearance = 3.2;
color(printed_part_color())
  translate ([0,-movedown,-1.5]) {
cylinder (d=sizeoflens-fitting_error()*2, h=2+side_panel_thickness());
difference(){
    translate ([-(sizeoflens+8)/2,-(sizeoflens+8)/2,0])
      cube([sizeoflens+8,sizeoflens+8,2]);

      mirror_xy() {
          //ELP
      translate ([(sizeoflens+3)/2,(sizeoflens+3)/2,0])
        cylinder (d=screwclearance-fitting_error(), h=4+side_panel_thickness());
    }
}

  }

}
