fan_grill_difference(hole_spacing=32,hole_size = 3.5,outer_circle_diameter = 40,inner_circle_diameter = 8 ,outer_thickness = 6);

module fan_grill_difference(hole_spacing ,hole_size ,outer_circle_diameter ,inner_circle_diameter,outer_thickness)
{
vane_count = 4;			
vane_width = 2;
ring_count = 3;
ring_width = 2;

// some calculated values
vane_angle = 360 / vane_count ;
// ring_spacing defines the CENTER of each ring (radius)
ring_spacing = (outer_circle_diameter - inner_circle_diameter+ring_width)/(ring_count+1)/2;

		// cut the screw holes
		translate(v=[hole_spacing/2, hole_spacing/2, 0])
			cylinder(h=outer_thickness, r=hole_size/2);
		translate(v=[-hole_spacing/2,- hole_spacing/2, 0])
			cylinder(h=outer_thickness, r=hole_size/2);
		translate(v=[hole_spacing/2,- hole_spacing/2, 0])
			cylinder(h=outer_thickness, r=hole_size/2);
		translate(v=[-hole_spacing/2, hole_spacing/2, 0])
			cylinder(h=outer_thickness, r=hole_size/2);


difference()
	{ 
	    cylinder(h=outer_thickness, r=outer_circle_diameter/2);
		// circles
		for (x = [1 : ring_count ])
		{
			difference()
			{
				cylinder(h=outer_thickness, r=inner_circle_diameter/2 + (ring_spacing * x) + (ring_width/2));
				cylinder(h=outer_thickness, r=inner_circle_diameter/2 + (ring_spacing * x) - (ring_width/2));
			}
		}
		// the inner circle
		cylinder(h=outer_thickness, r=inner_circle_diameter/2);
		// diagonal holders
		rotate([0,0,vane_angle/2])
	for (angle = [0 : vane_angle : 360] )
	{
		rotate([0,0,angle])
		translate(v=[0,-vane_width/2,0])
		cube(size=[outer_circle_diameter/2, vane_width, outer_thickness]);
	}
	}







	
	






	
	
	}