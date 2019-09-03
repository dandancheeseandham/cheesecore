// vim: set nospell:
use <config.scad>
use <screwholes.scad>
include <nopscadlib/core.scad>
use <lib/holes.scad>
use <lib/mirror.scad>

// electronics_box_corner(cornersize = 15, acrylicdepth = 6.6 ,height = 60, ledgewidth = 10 , ledgethickness = 4); // standard box
electronics_box_corner(cornersize = 15, acrylicdepth = 6,height = 60, ledgewidth = 10 , ledgethickness = 4, holesize = 3.5);

module electronics_box_corner(cornersize, acrylicdepth ,height, ledgewidth , ledgethickness, holesize)
{
rotate ([90,270,0])
translate ([cornersize+ledgewidth-(ledgewidth-10),cornersize+ledgewidth-(ledgewidth-10),-height])
union()
{
	difference ()
	{
		cylinder(h=height, r1=cornersize, r2=cornersize, center=false);
		translate ([-5,-5,-height/2])    cylinder(h=height*2, r1=holesize/2, r2=holesize/2, center=false);
	}
	 
	// top left cube
	translate ([-cornersize,0,0]) cube ([cornersize,cornersize,height]);
	//bottom right cube
	translate ([0,-cornersize,0]) cube ([cornersize,cornersize,height]);
	// first "ledge"
	translate ([-cornersize,cornersize-ledgethickness-acrylicdepth,0]) rotate ([0,0,90]) ledge();
	// second "ledge" 
	translate ([cornersize-ledgethickness-acrylicdepth,-ledgewidth-cornersize,0])  ledge();
} 

module ledge()
{
	translate ([ledgethickness/2,ledgewidth/2,height/2])
	difference()
	{
		translate ([-ledgethickness/2,-ledgewidth/2,-height/2]) cube ([ledgethickness,ledgewidth,height]);
		mirror_z()
		{
		translate ([-height/2,0,(height/2-15)]) rotate ([0,90,0]) cylinder(200,holesize/2,holesize/2);
		}
	}
}
}