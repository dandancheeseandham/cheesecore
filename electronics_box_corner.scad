// vim: set nospell:
use <config.scad>
use <screwholes.scad>
include <nopscadlib/core.scad>
use <lib/holes.scad>
use <lib/mirror.scad>

// import("./railcorestls/Electronics_Box_Corner.stl");

cornersize = 15;
acrylicdepth = 6.6 ;
height = 64 ;
ledgewidth = 10 ;
ledgethickness = 4 ; 

translate ([cornersize+ledgewidth,cornersize+ledgewidth,0])
union()
{

difference ()
{
 cylinder(h=height, r1=cornersize, r2=cornersize, center=false);
     translate ([-5,-5,0])    cylinder(h=84, r1=1.5, r2=1.5, center=false);
}
	 
 // top left cube
 translate ([-cornersize,0,0]) cube ([cornersize,cornersize,height]);
 
 //bottom right cube
 translate ([0,-cornersize,0]) cube ([cornersize,cornersize,height]);
 
// ledge
 translate ([11-acrylicdepth,-25,0]) cube ([ledgethickness,ledgewidth,height]);
// ledge 
 translate ([-cornersize-ledgewidth,cornersize-ledgethickness-acrylicdepth,0]) cube ([ledgewidth,ledgethickness,64]);
 } 

  
