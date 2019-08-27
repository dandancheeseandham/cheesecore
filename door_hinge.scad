// vim: set nospell:
include <config.scad>
include <nopscadlib/core.scad>
use <lib/holes.scad>
use <lib/mirror.scad>
use <screwholes.scad>

front_panel_doors_hinge(screw_distance = 86.25 ,acrylic_depth=5,screw_type=3); // ZL, 5mm acrylic
*front_panel_doors_hinge(screw_distance = 107.5 ,acrylic_depth=6,screw_type=3); // ZLTm 6mm acrylic

module front_panel_doors_hinge(screw_distance,acrylic_depth,screw_type)
{

rounding=1.5;
//consts
hinge_arms_y = 14.75 ; // y size of arms
door_hinge_x = 15 ;  // Part to bolt to panel X
middle_hinge_z = 70 ;  // raised section z

hole_distance_from_edge = 7.5 ;
door_hinge_y = screw_distance + (hole_distance_from_edge * 2) ;

door_hinge_z = 5.25 + (acrylic_depth-5)*2 ;  

hinge_arms_x = 8.25 ;  //additional size for hinge arm 
hinge_arms_z = 9.5 + (acrylic_depth-5)*2 ; 

holeY = hinge_arms_x + 9.75 ;
holeZ = hinge_arms_z - 3.63  ;

extension = 5 ;

// door_hinge_y = 122;  //ZLT
// hinge_arms_x=8;  //additional size for hinge arm // ZLT


*import("railcorestls/lostapathy/zlt hinge 5mm fixed 2.stl");
*translate ([-12.625,352,-6.25]) import("railcorestls/lostapathy/doors/railcore-hinge-panelside.stl");
*translate ([-door_hinge_x/2-hinge_arms_x/2,-door_hinge_y/2,0]) cube ([door_hinge_x ,door_hinge_y,door_hinge_z]); //for measurement

translate ([-door_hinge_x/2-hinge_arms_x/2,-door_hinge_y/2,0])
difference()
{
union()
{

roundedCube([door_hinge_x, door_hinge_y, door_hinge_z], r=rounding, x=true, y=true, z=true);


translate ([0,door_hinge_y/2-middle_hinge_z/2,0]) roundedCube([door_hinge_x + extension,middle_hinge_z,hinge_arms_z], r=rounding, x=true, y=true, z=true);
translate ([door_hinge_x-door_hinge_z,door_hinge_y/2-middle_hinge_z/2,0]) roundedCube([hinge_arms_x+door_hinge_z+ extension,hinge_arms_y,hinge_arms_z], r=rounding, x=true, y=true, z=true);

translate ([door_hinge_x-door_hinge_z,door_hinge_y/2+middle_hinge_z/2-hinge_arms_y,0]) roundedCube([hinge_arms_x+door_hinge_z+ extension,hinge_arms_y,hinge_arms_z], r=rounding, x=true, y=true, z=true);
}

// screwholes for panels
translate ([door_hinge_x/2,hole_distance_from_edge,0]) screwholes(row_distance=screw_distance,numberofscrewholes=2,Mscrew=screw_type,screwhole_increase=0.25);

//screwholes for panels2
translate ([door_hinge_x/2,hole_distance_from_edge,60-hinge_arms_x + 5.25 ]) screwholes(row_distance=screw_distance,numberofscrewholes=2,Mscrew=screw_type,screwhole_increase=2.75);

//screwhole for hinge
translate ([holeY+ extension,50,holeZ]) rotate ([90,0,0]) singlescrewhole(3,0.25);
}

}

