//
//Yet Another Filament Spool Holder
//
//Designed for the Lasercut Mende90 but can be fitted on most printers with
//a flat surface to bolt it onto.
//
//tony@think3dprint3d.com
//
// GPL v3.0
//
//
use <nopscadlib/utils/core/global.scad> //nopscadlib library
//use <nopscadlib/utils/core/teardrops.scad> //nopscadlib library
use <demo.scad>
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
include <lib/layout.scad>
//variable defines, all in mm
//##overall spool dimensions##


//
//Yet Another Filament Spool Holder
//
//Designed for the Lasercut Mende90 but can be fitted on most printers with
//a flat surface to bolt it onto.
//
//tony@think3dprint3d.com
//
// GPL v3.0
//
// it uses two libraries from the mendel90 design, available from here:
//
// https://github.com/T3P3/Mendel90/tree/LaserCut/scad
// teardrops.scad
// utils.scad
//
//for the thingiverse customiser the fucntions have been included in this file.

// preview[view:south west, tilt:top diagonal]

//variable defines, all in mm

//##customiser variables##//
// The maximum width of the spool or spools
max_spool_width=90; //[30:150]

//bearing outer diameter 13=624ZZ,21=608ZZ
bearing_od=0; //[13,22]
//bearing inner diameter 4=624ZZ,8=608ZZ
bearing_id=4; //[4,8]
//bearing thickness 5=624ZZ 7=608ZZ
bearing_thickness=5; //[5,7]
//use 25 for 624ZZ and 31 for 608ZZ
min_spool_id=25; //[25,32]

/* [Hidden] */


spool_id_clearance=1; //minimum clearance between the spool holder and the inside of a spool

//##bearing variables##
bearing_washer_thickness=0.5; //M4 washer
bearing_washer_radius=9/2; //M4 washer
bearing_clearance=0; //clearance between the bearings and the spool holder
//a set of two bearings with a washer at each end as a spacer
bearing_stack_thickness=(2*bearing_thickness)+(2*bearing_washer_thickness);
bearing_stack_wall_thickness=2;
//the bolt to hold the stack and plastic walls together
bearing_stack_bolt_length=bearing_stack_thickness+bearing_stack_wall_thickness*2+10;
echo("bearing_stack_bolt_length: ", bearing_stack_bolt_length);

//##filament holder variables##
min_filament_holder_id = bearing_od+bearing_clearance;
max_filament_holder_od = min_spool_id-spool_id_clearance;
filament_holder_wall_thickness= max_filament_holder_od-min_filament_holder_id;
echo("filament_holder_wall_thickness: ", filament_holder_wall_thickness);
filament_holder_length=max_spool_width+bearing_stack_bolt_length;
echo("filament_holder_length: ", filament_holder_length);

//##mounting plate##
fastener_clearance_radius=3.3/2;
fastener_washer_clearance_radius=8/2;
mounting_plate_thickness=8;
mounting_plate_width=min_spool_id+fastener_washer_clearance_radius;
mounting_plate_height=min_spool_id+fastener_washer_clearance_radius*3;


//##miscellaneous##
fn_resolution=100; //quality vs render time
print_clearance=0.1; //additional clearance between two printed objects

//The "peg" like tube the filament reel will sit on
module main_tube(){
rotate([90,0,0])
    difference(){
      rotate([0,0,180])//truncated part facing down
        //use a teardrop to make it printable without support.
        teardrop(filament_holder_length, max_filament_holder_od/2,true,true);

      //cut out for bearings
      translate([0,(max_filament_holder_od-min_spool_id*4/7),0])
        cube([min_spool_id+5,
              min_filament_holder_id/2,
              filament_holder_length-bearing_stack_wall_thickness*2],center=true);
      translate([0,(max_filament_holder_od-min_filament_holder_id)/2,0])
        cylinder(h=filament_holder_length-bearing_stack_wall_thickness*2,
                 r=min_filament_holder_id/2, $fn=fn_resolution,center=true);
      translate([0,(max_filament_holder_od-min_filament_holder_id/2)/2,0])
        cube([min_filament_holder_id, min_filament_holder_id/2,filament_holder_length-bearing_stack_wall_thickness*2],center=true);

  }

 rotate([90,180,0]) translate ([0,-2,filament_holder_length/2]) teardrop(5, max_filament_holder_od/2+2,true,true);
}

//The plate that holds the main tube to the side of the printer
module mounting_plate(){
     $fn=fn_resolution;//smooth rounded rectangle
		difference(){
				hull(){
					translate([0,(mounting_plate_width-max_filament_holder_od)/2,-(filament_holder_length+mounting_plate_thickness)/2 ])
						rotate([1,0,0])//1 degree to compensate for the distortion due to heavy reels
						rounded_rectangle([mounting_plate_height,mounting_plate_width,mounting_plate_thickness-3],2,true);
					translate([0,0,-(filament_holder_length)/2 +bearing_stack_wall_thickness/2+0.5])
						cylinder(h=1, r=max_filament_holder_od/2, $fn=fn_resolution,center=true);
					}

				//bolt holes
				for(i=[-1,1])
					for(j=[-1,1])
						translate([j*mounting_plate_height/2 - j*fastener_washer_clearance_radius,
										i*mounting_plate_width/2 -i*fastener_washer_clearance_radius
														+ (mounting_plate_width-max_filament_holder_od)/2,
										-(filament_holder_length+mounting_plate_thickness)/2])
						{
							teardrop(100, fastener_clearance_radius,true,true);
							translate([0,0,(mounting_plate_thickness-2)/2+20])
								teardrop(40, fastener_washer_clearance_radius,true,true);
						}
		}
}


