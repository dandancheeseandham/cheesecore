// vim: set nospell:
use <demo.scad>
use <config.scad>

module hole_plug(plug_height = 4,seal_depth = 0.8,flange = 4,plug_diameter = 3){
  difference() {
    union() {
      cylinder(d1=plug_diameter*2/3, d2=plug_diameter, h=plug_height/2+seal_depth);
        translate([0,0,plug_height/2+seal_depth])
      cylinder(d1=plug_diameter, d2=plug_diameter*2/3, h=plug_height/2+seal_depth/2);
      cylinder(d=plug_diameter+flange, h=seal_depth);
    }
  translate([0,0,seal_depth])
    cylinder(d=plug_diameter-2, h=plug_height*2);
  }
}


demo()
{
  hole_plug(plug_height = 6,seal_depth = 1.2,flange = 4,plug_diameter = 3);
}
