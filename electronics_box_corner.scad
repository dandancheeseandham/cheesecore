// vim: set nospell:
use <config.scad>
use <screwholes.scad>
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
use <lib/holes.scad>
use <lib/layout.scad>
use <demo.scad>

module electronics_box_corner() {
  color(printed_part_color())
    rotate ([90,270,0])
      translate ([elec_corner_size()+elec_corner_ledge_width()-(elec_corner_ledge_width()-10),elec_corner_size()+elec_corner_ledge_width()-(elec_corner_ledge_width()-10),-box_depth()]) {
        union() {
          difference () {
            cylinder(h=box_depth(), r1=elec_corner_size(), r2=elec_corner_size(), center=false);
            translate ([-5,-5,-box_depth()/2])
              cylinder(h=box_depth()*2, r1=elec_corner_holesize()/2, r2=elec_corner_holesize()/2, center=false);
          }

        // top left cube
        translate ([-elec_corner_size(),0,0])
          cube ([elec_corner_size(),elec_corner_size(),box_depth()]);
        //bottom right cube
        translate ([0,-elec_corner_size(),0])
          cube ([elec_corner_size(),elec_corner_size(),box_depth()]);

        // first "ledge"
        translate ([-elec_corner_size(),elec_corner_size()-elec_corner_ledge_thickness()-acrylic_thickness(),0])
          rotate ([0,0,90]) {
            ledge();
            rotate ([0,0,90])
              fillet (1.5,box_depth());
          }

        // second "ledge"
        translate ([elec_corner_size()-elec_corner_ledge_thickness()-acrylic_thickness(),-elec_corner_ledge_width()-elec_corner_size(),0]) {
          ledge();
          translate ([0,elec_corner_ledge_width(),0])
            rotate ([0,0,180])
            fillet (1.5,box_depth());
        }
      }
    }

  module ledge() {
    translate ([elec_corner_ledge_thickness()/2,elec_corner_ledge_width()/2,box_depth()/2])
      difference() {
        translate ([-elec_corner_ledge_thickness()/2,-elec_corner_ledge_width()/2,-box_depth()/2])
          cube ([elec_corner_ledge_thickness(),elec_corner_ledge_width(),box_depth()]);

        mirror_z() {
          translate ([-box_depth()/2,0,(box_depth()/2-15)])
            rotate ([0,90,0])
            cylinder(200,elec_corner_holesize()/2,elec_corner_holesize()/2);
        }
      }
  }
}

module electronics_box_corner_hole(){
  rotate ([90,270,0])
    translate ([elec_corner_size()+elec_corner_ledge_width()-(elec_corner_ledge_width()-10),elec_corner_size()+elec_corner_ledge_width()-(elec_corner_ledge_width()-10),-box_depth()]) {
      translate ([-5,-5,-box_depth()/2])
        cylinder(h=box_depth()*2, d=elec_corner_holesize(), center=false);
        }
}

demo() {
  #electronics_box_corner();
  *electronics_box_corner_hole();
  translate ([105,0,145]) rotate ([-90,90,0]) import("/home/dan/Documents/GitHub/parts-1/STL/ModifiedEBoxCorner.stl");

}
