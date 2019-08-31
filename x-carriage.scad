include <config.scad>
use <nopscadlib/vitamins/rail.scad>

// check out dogbone_square(size, r = cnc_bit_r, center = true)
// The origin of the z-yoke is the center of the mounting point on the linear rail carriage
module x_carriage() 
{
	// FIXME: need a fillet between horizontal and vertical surfaces to brace it
	// FIXME: this thickness(10) was just arbitrary to mock something up
	part_thickness = 10;
	part_width = 60;
    part_height=30;
	color("#555") 
	{
		difference() 
		{
			// mount face on carriage
			*translate([-part_thickness/2,0,0]) cube([carriage_length(carriage_type_z), part_thickness, carriage_width(carriage_type_z)], center=true);
			// need to use holes, not cylinders.  counterbore?
			* translate([0,50,0])  rotate([90,0,0]) carriage_hole_positions(carriage_type_z) {cylinder(d=3.3,h=100);}
			translate([-part_width/2,part_thickness/2,-part_height/2])  rotate([90,0,0]) import("./railcorestls/Front_X_Carriage.stl");
		}
	//screwholes(5, 5);
	}
}
  
// Holes to mount panels to extrusion
module screwholes(x, y) 
{
	screwholeradius = clearance_hole_size(extrusion_screw_size(extrusion_type)) / 2;
	screwholesX=5;
	screwholesY=5;
	gapX=(x-100)/(screwholesX-1);
	gapY=(y-100)/(screwholesY-1);

	// FIXME: something is off in how these generate in that we need to offset z=-2*epsilon
	mirror_y() 
	{
		for (a =[0:(screwholesX-1)]) 
		{
			translate ([-x/2 + panel_screw_offset+(gapX*a),y/2 - extrusion/2,-2*epsilon])
			cylinder(h=paneldepth + 3*epsilon, r=screwholeradius);
		}
	}
}

x_carriage();