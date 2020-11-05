// vim: set nospell:
include <config.scad>
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
use <lib/holes.scad>
use <lib/layout.scad>
use <door_hinge.scad>
use <screwholes.scad>
use <electronics_box_panels.scad>
include <nopscadlib/vitamins/stepper_motor.scad>
include <nopscadlib/vitamins/stepper_motors.scad>
use <demo.scad>
/*z tower extrusion holes in halo and bottom panel_length
PTFE holes in halo and other and cable opening
move electronics box up, no top piece
holes in electronics side panels for microswitch buttons
*/

function centre_plate_size() = [80,150,halo_size().z];
function centre_plate_position() = [5,0,0];
function centre_mounting_plate_screw_gap() = 3;

function motor_mount_size() = [80,129,halo_size().z];
function motor_mount_position() = [48,174,10];
function motor_screws() = [3,3,0];
function overlap() = [3.5,18,0];

module halo(modular = true) {
/*
  assert(front_window_size().x <= frame_size().x - 2 * extrusion_width(), str("Window cannot overlap extrusion in X: "));
  assert(front_window_size().y <= frame_size().z - 2 * extrusion_width(), "Window cannot overlap extrusion in Z");
  min_y_gap = (frame_size().z - front_window_size().y) / 2 - abs(front_window_offset().y);
  assert(min_y_gap >= extrusion_width(), "Window cannot overlap extrusion in Z");
*/
//raise_plates_up = -2 ;
  raise_plates_up = 9 ;
  mirror_x()
    translate([frame_size().x / 2 + centre_plate_size().x/2 + centre_plate_position().x/2, centre_plate_position().y/2 , raise_plates_up+eps])
      centre_plate();
    if (($preview) && (modular == true)) {
      translate([frame_size().x / 2 + motor_mount_position().x , motor_mount_position().y , raise_plates_up+eps])
        motor_plate(moveX = 18, moveY = 11);
      translate([frame_size().x / 2 + motor_mount_position().x , -motor_mount_position().y , -raise_plates_up+6-eps])
        rotate([180,0,0])
          motor_plate(moveX = 18, moveY = 11);
        }

translate ([0, 0, halo_size().z/2])
  color(panel_color()) render()
    difference() {
      difference() {
        rounded_rectangle([halo_size().x , halo_size().y , halo_size().z], 3);
        remove_main();
        mirror_x()
          translate([frame_size().x / 2 + centre_plate_size().x/2 + centre_plate_position().x/2, centre_plate_position().y/2 , 28])
            mounting_plate(centre_plate_size(),overlap(),true);

      if (modular == true) {
        mirror_y()
          translate([frame_size().x / 2 + motor_mount_position().x , motor_mount_position().y, 28])
            mounting_plate(motor_mount_size(),overlap(),true);
            }
      if (modular == false) {
        moveX = 18;
        moveY = 11;
mirror_y()
        translate([frame_size().x / 2 + motor_mount_position().x , motor_mount_position().y , raise_plates_up+eps])
        translate([-motor_mount_position().x -extrusion_width(), -motor_mount_position().y , 0])
           {
            translate([side_panel_thickness() + extrusion_width() + NEMA_width(NEMAtypeXY())/2 + moveX, motor_pulley_link() + moveY  , 0])
              long_motor_holes(NEMAtypeXY());
            }
      }


        // Color the holes darker for contrast
        color(panel_color_holes()) {
          panel_mounting_screws(frame_size().x, frame_size().y);
        mirror_xy() {
        // Access screws to corner cubes
          corner_cube_access();
          m3_corner_mount_holes();
          //corner to screw in extrusion (old style)
          translate([halo_size().x/2-extrusion_width() * 0.5 , halo_size().y/2-extrusion_width() * 0.5 , 25])
            clearance_hole(nominal_d=3, h=50 , fit = "normal");
        }
      }
    }
  }
}

module corner_cube_access() {
  translate([frame_size().x / 2 - extrusion_width() / 2, frame_size().y / 2 - extrusion_width() / 2, -epsilon])
    cylinder(d=extrusion_width() * 0.5, h = halo_size().z + 2 * epsilon);
}

