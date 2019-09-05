include <config.scad>
use <screwholes.scad>
use <nopscadlib/utils/fillet.scad>
use <demo.scad>

// FIXME: describe the origin of this part ... and decide if it's right.  There isn't an obvious "right" place for this one
module z_bracket(extrusion_type)
{

  z_bracket_screwsize = extrusion_screw_size() /2 + 0.25;
  leg_length = extrusion_width()*4;
  thickness = extrusion_width()-5;

  color(printed_part_color())
    difference()
    {
      union()
      {
        translate([extrusion_width()/2,leg_length/2, thickness/2]) rounded_rectangle([extrusion_width(), leg_length, thickness], 2);
        translate([-extrusion_width()/2,thickness/2, leg_length/2-extrusion_width()]) rotate ([0,90,90])  rounded_rectangle([leg_length, extrusion_width(), thickness], 2);

        //FILLET
        intersection()
        {
          rotate ([0,270,0]) translate([thickness,thickness,-extrusion_width()])fillet(extrusion_width(),   extrusion_width()*2);
          rotate ([90,0,0]) translate([0,thickness,-thickness-extrusion_width()])fillet(extrusion_width(),   thickness+extrusion_width());
        }
        intersection()
        {
          rotate ([0,180,0]) translate([0,thickness,-thickness-extrusion_width()])fillet(extrusion_width(),   extrusion_width()+thickness);
          rotate ([0,270,0]) translate([thickness,thickness,0])fillet(extrusion_width(),   extrusion_width());
        }

        rotate ([90,0,0]) translate([0,thickness,-thickness])fillet(extrusion_width(),   thickness);
        rotate ([0,180,0]) translate([0,thickness,-thickness])fillet(extrusion_width(),   thickness);
        translate([-thickness/2, 0, 0]) cube([thickness, thickness, thickness]);  //fill in a rounded corner

        intersection()
        {
          translate([0,thickness,0]) rotate ([0,180,0]) fillet(extrusion_width(),   extrusion_width()+thickness);
          rotate ([0,90,0]) translate([0,thickness,-extrusion_width()]) fillet(extrusion_width()-1.5,   extrusion_width());
        }
      }
      //screwholes removed from entire unioned object
      translate([extrusion_width()/2, extrusion_width()*1.75-z_bracket_screwsize, 0])  screwholes(row_distance=extrusion_width()*2,numberofscrewholes=3,Mscrew=z_bracket_screwsize,screwhole_increase=0.5);
      rotate ([90,0,0]) translate([-extrusion_width()/2, -extrusion_width()/2, -extrusion_width()*0.5])   screwholes(row_distance=extrusion_width()*3,numberofscrewholes=4,Mscrew=z_bracket_screwsize,screwhole_increase=0.5);
      //  rotate ([90,0,0]) translate([-extrusion_width()/2, -extrusion_width()/2, -55-thickness])   screwholes(row_distance=extrusion_width()*3,numberofscrewholes=4,Mscrew=z_bracket_screwsize*screwhole_increase=0.5); // to remove some fillet to make screwing in easier
    }
}

module z_bracket_preview(extrusion)
{
  translate([0, 0, 0]) cube([extrusion_width(), leg_length, thickness]);  //cube version
  translate([-extrusion_width(), 0, -extrusion_width()]) cube([extrusion_width(), thickness, leg_length]);  //cube version
}

demo() {
z_bracket(extrusion_width($extrusion_type));
}

