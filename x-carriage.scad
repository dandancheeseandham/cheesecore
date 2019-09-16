include <config.scad>
use <demo.scad>
use <lib/mirror.scad>
use <nopscadlib/vitamins/rail.scad>
use <nopscadlib/utils/dogbones.scad>
  
// The origin of the x-carriage is the center of the mounting point on the face of the linear rail carriage
module x_carriage()
{
  carriage_type = rail_carriage(rail_profiles().z);
  carriage_x=64.12 ; 
  carriage_y=31.45 ;
  carriage_z=11 ;   //how thick is the AL?

//orient for the printer 
  rotate([90,180,0]) { 
    color(alum_part_color()) {  
      difference(){ 
        rounded_rectangle([carriage_x,  carriage_y, carriage_z], 5.5); 
        translate([-carriage_x/2+rail_width(MGN12)/2+40-11.3-10,carriage_y/2-(rail_width(MGN12)+1)/2-10,-50]) 
        rotate([0,0,90])
          carriage_hole_positions(carriage_type) {
            cylinder(d=3.3,h=100);
          }
         
      //translate([0,carriage_y/2-(rail_width(MGN12)+1)-10,-50]) cube ([rail_width(MGN12), (rail_width(MGN12)+1),100]);  // add 1 for ease of fit. screw will hold.
      // use dogbone for the aluminium version
      translate([-carriage_x/2+rail_width(MGN12)/2+40,carriage_y/2-(rail_width(MGN12)+1)/2-10,-50]) 
        linear_extrude(height = 100) 
          dogbone_rectangle([rail_width(MGN12),rail_width(MGN12)+1], r = 1.5, center = true, xy_center = true);
          
      translate([-carriage_x,0,0])   rotate([0,90,0]) cylinder(d=8,h=carriage_x);  //counterbore
      translate([-carriage_x+10,0,0])   rotate([0,90,0]) cylinder(d=3,h=carriage_x);  
      }
    } 
  }
}

demo() {
 rotate([-90,-180,0]) x_carriage();  //orient for development
translate([50,0,0])  rotate([0,0,0]) import("./railcorestls/Front_X_Carriage.stl");
}