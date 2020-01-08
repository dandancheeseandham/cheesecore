// vim: set nospell:
include <config.scad>
include <nopscadlib/core.scad>
include <nopscadlib/utils/round.scad>
use <lib/holes.scad>
use <lib/layout.scad>
use <screwholes.scad>
use <demo.scad>

demo() {
  // Standard lostapathy ZL hinge for a 5mm acrylic door
  translate([0, 0 ,0])  
    panelside_hinge( $draft = false); 
  translate([0 , 0,  acrylic_door_thickness()])  
    doorside_hinge();
   
  // ZLT 6mm acrylic with doors that need to be 10mm closer to each other (extension = 5mm , on each hinge/door)
  translate ([0,-120,0]) 
    panelside_hinge(screw_distance = 107.5 ,acrylic_door_thickness=6,extension = 5,screw_type=3 , $draft = false); 
  translate ([0,-120,0])  
    doorside_hinge(); 
}

function hole_distance_from_edge() = 7.5 ;
function rounding() = 1.5 ; // rounding() of edges
function hinge_arm_body_y() = 70 ;  // raised section and panel hinge_y
function hinge_arms_x() = 8.75  ;  // size for hinge arm ..
function hinge_arms_y() = 14.75 ; // y size of arms - Standard for hinges
function door_hinge_x()= extrusion_width($extrusion_type) ;   // hinge is the width of the extrusion

module panelside_hinge(screw_distance = 86.25,acrylic_door_thickness=5,extension = 0 ,screw_type =3, $draft = true) {
  door_hinge_y = screw_distance + (hole_distance_from_edge() * 2) ;   // this is so it fits the panels depending on the distance between screws.
  door_hinge_z = 5.25 ;
  //door_hinge_z = 0.25 + acrylic_door_thickness ;   // Used to be parametric: Needs counterbore to work
  hinge_arms_z = 5.82 + acrylic_door_thickness ;
  //hinge_arms_z = 2.82 + acrylic_door_thickness ;  //90 deg

  // origin is top screwhole. Makes placing on panels easier
  color(printed_part_color())
    render() 
      difference() {
        union() {

        // draw main arm
        translate ([-door_hinge_x()/2,-door_hinge_y/2,0 ]) 
          roundedCube([door_hinge_x(), door_hinge_y, door_hinge_z], r=rounding(), x=true, y=true, z=true);
          
        // raised part of hinge to accommodate arms
        translate ([-door_hinge_x()/2,-hinge_arm_body_y()/2,0]) 
          roundedCube([door_hinge_x() + extension,hinge_arm_body_y(),hinge_arms_z], r=rounding(), x=true, y=true, z=true);
          
        // hinge arms. The 10 is an overlap to prevent the join being rounded off.
        mirror_y() 
          translate ([door_hinge_x()/2 - 10 ,hinge_arm_body_y()/2-hinge_arms_y(),0]) 
            roundedCube([extension + hinge_arms_x() + 10 ,hinge_arms_y(),hinge_arms_z], r=rounding(), x=true, y=true, z=true);
      }
      mirror_y() 
        translate ([0,door_hinge_y/2-hole_distance_from_edge(),0])   
          poly_cylinder(1.5, 30);
      translate ([door_hinge_x()/2 + extension + 5,150,acrylic_door_thickness]) 
        rotate ([90,0,0]) 
          poly_cylinder(screw_type/2, 300);
    }
}

module doorside_hinge() {

  panel_hinge_width = 27.5 ;
  panel_hinge_depth = 6.25 ;
  shape_overlap = 15 ;
  
color(printed_part_color())

//panel_hinge_width + hinge_arms_x() + extrusion_width()

 translate ([panel_hinge_width + hinge_arms_x() + extrusion_width(),0,panel_hinge_depth]) rotate ([0,180,0])
 render() difference(){
    union () {     
      // side with larger rounded corners
      difference() {
        translate ([0,-hinge_arm_body_y()/2,0]) 
          roundedCube([panel_hinge_width-5,hinge_arm_body_y(),panel_hinge_depth], r=rounding(), x=true, y=true, z=false,$draft=false);       
            // take a 10mm cube off to corners, to add a 10mm rounded corner
        mirror_y()   
          translate ([-epsilon,-hinge_arm_body_y()/2-epsilon,-epsilon]) 
              cube([10+epsilon,10+epsilon,10]);
          }
          // mid-section
          translate ([shape_overlap,-hinge_arm_body_y()/2,0])
            roundedCube([panel_hinge_width-shape_overlap,hinge_arm_body_y(),panel_hinge_depth], r=rounding(), x=true, y=true, z=true,$draft=false);
          
          // hinge area  
          translate ([panel_hinge_width-shape_overlap,15-hinge_arm_body_y()/2,0]) 
            roundedCube([hinge_arms_x()+shape_overlap,(hinge_arm_body_y()/2-hinge_arms_y())*2-0.5,panel_hinge_depth], r=rounding(), x=true, y=true, z=true,$draft=false);
            // roundedCube([hinge_arms_x()+shape_overlap,(hinge_arm_body_y()/2-hinge_arms_y())*2-0.5,panel_hinge_depth], r=rounding(), x=true, y=true, z=true,$draft=false);  // 90 deg

          // 10mm rounded corners
          mirror_y()   
            translate ([0,0,panel_hinge_depth/2])  
              rotate ([0,0,180]) 
                mirror_z()  
                  translate ([-10,hinge_arm_body_y()/2-10,0]) 
                    rounded_cylinder(r=10, h = panel_hinge_depth/2, r2 = rounding(), ir = 0, angle = 90);
    }
   translate ([6,0,0]) 
    poly_cylinder(1.5, 30);
   mirror_y() 
    translate ([6,25,0]) 
      poly_cylinder(1.5, 30);
    translate ([panel_hinge_width+hinge_arms_x()-3.75,150,2.63]) 
        rotate ([90,0,0]) 
          poly_cylinder(1.38, 300);   
      
  }
}

// everything below here is for creating a rounded cube (or a preview that is just a cube), and can be swapped out with other similar code..

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
-      $fn = How smooth you want the rounding() to be. Default: 128

Change Log
==========
2018-08-21: v1.0.3 - Added ability to set the radius of each corner individually with vectors: rx, ry, rz
2017-05-15: v1.0.2 - Fixed bugs relating to rounding() corners on the X axis
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
if ($draft == true) 
{
  cube(dim);
}
else

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