//each bearing stack has two printed ends
module bearing_end(edge=true){
	difference(){
		if(edge) //the bearing end sticks up to prevent the filament roll from coming off
			hull(){
			cylinder(h=bearing_stack_wall_thickness, r=min_filament_holder_id/2-print_clearance/2, $fn=fn_resolution,center=true);
			translate([6,0,0])
				cube([6,6,bearing_stack_wall_thickness],center=true);
			}
		else
			cylinder(h=bearing_stack_wall_thickness, r=min_filament_holder_id/2-print_clearance/2, $fn=fn_resolution,center=true);
			translate([bearing_clearance,0,0])
				cylinder(h=bearing_stack_bolt_length+10,r=bearing_id/2+0.15,$fn=fn_resolution,center=true);
	}
}


module spool_holder_stl(){

	translate([0,0,max_filament_holder_od/2]){
		main_tube();
		rotate([90,0,0])
			translate([0,0,-0.01]) //prevent intersecting faces
			mounting_plate();
	}

	for(i=[-1,1])
		translate([i*(max_filament_holder_od+min_filament_holder_id)/2,0,bearing_stack_wall_thickness/2]){
			bearing_end(false);
			translate([0,min_filament_holder_id+2,0])
				rotate([0,0,90])
					bearing_end(true);
		}
}


module bearing_stack_assembly();
//the printed bearing ends, washers and two bearings
module bearing_stack_assembly(){
  bearing_end(false);
    translate([0,0,bearing_stack_wall_thickness+
              bearing_washer_thickness*2+bearing_thickness*2])
  bearing_end(true);
  //Bearings and washers
  %translate([bearing_clearance,0,bearing_stack_wall_thickness/2+
             bearing_washer_thickness+bearing_thickness])
    difference(){
        union(){
          for(i=[-1,1])
            translate([0,0,i*bearing_thickness+i*bearing_washer_thickness/2])
              cylinder(h=bearing_washer_thickness,
                       r=bearing_washer_radius,
                       $fn=fn_resolution,center=true);
              cylinder(h=bearing_thickness*2,
                       r=bearing_od/2,
                       $fn=fn_resolution,center=true);
         }
         cylinder(h=bearing_stack_thickness+5,
                  r=bearing_id/2,
                  $fn=fn_resolution,center=true);
  }
}

module spool_holder_assembly(){
  color ("DarkRed")
translate ([0,-max_spool_width/2-mounting_plate_thickness/2-15,0]) {
	main_tube();
	rotate([90,0,0]){
		mounting_plate();
				}
}
}

module spool1kg(){
  // 1 kg spool
color ("Yellow")   mirror_z()
  {
difference (){
union(){
cylinder (d=88.9,h=73.152/2);
translate ([0,0,73.152/2]) cylinder (d=203.2,h=3);
}
translate ([0,0,-2])  cylinder (d=52.8,h=75);
}
}
}

module spool2kg(){
  // 1 kg spool
color ("Yellow")  mirror_z()
  {
difference (){
union(){
cylinder (d=88.9,h=101.6/2);
translate ([0,0,101.6/2]) cylinder (d=298.452,h=3);
}
translate ([0,0,-2])  cylinder (d=52.07,h=75);
}
}
}

module spool4kg(){
  // 1 kg spool
  mirror_z()
  {
difference (){
union(){
cylinder (d=88.9,h=101.6/2);
translate ([0,0,101.6/2]) cylinder (d=298.452,h=3);
}
translate ([0,0,-2])  cylinder (d=52.07,h=75);
}
}
}

demo(){
//bolt_holes();
  spool_holder_assembly();
  //rotate ([90,0,0]) translate ([0,00,0]) spool2kg();
  //translate ([300,0,0]) spool1kg();
	//spool_holder_assembly();
	//spool_holder_stl();

}


// From:
// https://github.com/T3P3/Mendel90/tree/LaserCut/scad
// teardrops.scad
module teardrop_2D(r, truncate = true) {
    difference() {
        union() {
            circle(r = r, $fn=100);
            translate([0,r / sqrt(2),0])
                rotate([0,0,45])
                    square([r, r], center = true);
        }
        if(truncate)
            translate([0, r * 2, 0])
                square([2 * r, 2 * r], center = true);
    }
}
// From:
// https://github.com/T3P3/Mendel90/tree/LaserCut/scad
// teardrops.scad
module teardrop(h, r, center, truncate = true)
    linear_extrude(height = h, convexity = 2, center = center)
        teardrop_2D(r, truncate);
