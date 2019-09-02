// vim: set nospell:
use <config.scad>
use <screwholes.scad>
include <nopscadlib/core.scad>
use <lib/holes.scad>
use <lib/mirror.scad>
use <lib/fan_grill_difference.scad>
use <electronics_box_corner.scad>

*electronics_box (box_size_y = 298.9, box_size_z = 238.9, box_depth = 59, acrylic_thickness = 6); // ZL
*electronics_box (box_size_y = 298.9, box_size_z = 438.9, box_depth = 59, acrylic_thickness = 6); // ZLT
electronics_box (box_size_y = 300, box_size_z = 240, box_depth = 79, acrylic_thickness = 6); // New ZL


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
	electronics_box_corner(cornersize = 15, acrylicdepth = acrylic_thickness ,height = box_depth, ledgewidth = 10 , ledgethickness = 4); ;  //electronics box corners
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
    laser_vent=true;
	fans=true;
    PSU_hole_pos_x = 50;  // this should be PSU position.
    PSU_hole_pos_z = 50;
    vent_length = 78;
    vent_height = 3 ;
    gap_between_vents = 4.5 ;
    fan_pos_x = -100;  //this should be over the Duet
    fan_pos_z =75;
    
	difference() 
	{
		color(acrylic2_color())
		difference ()
        {
		translate ([0, 0, thickness/2]) 
		rounded_rectangle([x+thickness/2, y+thickness/2, thickness],panelcornerrounding);

		//16 vents
		if (laser_vent==true) for(vents = [0 : 15]) translate ([PSU_hole_pos_x,PSU_hole_pos_z-(vents*(vent_height + gap_between_vents)),-20]) longscrewhole(vent_length,vent_height,0) ;
		if (laser_vent==false) translate ([PSU_hole_pos_x,PSU_hole_pos_z-131,-20]) cube ([91,131,40]);    
		if (fans==true) {
		translate ([fan_pos_x,fan_pos_z,-acrylic_thickness]) fan_grill_difference(32,3.5,40,8 ,acrylic_thickness*3);
		translate ([fan_pos_x,fan_pos_z-100,-acrylic_thickness]) fan_grill_difference(32,3.5,40,8 ,acrylic_thickness*3);
		}
 		}
	}
}

module elec_corner()
{
	color(printed_part_color())
	{
		rotate ([90,0,180]) import("./railcorestls/Electronics_Box_Corner.stl");
	}
}

}