/*
	roundedCube() v1.0.3 by robert@cosmicrealms.com from https://github.com/Sembiance/openscad-modules
	Allows you to round any edge of a cube
    
    License: The Unlicense

    A license with no conditions whatsoever which dedicates works to the public domain. Unlicensed works, modifications, and larger works may be distributed under different terms and without source code.
	
	Usage
	=====
	Prototype: roundedCube(dim, r, x, y, z, xcorners, ycorners, zcorners, $fn)
	Arguments:
		-      dim = Array of x,y,z numbers representing cube size
		-        r = Radius of corners. Default: 1
		-        x = Round the corners along the X axis of the cube. Default: false
		-        y = Round the corners along the Y axis of the cube. Default: false
		-        z = Round the corners along the Z axis of the cube. Default: true
		- xcorners = Array of 4 booleans, one for each X side of the cube, if true then round that side. Default: [true, true, true, true]
		- ycorners = Array of 4 booleans, one for each Y side of the cube, if true then round that side. Default: [true, true, true, true]
		- zcorners = Array of 4 booleans, one for each Z side of the cube, if true then round that side. Default: [true, true, true, true]
		-       rx = Radius of the x corners. Default: [r, r, r, r]
		-       ry = Radius of the y corners. Default: [r, r, r, r]
		-       rz = Radius of the z corners. Default: [r, r, r, r]
		-   center = Whether to render the cube centered or not. Default: false
		-      $fn = How smooth you want the rounding to be. Default: 128

	Change Log
	==========
	2018-08-21: v1.0.3 - Added ability to set the radius of each corner individually with vectors: rx, ry, rz
	2017-05-15: v1.0.2 - Fixed bugs relating to rounding corners on the X axis
	2017-04-22: v1.0.1 - Added center option
	2017-01-04: v1.0.0 - Initial Release

	Thanks to Sergio Vilches for the initial code inspiration
*/

// Example code:

/*cube([5, 10, 4]);

translate([8, 0, 0]) { roundedCube([5, 10, 4], r=1); }
translate([16, 0, 0]) { roundedCube([5, 10, 4], r=1, zcorners=[true, false, true, false]); }

translate([24, 0, 0]) { roundedCube([5, 10, 4], r=1, y=true, z=false); }
translate([32, 0, 0]) { roundedCube([5, 10, 4], r=1, x=true, z=false); }
translate([40, 0, 0]) { roundedCube([5, 10, 4], r=1, x=true, y=true, z=true); }
*/



