// vim: set nospell:
include <config.scad>
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
use <lib/holes.scad>
use <lib/layout.scad>
use <door_hinge.scad>
use <screwholes.scad>

include <nopscadlib/vitamins/stepper_motor.scad>
include <nopscadlib/vitamins/stepper_motors.scad>

use <demo.scad>


/*z tower extrusion holes in helo and bottom panel_length
PTFE holes in halo and other and cable opening
move electronics box up, no top piece
holes in electronics side panels for microswitch buttons
*/

module halo() {
/*
  assert(front_window_size().x <= frame_size().x - 2 * extrusion_width(), str("Window cannot overlap extrusion in X: "));
  assert(front_window_size().y <= frame_size().z - 2 * extrusion_width(), "Window cannot overlap extrusion in Z");
  min_y_gap = (frame_size().z - front_window_size().y) / 2 - abs(front_window_offset().y);
  assert(min_y_gap >= extrusion_width(), "Window cannot overlap extrusion in Z");
*/



  difference() {
    difference() {
      color(panel_color())
        translate ([0, 0, halo_thickness()/2])
          //rounded_rectangle([frame_size().x + extra_x() + minimum_addition(), frame_size().y + halo_thickness()  + extra_y (), halo_thickness()], panel_radius());
          rounded_rectangle([halo_size().x , halo_size().y, halo_thickness()], panel_radius());
      // Color the holes darker for contrast
      color(panel_color_holes()) {
        panel_mounting_screws(frame_size().x, frame_size().y);

        mirror_xy() {
          // Access screws to corner cubes
          translate([frame_size().x / 2 - extrusion_width() / 2, frame_size().y / 2 - extrusion_width() / 2, -epsilon])
            cylinder(d=extrusion_width() * 0.5, h = halo_thickness() + 2 * epsilon);
          // M3 holes near corners - cleanrance hole 3.4mm
          translate([frame_size().x / 2 - extrusion_width() / 2 , frame_size().y / 2 - extrusion_width() * 2 , 25])
              clearance_hole(nominal_d=3, h=50);
          translate([frame_size().x / 2 - extrusion_width() * 2 , frame_size().y / 2 - extrusion_width() / 2 , 25])
                clearance_hole(nominal_d=3, h=50);

//holes
holes_row_position = 50 ; // modify this to change where the holes are on the halo
          translate([frame_size().x / 2 + holes_row_position , frame_size().y / 2 - 210 , 25])
            clearance_hole(nominal_d=8.5, h=50);  // for  for M10 tap thread
            translate([frame_size().x / 2 + holes_row_position , frame_size().y / 2 - 190 , 25])
              clearance_hole(nominal_d=4.3, h=50);  // for M6 tap thread



          translate([frame_size().x / 2 + holes_row_position , frame_size().y / 2 - 170 , 25])
            clearance_hole(nominal_d=2.5, h=50);   // for 3mm tap
  *        translate([frame_size().x / 2 + holes_row_position , frame_size().y / 2 - 150 , 25])
            clearance_hole(nominal_d=3, h=50);  // for 3mm hole
  *        translate([frame_size().x / 2 + holes_row_position , frame_size().y / 2 - 130 , 25])
            clearance_hole(nominal_d=4, h=50);  // for 4mm hole for standard PTFE tube
  *        translate([frame_size().x / 2 + holes_row_position , frame_size().y / 2 - 120 , 25])
            clearance_hole(nominal_d=4, h=50);  // for 4mm hole for standard PTFE tube

          *translate([frame_size().x / 2 + holes_row_position , frame_size().y / 2 - 90 , 25])
            clearance_hole(nominal_d=7, h=50);  // for 7mmm hole for M8 tap thread


        }
      }
    }

    //remove main hole in halo
    color(panel_color_holes())
      translate ([0, 0, halo_thickness() / 2])
        rounded_rectangle([frame_size().x - extrusion_width() * 2, frame_size().y - extrusion_width() * 2, halo_thickness() + 2 * epsilon], 1);
  }
  // DEBUG cube
  *translate([-frame_size().x / 2 , -frame_size().z / 2 , halo_thickness()])  cube ([10,frame_size().z,10]);
}


//longscrewhole(screwhole_length,Mscrew,screwhole_increase)


module panel_mounting_screws(x, y)
{
  // How far from center of first hole to center of last hole
  extent_x = x - 2 * panel_screw_offset();
  extent_y = y - 2 * panel_screw_offset();

