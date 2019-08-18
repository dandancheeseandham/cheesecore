// vim: set nospell:
include <config.scad>
include <opencoreparts.scad>
include <core.scad>
include <screwholes.scad>

electronicscabinet_depth=59;


module electronics_side_panel(length) {

difference()
{
cube ([length,electronicscabinet_depth,6]);
translate ([4.5,14.5,0]) screwholes(row_distance=30,numberofscrewholes=2,Mscrew=3,screwhole_increase=0.5);
translate ([length-4.5,14.5,0]) screwholes(row_distance=30,numberofscrewholes=2,Mscrew=3,screwhole_increase=0.5);
}
}

module electronics_electro_panel(length) {

distancefrombottom=20;
sizeofholeX=57;
sizeofholeY=28.5;

difference()
{
cube ([length,electronicscabinet_depth,6]);
translate ([length-distancefrombottom-sizeofholeX,15.25,0]) cube ([sizeofholeX,sizeofholeY,6]);
translate ([length-distancefrombottom-sizeofholeX/2,9.65,0]) screwholes(row_distance=39.7,numberofscrewholes=2,Mscrew=3,screwhole_increase=0.5);
translate ([4.5,14.5,0]) screwholes(row_distance=30,numberofscrewholes=2,Mscrew=3,screwhole_increase=0.5);
translate ([length-4.5,14.5,0]) screwholes(row_distance=30,numberofscrewholes=2,Mscrew=3,screwhole_increase=0.5);
}
}

module electronics_top_panel(length) {

difference()
{
cube ([length,electronicscabinet_depth,6]);
translate ([4.5,14.5,0]) screwholes(row_distance=30,numberofscrewholes=2,Mscrew=3,screwhole_increase=0.5);
translate ([length-4.5,14.5,0]) screwholes(row_distance=30,numberofscrewholes=2,Mscrew=3,screwhole_increase=0.5);
translate ([length-19.07,electronicscabinet_depth-61.5,0]) rotate ([0,0,90]) screwholes(row_distance=260.76,numberofscrewholes=2,Mscrew=7.5*2,screwhole_increase=0);
}
}

module electronics_bottom_panel(length) {

difference()
{
cube ([length,electronicscabinet_depth,6]);
translate ([4.5,14.5,0]) screwholes(row_distance=30,numberofscrewholes=2,Mscrew=3,screwhole_increase=0.5);
translate ([length-4.5,14.5,0]) screwholes(row_distance=30,numberofscrewholes=2,Mscrew=3,screwhole_increase=0.5);
}
}



// electronics_side_panel(438.9);  //ZLT size
rotate ([0,90,0]) electronics_electro_panel(238.9);  //ZL size
translate ([298.9,0,0]) rotate ([0,90,0]) electronics_side_panel(238.9);  //ZL size
electronics_top_panel(298.9);  //ZL size
translate ([0,0,-238.9]) electronics_bottom_panel(298.9);  //ZL size