module m3_corner_mount_holes() {
  // M3 holes near corners - cleanrance hole 3.4mm
  union() {
    translate([frame_size().x / 2 - extrusion_width() / 2 , frame_size().y / 2 - extrusion_width() * 2 + 12.5 , 25])
      clearance_hole(nominal_d=3, h=50);
    translate([frame_size().x / 2 - extrusion_width() * 2 + 12.5 , frame_size().y / 2 - extrusion_width() / 2 , 25])
      clearance_hole(nominal_d=3, h=50);
  }
}

module remove_main() {
  //remove main hole in halo
  color(panel_color_holes())
    rounded_rectangle([frame_size().x - extrusion_width() * 2, frame_size().y - extrusion_width() * 2, halo_size().z + 2 * epsilon], 1);
}

module mounting_plate(mounting_plate, mounting_plate_screw_gap = [4,4,0], remove = false, removal = [14,2,0]) {
  if (remove == true) {
    //translate ([-mounting_plate.x/2,-mounting_plate.y/2,0])
    {
      mirror_xy()
        translate ([mounting_plate.x/2-mounting_plate_screw_gap.x,mounting_plate.y/2-mounting_plate_screw_gap.y,0])
          clearance_hole(nominal_d=4, h=50 , fit = "normal");
      }
    translate ([0,0,-25]) rounded_rectangle(mounting_plate-removal+[0,0,50], 3);;
      //translate ([-mounting_plate.x/2,-mounting_plate.y/2,9])
  }
  if (remove == false) {
    color(panel_color_holes())
    //        translate ([mounting_plate.x/2,mounting_plate.y/2,0])
    difference() {
      //translate ([-mounting_plate.x/2,-mounting_plate.y/2,0])
      rounded_rectangle(mounting_plate, 3);
      //translate ([-mounting_plate.x/2,-mounting_plate.y/2,0])
      mirror_xy()
        translate ([mounting_plate.x/2-mounting_plate_screw_gap.x,mounting_plate.y/2-mounting_plate_screw_gap.y,25])
          clearance_hole(nominal_d=4, h=50 , fit = "normal");
      }
    }
  }





module PTFE_holes(){
  holes_row_position = 67.5-extrusion_width() ; // modify this to change where the holes are on the halo - 60 for NEMA23 size, less for NEMA17 minimal
  translate([-frame_size().x / 2 - holes_row_position , frame_size().y / 2 - 215 , 25])
    {
      clearance_hole(nominal_d=8.5, h=50);  // for M10 tap thread
      translate([0, 20 , 0])
        clearance_hole(nominal_d=8.5, h=50);  // for M10 tap thread
      translate([0, 40 , 0])
        clearance_hole(nominal_d=4.3, h=50);  // for M6 tap thread
      translate([0, 60 , 0])
        clearance_hole(nominal_d=4.3, h=50);  // for M6 tap thread
      }
}



module panel_mounting_screws(x, y) {
  // How far from center of first hole to center of last hole
  extent_x = x - 2 * panel_screw_offset();
  extent_y = y - 2 * panel_screw_offset();

  // How many screws in each direction
  screws_x = 4;
  screws_y = 4;

  // How far between screws
  screw_spacing_x = extent_x / (screws_x - 1) - 17;
  screw_spacing_y = extent_y / (screws_y - 1) - 15;
  //FIXME change from 3.25mm holes to PARAMETRIC

  // long holes on X axis
  mirror_y() {
    for (a =[0:(screws_x - 1)]) {
      translate ([-32,0,0])
      translate ([(-x/2) + panel_screw_offset() + (screw_spacing_x * a) + extrusion_width() / 2, y / 2 - extrusion_width() / 2, -epsilon])
        // FIXME - this should be a hole() not a cylinder
        //cylinder(h=halo_size().z + 2 * epsilon, d=clearance_hole_size(extrusion_screw_size()));
        longscrewhole((frame_size().y-155)/3,3,0.25); // screwhole FIXME
    }
  }

