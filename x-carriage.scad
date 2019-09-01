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

	}
}
  
x_carriage();