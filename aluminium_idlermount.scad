// Initially based onSimple-idler-FRONT-R1.DXF

// vim: set nospell:
include <config.scad>
//include <core.scad>
include <lib.scad>
include <screwholes.scad>
* translate ([0,0,-4])  projection (cut=true) rotate ([0,180,0]) mirror ([0,1,0]) linear_extrude(height = 6.35, center = true, convexity = 10) import (file = "railcorestls/Simple-idler-FRONT-R1.DXF", convexity=1);

// Origin is at the inside corner where the extrusions meet under the mount
module aluminium_idler_mount() 
{
extrusion_screwholes_x = 48.52 ;
extrusion_screwholes_y = 49.2 ;
extrusion_adjust_x= 71 ;
extrusion_adjust_y= 9.5 ;
extrusion_screwhole_spacing = 4 ;
idler_height = 6 ;  // height of part in mm
screwsize= 3 ;
NEMAscrew = 3 ;
main_body_size_x = 57 ;
main_body_size_y= 57 ;
rounding= 3 ;
nubbin_size_x = 24 ;
nubbin_size_y = 12 ;
  
// FIXME: this sets a nice x/y for placement, but would probably be better if we modeled it in that position from the start
  
translate([-extrusion_screwholes_x - extrusion/2 + 1, -extrusion+1, 0])
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
				translate ([main_body_size_x-rounding,rounding,0]) cube([nubbin_size_x-rounding,nubbin_size_y-rounding,  idler_height/2]);
				}
			cylinder(r=rounding,h=idler_height/2);
			}
		translate ([main_body_size_x,nubbin_size_y+rounding,0]) fillet(rounding,   idler_height); 
		}
	translate ([7,18,-idler_height]) cylinder(h=15, r1=3/2, r2=3/2, center=false);  //far pulley screwhole - this needs to be tapped/drilled?
	translate ([23.6,33,-idler_height]) cylinder(h=15, r1=3/2, r2=3/2, center=false); // near pulley screwhole
	translate ([-25,0,-idler_height])  rotate ([0,0,45])  cube ([100,30,20]);
	translate ([extrusion_adjust_x,extrusion_adjust_y-extrusion_screwhole_spacing,-2])  rotate ([0,0,90]) longscrewhole(screwhole_length=extrusion_screwhole_spacing, Mscrew=NEMAscrew,screwhole_increase=0.1);  // horizontal adjustment hole
	translate ([extrusion_screwholes_x,extrusion_screwholes_y-30,0]) screwholes(row_distance=30,numberofscrewholes=3,Mscrew=screwsize,screwhole_increase=0.1) ; //line of screwholes
	}
}

aluminium_idler_mount();
