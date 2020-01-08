// vim: set nospell:
include <config.scad>
use <demo.scad>
use <lib/layout.scad>
use <nopscadlib/vitamins/rail.scad>
use <nopscadlib/utils/dogbones.scad>

// The origin of the x-carriage is the center of the mounting point on the face of the linear rail carriage
module x_carriage()
{
  carriage_type = rail_carriage(rail_profiles().z);
  // FIXME: these x/y/z are defined in terms of how the carriage is extruded up from a rounded_rectangle, not how it exists in space ... which is confusing
  carriage_x=64.12 ;
  carriage_y=31.45 ;
  carriage_z=11 ;   //how thick is the AL?
  rail_pos_x = 13.24 ; // rail width 12/2  (centre of rail)
  carr_pos_x =  rail_pos_x - (11.3 + 12/2 + 20/2 ); //12 = rail width , 20 = carriage spacing width
  screw_pos_x = rail_pos_x + 5.91 + (12/2) ; //screw pos from rail pos
  shoulder_bolt = 5 ;    //FIXME needs accurate measurement

  //orient for the printer
  translate([-carr_pos_x, -carriage_z/2, 0]) rotate([90,0,0]) {
    color(alum_part_color()) {
      difference(){
        rounded_rectangle([carriage_x,  carriage_y, carriage_z], 5.5);
        translate([carr_pos_x,0 ,-50])
          rotate([0,0,90])
          carriage_hole_positions(carriage_type) {
            // FIXME: these need counterbores and to be designed with hole()
            cylinder(d=3.3,h=100);
          }


        translate([rail_pos_x,0,-50])
          linear_extrude(height = 100)
          dogbone_rectangle([rail_width(MGN12),rail_width(MGN12)+1], r = 1.5, center = true, xy_center = true); // add 1 for ease of fit. screw will hold

        translate ([screw_pos_x ,carriage_y,0]) rotate([90,0,0]) cylinder(d=shoulder_bolt,h=carriage_y);
        translate([-carriage_x,0,0])   rotate([0,90,0]) cylinder(d=8,h=carriage_x);  //counterbore FIXME needs accurate counterbore
        translate([-carriage_x+10,0,0])   rotate([0,90,0]) cylinder(d=3,h=carriage_x);
      }
    }
  }
}

demo() {
  //rotate([-90,-180,0])
  x_carriage();  //orient for development
  *translate([32,-15.5,16])  rotate([0,-180,0]) import("./railcorestls/Front_X_Carriage.stl");
}
