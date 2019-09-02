// vim: set nospell:
use <config.scad>
use <screwholes.scad>
include <nopscadlib/core.scad>
use <lib/holes.scad>
use <lib/mirror.scad>

*electronics_box (box_size_y = 298.9, box_size_z = 238.9, box_depth = 59, acrylic_thickness = 6); // ZL
*electronics_box (box_size_y = 298.9, box_size_z = 438.9, box_depth = 59, acrylic_thickness = 6); // ZLT
electronics_box (box_size_y = 300, box_size_z = 240, box_depth = 59, acrylic_thickness = 6); // New ZL

module electronics_box(box_size_z,box_size_y, box_depth, acrylic_thickness) 
{
cover_corner_adjust = 28 ;  // rounded corners for cover, to match the printed corners.
move_panels = 48.5 ;  // move the panels by this
move_corners = 9.5 ;  // move the corners by this
panelcornerrounding = 14 ; // rounding acrylic cover to match the corners

// 4 electronics box corners
mirror_xz() 
	{
	translate ([-box_size_y/2+move_corners,-box_depth,box_size_z/2+-move_corners]) 
	elec_corner();  //electronics box corners
    }

// top panel
translate ([-box_size_y/2, -box_depth, box_size_z/2 + move_panels/2]) 
make_panel(box_size_y, box_depth, stepper_cables = true, IEC = false);  

// side panel with IEC cutout
translate ([box_size_y/2 + move_panels/2, -box_depth, box_size_z/2]) 
rotate ([0,90,0]) 
make_panel (box_size_z,box_depth,stepper_cables = false, IEC = true);  

// bottom panel
translate ([-box_size_y/2,-box_depth,-box_size_z/2 - move_panels/2 - acrylic_thickness]) 
make_panel(box_size_y,box_depth,stepper_cables = false); 

// side panel
translate ([-box_size_y/2 - move_panels/2 - acrylic_thickness, -box_depth, box_size_z/2])  
rotate ([0,90,0]) 
make_panel (box_size_z,box_depth,stepper_cables = false, IEC = false);  

// transparent cover
translate ([0, -box_depth, 0])
rotate ([90,0,0]) 
%electronics_cover_panel(box_size_y+cover_corner_adjust*2, box_size_z+cover_corner_adjust*2, acrylic_thickness, panelcornerrounding);


module make_panel(length,electronicscabinet_box_depth,stepper_cables,IEC) 
{
topscrewhole_x = 4.5 ;
topscrewhole_y = 14.5 ;
IEC_cutout_distance=20; // hole starts at this distance from bottom of panel
cut_out_width=57;  
cut_out_depth=28.5; 

color(acrylic_color())
	{
		difference()
		{
			cube ([length,electronicscabinet_box_depth,acrylic_thickness]);
			translate ([length/2,box_depth/2,0]) 
			mirror_xy() 
			{
				translate ([length/2-topscrewhole_x,topscrewhole_y,0]) singlescrewhole(3,0.5);
			}
			if (stepper_cables) {
			translate ([length/2,0,0]) 
			mirror_x() 
			{
				translate ([length/2-19.07,box_depth,-15]) cylinder(h=30, r1=7.5, r2=7.5, center=false); 
			}
			}
			if (IEC == true){		
		    translate ([length-IEC_cutout_distance-cut_out_width,15.25,0]) cube ([cut_out_width,cut_out_depth,acrylic_thickness]);
			translate ([length-IEC_cutout_distance-cut_out_width/2,9.65,0]) screwholes(row_distance=39.7,numberofscrewholes=2,Mscrew=3,screwhole_increase=0.5);
			}
			
		}
	}
}


module electronics_cover_panel(x, y, thickness, panelcornerrounding)
{
	difference() 
	{
		color(acrylic2_color())
		{
		translate ([0, 0, thickness/2])
		rounded_rectangle([x+thickness/2, y+thickness/2, thickness],panelcornerrounding);
		}
	}
}

module elec_corner()
{
color(printed_part_color()) {
    rotate ([90,0,180]) import("./railcorestls/Electronics_Box_Corner.stl");
}
}
}