module roundedCube(dim, r=1, x=false, y=false, z=true, xcorners=[true,true,true,true], ycorners=[true,true,true,true], zcorners=[true,true,true,true], center=false, rx=[undef, undef, undef, undef], ry=[undef, undef, undef, undef], rz=[undef, undef, undef, undef], $fn=128)
{
	translate([(center==true ? (-(dim[0]/2)) : 0), (center==true ? (-(dim[1]/2)) : 0), (center==true ? (-(dim[2]/2)) : 0)])
	{
		difference()
		{
			cube(dim);

			if(z)
			{
				translate([0, 0, -0.1])
				{
					if(zcorners[0])
						translate([0, dim[1]-(rz[0]==undef ? r : rz[0])]) { rotateAround([0, 0, 90], [(rz[0]==undef ? r : rz[0])/2, (rz[0]==undef ? r : rz[0])/2, 0]) { meniscus(h=dim[2], r=(rz[0]==undef ? r : rz[0]), fn=$fn); } }
					if(zcorners[1])
						translate([dim[0]-(rz[1]==undef ? r : rz[1]), dim[1]-(rz[1]==undef ? r : rz[1])]) { meniscus(h=dim[2], r=(rz[1]==undef ? r : rz[1]), fn=$fn); }
					if(zcorners[2])
						translate([dim[0]-(rz[2]==undef ? r : rz[2]), 0]) { rotateAround([0, 0, -90], [(rz[2]==undef ? r : rz[2])/2, (rz[2]==undef ? r : rz[2])/2, 0]) { meniscus(h=dim[2], r=(rz[2]==undef ? r : rz[2]), fn=$fn); } }
					if(zcorners[3])
						rotateAround([0, 0, -180], [(rz[3]==undef ? r : rz[3])/2, (rz[3]==undef ? r : rz[3])/2, 0]) { meniscus(h=dim[2], r=(rz[3]==undef ? r : rz[3]), fn=$fn); }
				}
			}

			if(y)
			{
				translate([0, -0.1, 0])
				{
					if(ycorners[0])
						translate([0, 0, dim[2]-(ry[0]==undef ? r : ry[0])]) { rotateAround([0, 180, 0], [(ry[0]==undef ? r : ry[0])/2, 0, (ry[0]==undef ? r : ry[0])/2]) { rotateAround([-90, 0, 0], [0, (ry[0]==undef ? r : ry[0])/2, (ry[0]==undef ? r : ry[0])/2]) { meniscus(h=dim[1], r=(ry[0]==undef ? r : ry[0])); } } }
					if(ycorners[1])
						translate([dim[0]-(ry[1]==undef ? r : ry[1]), 0, dim[2]-(ry[1]==undef ? r : ry[1])]) { rotateAround([0, -90, 0], [(ry[1]==undef ? r : ry[1])/2, 0, (ry[1]==undef ? r : ry[1])/2]) { rotateAround([-90, 0, 0], [0, (ry[1]==undef ? r : ry[1])/2, (ry[1]==undef ? r : ry[1])/2]) { meniscus(h=dim[1], r=(ry[1]==undef ? r : ry[1])); } } }
					if(ycorners[2])
						translate([dim[0]-(ry[2]==undef ? r : ry[2]), 0]) { rotateAround([-90, 0, 0], [0, (ry[2]==undef ? r : ry[2])/2, (ry[2]==undef ? r : ry[2])/2]) { meniscus(h=dim[1], r=(ry[2]==undef ? r : ry[2])); } }
					if(ycorners[3])
						rotateAround([0, 90, 0], [(ry[3]==undef ? r : ry[3])/2, 0, (ry[3]==undef ? r : ry[3])/2]) { rotateAround([-90, 0, 0], [0, (ry[3]==undef ? r : ry[3])/2, (ry[3]==undef ? r : ry[3])/2]) { meniscus(h=dim[1], r=(ry[3]==undef ? r : ry[3])); } }
				}
			}

			if(x)
			{
				translate([-0.1, 0, 0])
				{
					if(xcorners[0])
						translate([0, dim[1]-(rx[0]==undef ? r : rx[0])]) { rotateAround([0, 90, 0], [(rx[0]==undef ? r : rx[0])/2, 0, (rx[0]==undef ? r : rx[0])/2]) { meniscus(h=dim[0], r=(rx[0]==undef ? r : rx[0])); } }
					if(xcorners[1])
						translate([0, dim[1]-(rx[1]==undef ? r : rx[1]), dim[2]-(rx[1]==undef ? r : rx[1])]) { rotateAround([90, 0, 0], [0, (rx[1]==undef ? r : rx[1])/2, (rx[1]==undef ? r : rx[1])/2]) { rotateAround([0, 90, 0], [(rx[1]==undef ? r : rx[1])/2, 0, (rx[1]==undef ? r : rx[1])/2]) { meniscus(h=dim[0], r=(rx[1]==undef ? r : rx[1])); } } }
					if(xcorners[2])
						translate([0, 0, dim[2]-(rx[2]==undef ? r : rx[2])]) { rotateAround([180, 0, 0], [0, (rx[2]==undef ? r : rx[2])/2, (rx[2]==undef ? r : rx[2])/2]) { rotateAround([0, 90, 0], [(rx[2]==undef ? r : rx[2])/2, 0, (rx[2]==undef ? r : rx[2])/2]) { meniscus(h=dim[0], r=(rx[2]==undef ? r : rx[2])); } } }
					if(xcorners[3])
						rotateAround([-90, 0, 0], [0, (rx[3]==undef ? r : rx[3])/2, (rx[3]==undef ? r : rx[3])/2]) { rotateAround([0, 90, 0], [(rx[3]==undef ? r : rx[3])/2, 0, (rx[3]==undef ? r : rx[3])/2]) { meniscus(h=dim[0], r=(rx[3]==undef ? r : rx[3])); } }
				}
			}
		}
	}
}

module meniscus(h, r, fn=128)
{
	$fn=fn;

	difference()
	{
		cube([r+0.2, r+0.2, h+0.2]);
		translate([0, 0, -0.1]) { cylinder(h=h+0.4, r=r); }
	}
}

module rotateAround(a, v) { translate(v) { rotate(a) { translate(-v) { children(); } } } }
