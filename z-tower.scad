include <config.scad>
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
use <extrusion.scad>
use <lib/mirror.scad>
use <rail.scad>
use <z-yoke.scad>
use <coupler.scad>
use <anti-backlash-nut.scad>
use <z-bracket.scad>
use <leadscrew.scad>

	rail_adjustment = 30 + 6 ;  			// couplerheight + panel_depth
	space_between_towers = 255 ; 	// standard for ZL/ZLT , based on bed tongues
	coupler_adjustment = 85 ;
	z_yoke_adjustment = coupler_adjustment - 10 ; 
	rail_carriage_adjustment = z_yoke_adjustment +5 ;
	
	leadscrew_width = 8 ;
	leadscrew_pitch = 4 ;  					// pitch - currently unused
	
module z_tower(extrusion_type, rail_type_z, z_position=0) 
{
	
	//NEMA17 motor
	translate ([-leadscrew_x_offset, 0,-paneldepth])
    NEMA(NEMA17);

	//Coupler is connected to the NEMA12 motor
	translate ([-leadscrew_x_offset, 0,couplerheight])
    coupler();
	
	// Leadscrew is connected to the coupler
    color("#BBB")  
	translate ([-leadscrew_x_offset, 0,couplerheight])
    cylinder(leadscrew_length, leadscrew_width/2,leadscrew_width/2);  
	//leadscrew(300 ,8);
	
	// Anti Backlash nut - connected to the leadscrew
	// FIXME: z position is fake
	translate([-leadscrew_x_offset, 0, rail_length.z - z_position - coupler_adjustment])
    anti_backlash_nut(8);
	
		// Z-yoke - connected to the anti-backlast nut
	// FIXME: this z position is fake, just to make it look decent-ish
	translate([-extrusion_width($extrusion_type) - carriage_height(rail_carriage(rail_type_z)), leadscrew_y_offset, rail_length.z - z_position - z_yoke_adjustment])
    z_yoke();
	
	// Rail - rail carriage connected to the Z-yoke
	// The z-translate here seems kinda arbitrary?
	// FIXME: This is an approximation, ideally we want to actually compute a
	// real rail position based on a nozzle-to-carriage offset, bed thickness,
	// and yoke-to-carriage offset.
	
	position = rail_length.z/2-z_position-rail_carriage_adjustment;
 	translate ([-extrusion_width($extrusion_type),leadscrew_y_offset,(rail_length.z)/2 + rail_adjustment])
    rotate([90,270,270])
    rail_wrapper(rail_type_z, rail_length.z, position=position);
	
	// Extrusion
	//extrusion_width = extrusion_width(extrusion_type);
	overall_length = extrusion_length.z + (2 * extrusion_width($extrusion_type));
	translate ([-extrusion_width($extrusion_type)/2, leadscrew_y_offset, 0])
    extrusion(overall_length , extrusion_type);

	// bottom Z bracket
	translate([0, leadscrew_y_offset +extrusion_width($extrusion_type)/2, extrusion_width($extrusion_type)])
    z_bracket(extrusion_type);
	
	// top z bracket
	translate([0, leadscrew_y_offset +extrusion_width($extrusion_type)/2, extrusion_length.z + extrusion_width($extrusion_type)])
    mirror([0, 1, 0])
    rotate([180, 0, 0])
    z_bracket(extrusion_type);
	
	//Debug - set to true for debug info
	if (false) {
	echo ("rail_length.z",rail_length.z);
	echo ("z_position",z_position);
	echo("Passing rail position of: ", position);
	echo("extrusion_length.z",extrusion_length.z); 
	echo("extrusion_width" , extrusion_width($extrusion_type) );
	}
	
}

module z_towers(rail_type_z, z_position = 0) 
{
	translate([bed_offset.x, bed_offset.y, -extrusion_length.z/2 - extrusion_width($extrusion_type)]) 
	{
		translate([extrusion_length.x/2, 0, 0]) z_tower($extrusion_type, rail_type_z, z_position);
		mirror_y() 
		{
			translate([-extrusion_length.x/2, space_between_towers/2, 0]) rotate([0,0,180]) z_tower($extrusion_type, rail_type_z, z_position);
		}
	}
}

z_towers(MGN12, z_position = 0);