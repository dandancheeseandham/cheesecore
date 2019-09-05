// Initially based onSimple-idler-FRONT-R1.DXF

// vim: set nospell:
include <config.scad>
//include <core.scad>
include <nopscadlib/lib.scad>
use <screwholes.scad>


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
main_body_size_x = 57 ;
main_body_size_y= 57 ;
// size of little extension for adjustment hole
adjustment_hole_size_x = 24 ;
adjustment_hole_size_y = 12 ;

// row of screwholes XY
extrusion_screwholes_x = 48.52 ;
extrusion_screwholes_y = 49.2 ;

//XY coordinates of the lengthened hole that adjusts the position
extrusion_adjust_x= 71 ;
extrusion_adjust_y= 9.5 ;
lengthen_extrusion_screwhole = 4 ;
    





  
// FIXME: this sets a nice x/y for placement, but would probably be better if we modeled it in that position from the start
  
translate([-extrusion_screwholes_x - extrusion_width($extrusion_type)/2 + 1, -extrusion_width($extrusion_type)+1, 0])
color("#777") 
//render() // call render here to get artifacts out of larger model - DAN: Are there artifacts?
difference () 
	{
	union () 
		{
		minkowski() 
			{
			union () 
				{
				translate ([0,rounding,0]) cube([main_body_size_x-rounding, main_body_size_y-rounding, idler_height/2]);
				translate ([main_body_size_x-rounding,rounding,0]) cube([adjustment_hole_size_x-rounding,adjustment_hole_size_y-rounding,  idler_height/2]);
				}
			cylinder(r=rounding,h=idler_height/2);
			}
		translate ([main_body_size_x,adjustment_hole_size_y+rounding,0]) fillet(rounding,   idler_height); 
		}
	translate ([7,21,-idler_height]) cylinder(h=15, r1=tap_hole/2, r2=tap_hole/2, center=false);  //far pulley screwhole - this needs to be tapped/drilled?
	translate ([23.6,50,-idler_height]) cylinder(h=15, r1=tap_hole/2, r2=tap_hole/2, center=false); // near pulley screwhole
	translate ([-25,0,-idler_height])  rotate ([0,0,45])  cube ([100,30,20]); // removal of edge of square
	
	translate ([extrusion_adjust_x,extrusion_adjust_y-lengthen_extrusion_screwhole,-2])  rotate ([0,0,90]) longscrewhole(screwhole_length=lengthen_extrusion_screwhole, Mscrew=screwhole_M,screwhole_increase=0.1);  // horizontal adjustment hole
	translate ([extrusion_screwholes_x,extrusion_screwholes_y-30,0]) screwholes(row_distance=30,numberofscrewholes=3,Mscrew=screwhole_M,screwhole_increase=0.1) ; //line of screwholes 
	}
}

aluminium_idler_mount();
