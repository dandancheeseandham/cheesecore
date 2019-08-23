// vim: set nospell:
use <config.scad>
use <nopscadlib/core.scad>
use <screwholes.scad>




*electronics_box (305,250);
electronics_box (298.9,238.9); // ZL
*electronics_box (298.9,438.9); // ZLT
*electronics_box (300,240); // New ZL

module electronics_box(box_size_y,box_size_z) {
//semi-constants for playing with
depth=59; //FIXME
material_thickness=6; //FIXME: Not parametric to material thickness
    
left=-box_size_y/2;
up=box_size_z/2;
right=box_size_y/2;
down=-box_size_z/2;

translate ([left+10,-depth,up-30]) elec_corner();  //top left corner
translate ([right-10.5,-depth,up-30]) rotate ([0,90,0]) elec_corner(); //top right corner
translate ([left+10.5,-depth,down-10]) rotate ([0,270,0]) elec_corner(); //bottom left corner
translate ([right-10,-depth,down-10]) rotate ([0,180,0]) elec_corner();  //bottom right corner


    
translate ([left,0,up+material_thickness*1.5]) rotate ([180,0,0]) electronics_top_panel(box_size_y,depth);  //top panel
translate ([right+23,-depth,up-20]) rotate ([0,90,0]) electronics_electro_panel(box_size_z,depth);  //electronics PSU panel
translate ([left,-depth,down-50]) electronics_bottom_panel(box_size_y,depth); // bottom panel
translate ([left-29,-depth,up-20])  rotate ([0,90,0]) electronics_side_panel(box_size_z,depth);  // left panel






module electronics_side_panel(length,electronicscabinet_depth) {
color("#555")
difference()
{
cube ([length,electronicscabinet_depth,material_thickness]);
translate ([4.5,14.5,0]) screwholes(row_distance=30,numberofscrewholes=2,Mscrew=3,screwhole_increase=0.5);
translate ([length-4.5,14.5,0]) screwholes(row_distance=30,numberofscrewholes=2,Mscrew=3,screwhole_increase=0.5);
}
}


module electronics_electro_panel(length,electronicscabinet_depth) {

distancefrombottom=20;
sizeofholeX=57;
sizeofholeY=28.5;
color("#555")
difference()
{
cube ([length,electronicscabinet_depth,material_thickness]);
translate ([length-distancefrombottom-sizeofholeX,15.25,0]) cube ([sizeofholeX,sizeofholeY,material_thickness]);
translate ([length-distancefrombottom-sizeofholeX/2,9.65,0]) screwholes(row_distance=39.7,numberofscrewholes=2,Mscrew=3,screwhole_increase=0.5);
translate ([4.5,14.5,0]) screwholes(row_distance=30,numberofscrewholes=2,Mscrew=3,screwhole_increase=0.5);
translate ([length-4.5,14.5,0]) screwholes(row_distance=30,numberofscrewholes=2,Mscrew=3,screwhole_increase=0.5);
}
}

module electronics_top_panel(length,electronicscabinet_depth) {

thingy=4.5;
otherthing=14.5;
    
color("#555")
difference()
{
cube ([length,electronicscabinet_depth,material_thickness]);
translate ([thingy,otherthing,0]) screwholes(row_distance=30,numberofscrewholes=2,Mscrew=3,screwhole_increase=0.5);
translate ([length-thingy,otherthing,0]) screwholes(row_distance=30,numberofscrewholes=2,Mscrew=3,screwhole_increase=0.5);
translate ([length-19.07,electronicscabinet_depth-61.5,0]) rotate ([0,0,90]) screwholes(row_distance=260.76,numberofscrewholes=2,Mscrew=7.5*2,screwhole_increase=0);  //holes for motor wires
}
}

module electronics_bottom_panel(length,electronicscabinet_depth) {
color("#555")
difference()
{
cube ([length,electronicscabinet_depth,material_thickness]);
translate ([4.5,14.5,0]) screwholes(row_distance=30,numberofscrewholes=2,Mscrew=3,screwhole_increase=0.5);
translate ([length-4.5,14.5,0]) screwholes(row_distance=30,numberofscrewholes=2,Mscrew=3,screwhole_increase=0.5);
}
}


module elec_corner()
{
color("#222")
    rotate ([90,0,180]) import("./railcorestls/Electronics_Box_Corner.stl");
}
}
