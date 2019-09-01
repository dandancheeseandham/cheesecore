include <config.scad>
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
use <lib/mirror.scad>

module rail_wrapper(rail_type,length, include_screws=false, position=0)
{
	assert(length != undef, "Length must be defined");
	rail = rail_type;
	screw = rail_screw(rail);
	nut = screw_nut(screw);
	washer = screw_washer(screw);

	//position = rail_travel(rail, length) /2;
	rail_assembly(rail, length, position);

	if(include_screws) 
	{
		rail_screws(rail, length, sheet + nut_thickness(nut, true) + washer_thickness(washer));

		rail_hole_positions(rail, length, 0)
        translate_z(-sheet)
            vflip()
                nut_and_washer(nut, true);
	}

	//Debug - set to true for debug info
	if (false) 
	{
		echo("Rail travel: ", rail_travel(rail, length));
		echo("position: ", position);
	}
}

module x_rails(rail_type,position=0) 
{
	mirror_y() 
	{
	translate ([0, extrusion_length.y/2, 0]) rotate([90, 0, 0]) rail_wrapper(rail_type, rail_length.x, position=-rail_travel(rail_type, rail_length.x)/2 + position);
	}
}

x_rails(MGN9,position=0);
