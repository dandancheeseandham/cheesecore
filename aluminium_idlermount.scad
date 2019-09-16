// Initially based onSimple-idler-FRONT-R1.DXF

// vim: set nospell:
include <config.scad>
//include <core.scad>
include <nopscadlib/lib.scad>
use <screwholes.scad>
use <demo.scad>

* translate ([0,0,-4])  projection (cut=true) rotate ([0,180,0]) mirror ([0,1,0]) linear_extrude(height = 6.35, center = true, convexity = 10) import (file = "railcorestls/Simple-idler-FRONT-R1.DXF", convexity=1);

// Origin is at the inside corner where the extrusions meet under the mount
module aluminium_idler_mount() {
  //Idler definitions
  idler_height = 6 ;  // height of part in mm
  screwhole_M = 5 ; // size for screwholes
  tap_hole = 2 ; // size of hole for shouldbolts
  rounding= 3 ;

  // size of main square of body
  main_body_size_x = 27 ;
  main_body_size_y= 50 ;
  
  // size of little extension for adjustment hole
  adjustment_hole_size_x = 24 ;
  adjustment_hole_size_y = 12 ;
  move_holes_by = 10 ;
  
  // row of screwholes XY
  extrusion_screwholes_line_length = 30 ;
  lengthen_extrusion_screwhole = 3.75 ;
 
  GT_gap = 12.78 ;
  pulley_clearance = 17 ; 
  
  x_to_first_pulley = 7  ;
  x_to_second_pulley = x_to_first_pulley + GT_gap ;
  
  // FIXME: this sets a nice x/y for placement, but would probably be better if we modeled it in that position from the start
    translate([-extrusion_width($extrusion_type), -extrusion_width($extrusion_type), 0])
    color(alum_part_color()) {
      difference ()
      {
        minkowski()
        {
          translate ([rounding,rounding,0]) cube([main_body_size_x+(extrusion_width($extrusion_type)-rounding), main_body_size_y+extrusion_width($extrusion_type)-rounding, idler_height/2]);
          cylinder(r=rounding,h=idler_height/2);
        }
        	translate ([x_to_first_pulley + extrusion_width($extrusion_type),x_to_first_pulley + extrusion_width($extrusion_type),-idler_height]) cylinder(h=115, r1=tap_hole/2, r2=tap_hole/2, center=false);  //far pulley screwhole - this needs to be tapped/drilled?
          translate ([x_to_first_pulley+extrusion_width($extrusion_type)+pulley_clearance,x_to_second_pulley + extrusion_width($extrusion_type),-idler_height]) cylinder(h=115, r1=tap_hole/2, r2=tap_hole/2, center=false); // near pulley screwhole
        
        translate ([extrusion_width($extrusion_type)+move_holes_by,extrusion_width($extrusion_type)/2-lengthen_extrusion_screwhole/2,-2])  rotate ([0,0,90]) longscrewhole(screwhole_length=extrusion_width($extrusion_type)/lengthen_extrusion_screwhole, Mscrew=screwhole_M,screwhole_increase=0.1);  // horizontal adjustment hole
        translate ([extrusion_width($extrusion_type)/2,extrusion_width($extrusion_type)+move_holes_by,0]) screwholes(row_distance=extrusion_screwholes_line_length,numberofscrewholes=3,Mscrew=screwhole_M,screwhole_increase=0.1) ; //line of screwholes
      }
    }
}

demo() {
  aluminium_idler_mount();
}