    mirror_y(){
        for (a =[0:(screws_x - 1)]) {
          translate ([-32,0,0])
          translate ([-x/2 + panel_screw_offset() + (screw_spacing_x * a) + extrusion_width() / 2, y / 2 + extrusion_width()/2 , -epsilon])
            // FIXME - this should be a hole() not a cylinder
            //cylinder(h=halo_size().z + 2 * epsilon, d=clearance_hole_size(extrusion_screw_size()));
              longscrewhole((frame_size().y-160)/3,3,0.25); // screwhole FIXME
        }
      }
    //}
  // long holes on Y axis
  mirror_x() {
    for (a =[0:(screws_y - 1)]) {
      translate ([0,-30,0])
      translate ([x / 2 - extrusion_width() / 2, -y / 2 + panel_screw_offset() + (screw_spacing_y * a) + extrusion_width() / 2, -epsilon])
        // FIXME - this should be a hole not a cylinder
        //cylinder(h=halo_size().z + 2 * epsilon, d=clearance_hole_size(extrusion_screw_size()));
      rotate ([0,0,90])
        longscrewhole((frame_size().y-185)/3,3,0.25);  // screwhole FIXME
        translate ([0,-30,0])
        translate ([ - extrusion_width() / 2 + halo_size().x / 2, -y / 2 + panel_screw_offset() + (screw_spacing_y * a) + extrusion_width() / 2, -epsilon])
          rotate ([0,0,90])
          longscrewhole((frame_size().y-185)/3,3,0.25);  // screwhole FIXMEME
    }
  }





// IDLER HOLES with 2.5mm holes for 3mm tap.
  translate([-frame_size().x / 2, 0, 0]) {
    mirror_y() {
      translate([-side_panel_thickness() - NEMA_width(NEMAtypeXY())/2 + halo_idler_offset_outer(), motor_pulley_link() + 11 , -5])
        cylinder(d=3.4, h=35);   //// FURTHEST IDLER

    translate([-extrusion_width()+halo_idler_offset_inner(), motor_pulley_link(),-5])
      cylinder(d=3.4, h=35);   //// inner IDLER
    }
  }

}

module centre_plate(){
  difference() {
    mounting_plate(centre_plate_size(),overlap(),false);
    // PTFE holes
    mirror_y(){
      translate([5, 20 , 0])
      tapping_hole(nominal_d=10, h=50); // Create M10 tap thread for PC4-M10 pneumatic coupler
      translate([5, 40 , 0])
        tapping_hole(nominal_d=10, h=50);  // Create M10 tap thread for PC4-M10 pneumatic coupler
      translate([25, 20 , 0])
        tapping_hole(nominal_d=6, h=50);  // Create M6 tap thread for PC4-M6 pneumatic coupler
      translate([25, 40 , 0])
        tapping_hole(nominal_d=6, h=50);  // Create M6 tap thread for PC4-M6 pneumatic coupler
        }
    }
}


module motor_plate(moveX = 18, moveY = 11){
  difference (){
  mounting_plate(motor_mount_size(),overlap(),false);
  // make motor holes for NEMA motors.
    translate([-motor_mount_position().x -extrusion_width(), -motor_mount_position().y , 0])
       {
        translate([side_panel_thickness() + extrusion_width() + NEMA_width(NEMAtypeXY())/2 + moveX, motor_pulley_link() + moveY  , 0])
          long_motor_holes(NEMAtypeXY());
        }
}
}


module long_motor_holes(type) {
  function part_thickness() = 50;  // part_thickness  of aluminium part in mm
  function NEMAadjust() = 8 ;
  //translate ([-extrusion_width() - side_panel_thickness() - NEMA_width(type)/2, 0, 0])
translate([0,0,-part_thickness()/2])
linear_extrude(part_thickness()) {
  hull() {
    translate([NEMAadjust()/2, 0,-part_thickness()/2])
      circle(d=NEMA_boss_radius(type) * 2 + 3);

    translate([-NEMAadjust()/2, 0, -epsilon])
      circle(d=NEMA_boss_radius(type) * 2 + 3);
   }
mount_length = -18;
translate([(-mount_length/2-NEMAadjust())/2, 0])
  mirror_xy() {
    hull() {
      // FIXME this needs to be a hole() not a cylinder
      //cylinder(d=3.3, h=side_panel_thickness() + 2 * epsilon);
      translate([NEMA_hole_pitch(type)/2+NEMAadjust()/2, NEMA_hole_pitch(type)/2])
        circle(d=3.3);
      translate([NEMA_hole_pitch(type)/2-NEMAadjust()/2, NEMA_hole_pitch(type)/2 ])
        circle(d=3.3);
    }
  }
}
}

demo(){
//translate([0, 0, frame_size().z / 2 - halo_size().z])
  halo();
}
