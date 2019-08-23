include <config.scad>
include <screwholes.scad>
include <nopscadlib/core.scad>

// FIXME: add holes to secure this thing
// FIXME: describe the origin of this part ... and decide if it's right.  There isn't an obvious "right" place for this one

module z_bracket(extrusion_type) {
  extrusion = extrusion_width(extrusion_type);
  z_bracket_screwsize = extrusion_screw_size(extrusion_type);
  
	//leg_length = 10+extrusion*4;
	leg_length = extrusion*4;
	thickness = extrusion-5;
	//translate([0, 0, 0]) cube([extrusion, leg_length, thickness]);  //cube version
	//translate([-extrusion, 0, -extrusion]) cube([extrusion, thickness, leg_length]);  //cube version

	color(printed_part_color()) 
	difference() {
	union() {  
	translate([extrusion/2,leg_length/2, thickness/2]) rounded_rectangle([extrusion, leg_length, thickness], 2);
    translate([-extrusion/2,thickness/2, leg_length/2-extrusion]) rotate ([0,90,90])  rounded_rectangle([leg_length, extrusion, thickness], 2);


//FILLET
	intersection() {
		rotate ([0,270,0]) translate([thickness,thickness,-extrusion])fillet(extrusion,   extrusion*2); 
		rotate ([90,0,0]) translate([0,thickness,-thickness-extrusion])fillet(extrusion,   thickness+extrusion); 
	}		

	 intersection() {
	rotate ([0,180,0]) translate([0,thickness,-thickness-extrusion])fillet(extrusion,   extrusion+thickness); 
	rotate ([0,270,0]) translate([thickness,thickness,0])fillet(extrusion,   extrusion); 
	 }

rotate ([90,0,0]) translate([0,(thickness),-(thickness)])fillet(extrusion,   thickness); 
rotate ([0,180,0]) translate([0,thickness,-thickness])fillet(extrusion,   thickness); 
translate([-thickness/2, 0, 0]) cube([thickness, thickness, thickness]);  //fill in a rounded corner

}
	
	//screwholes removed from entire unioned object		
	    translate([extrusion/2, extrusion*1.75-z_bracket_screwsize, 0])  screwholes(row_distance=extrusion*2,numberofscrewholes=3,Mscrew=z_bracket_screwsize,screwhole_increase=0.5);
		rotate ([90,0,0]) translate([-extrusion/2, -extrusion/2, -extrusion*0.5])   screwholes(row_distance=extrusion*3,numberofscrewholes=4,Mscrew=z_bracket_screwsize,screwhole_increase=0.5);
		rotate ([90,0,0]) translate([-extrusion/2, -extrusion/2, -55-thickness])   screwholes(row_distance=extrusion*3,numberofscrewholes=4,Mscrew=z_bracket_screwsize*2,screwhole_increase=0.5); // to remove some fillet to make screwing in easier
		}
	}
	

//translate ([main_body_size_x,nubbin_size_y+rounding,0]) 

z_bracket(15,3);