  // How many screws in each direction
  screws_x = 4;
  screws_y = 4;

  // How far between screws
  screw_spacing_x = extent_x / (screws_x - 1);
  screw_spacing_y = extent_y / (screws_y - 1);

// long holes on X axis
  mirror_y() {
    for (a =[0:(screws_x - 2)]) {
      translate ([-x/2 + panel_screw_offset() + (screw_spacing_x * a), y / 2 - extrusion_width() / 2, -epsilon])
        // FIXME - this should be a hole() not a cylinder
        //cylinder(h=halo_thickness() + 2 * epsilon, d=clearance_hole_size(extrusion_screw_size()));
        longscrewhole(frame_size().y/5,3,0.25);

    }
  }
  // long holes on Y axis
  fudge_to_centre = 10 ;
  mirror_x() {
      for (a =[0:(screws_y - 2)]) {
      translate ([x / 2 - extrusion_width() / 2, -y / 2 + panel_screw_offset() + (screw_spacing_y * a) + fudge_to_centre, -epsilon])
        // FIXME - this should be a hole not a cylinder
        //cylinder(h=halo_thickness() + 2 * epsilon, d=clearance_hole_size(extrusion_screw_size()));
      rotate ([0,0,90]) longscrewhole(100,3,0.25);


  *translate ([-frame_size().x / 2 + -20 + extrusion_width()/2, motor_pulley_link(),0]) // rear left idler
      cylinder(d=3.3, h=60);

  *translate ([-20 + extrusion_width()/2 - frame_size().x / 2 - NEMA_width(NEMAtypeXY())/2 + side_panel_thickness(), -motor_pulley_link() - pulley_pr(GT2x20_plain_idler) - pulley_pr(GT2x16_pulley),0])
      cylinder(d=3.3, h=60);



    }

  }

  // make motor holes for NEMA motors.
  translate([frame_size().x / 2 - extrusion_width(), 0, 0])
    mirror_y() {
      translate([side_panel_thickness() + extrusion_width() + NEMA_width(NEMAtypeXY())/2 + 10, motor_pulley_link() + 11 , 0])
        make_motorholes();
}

// IDLER HOLES with 2.5mm holes for 3mm tap.
  translate([-frame_size().x / 2, 0, 0]){
    mirror_y() {
      #translate([-side_panel_thickness() - NEMA_width(NEMAtypeXY())/2 + halo_idler_offset_outer(), motor_pulley_link() + 11 , -5])
        cylinder(d=2.5, h=35);   //// FURTHEST IDLER

    #translate([-extrusion_width()+halo_idler_offset_inner(), motor_pulley_link(),-5])
      cylinder(d=2.5, h=35);   //// inner IDLER
           }
         }

}


module make_motorholes() {
long_motor_holes(NEMAtypeXY());

screwsize = 3;
*translate ([(extrusion_width()/2),-43.3+(screwsize/2),2])
  rotate ([0,0,90])
    longscrewhole(screwhole_length=8,Mscrew=screwsize,screwhole_increase=0.15); //extrusion adjust

}


module long_motor_holes(type) {
  function part_thickness() = 10;  // part_thickness  of aluminium part in mm
  function NEMAadjust() = 8 ;
//translate ([-extrusion_width() - side_panel_thickness() - NEMA_width(type)/2, 0, 0])
  hull() {
    translate([NEMAadjust()/2, 0,-epsilon])
      cylinder(h=part_thickness() + 2 * epsilon, d=NEMA_boss_radius(type) * 2 + 3);
    translate([-NEMAadjust()/2, 0, -epsilon])
      cylinder(h=part_thickness() + 2 * epsilon, d=NEMA_boss_radius(type) * 2 + 3);
  }
  mount_length = -18;
translate([(-mount_length/2-NEMAadjust())/2, 0, 0])
  mirror_xy() {
    hull() {
      translate([NEMA_hole_pitch(type)/2+NEMAadjust()/2, NEMA_hole_pitch(type)/2, -epsilon-30 ])
      // FIXME this needs to be a hole() not a cylinder
      //cylinder(d=3.3, h=side_panel_thickness() + 2 * epsilon);
      cylinder(d=3.3, h=60);
      translate([NEMA_hole_pitch(type)/2-NEMAadjust()/2, NEMA_hole_pitch(type)/2, -epsilon-30 ])
      cylinder(d=3.3, h=60);
    }
  }
}


demo(){
//translate([0, 0, frame_size().z / 2 - halo_thickness()])
  halo();
}
