// Initially based onSimple-idler-FRONT-R1.DXF

// vim: set nospell:
include <config.scad>
//include <core.scad>
include <nopscadlib/lib.scad>
use <screwholes.scad>
use <demo.scad>

* translate ([0,0,-4])  projection (cut=true) rotate ([0,180,0]) mirror ([0,1,0]) linear_extrude(height = 6.35, center = true, convexity = 10) import (file = "railcorestls/Simple-idler-FRONT-R1.DXF", convexity=1);

// Origin is at the inside corner where the extrusions meet under the mount
module aluminium_idler_mount()
{

  //Idler definitions
  idler_height = 6 ;  // height of part in mm
  screwhole_M = 3 ; // size for screwholes
  tap_hole = 2 ; // size of hole for shouldbolts
  rounding= 3 ;

  // size of main square of body
  main_body_size_x = 39-15 ;
  main_body_size_y= 53-15 ;
  // size of little extension for adjustment hole
  adjustment_hole_size_x = 24 ;
  adjustment_hole_size_y = 12 ;

  // row of screwholes XY
  extrusion_screwholes_x = 48.52 - 15 ;
  extrusion_screwholes_y = 49.2 -15 ;
  extrusion_screwholes_line_length = 30 ;


  //XY coordinates of the lengthened hole that adjusts the position
  extrusion_adjust_x= 71 ;
  extrusion_adjust_y= 2.5 ;
  lengthen_extrusion_screwhole = 4 ;



  // FIXME: this sets a nice x/y for placement, but would probably be better if we modeled it in that position from the start
  translate([-main_body_size_x -  extrusion_width($extrusion_type) * 1.5, -extrusion_width($extrusion_type), 0])
    color(alum_part_color()) {
      difference ()
      {
        #minkowski()
        {
          #translate ([44,rounding,0]) cube([main_body_size_x-rounding+(extrusion_width($extrusion_type)), main_body_size_y-rounding+extrusion_width($extrusion_type), idler_height/2]);
          cylinder(r=rounding,h=idler_height/2);
        }
        translate ([extrusion_adjust_x,extrusion_adjust_y+extrusion_width($extrusion_type)/2-lengthen_extrusion_screwhole,-2])  rotate ([0,0,90]) longscrewhole(screwhole_length=lengthen_extrusion_screwhole, Mscrew=screwhole_M,screwhole_increase=0.1);  // horizontal adjustment hole
        translate ([extrusion_screwholes_x+extrusion_width($extrusion_type),extrusion_screwholes_y-extrusion_screwholes_line_length+extrusion_width($extrusion_type),0]) screwholes(row_distance=extrusion_screwholes_line_length,numberofscrewholes=screwhole_M,Mscrew=screwhole_M,screwhole_increase=0.1) ; //line of screwholes
      }
    }
}

demo() {
  aluminium_idler_mount();
}