// vim: set nospell:
include <config.scad>
use <nopscadlib/vitamins/stepper_motor.scad>
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
include <nopscadlib/vitamins/stepper_motors.scad>
include <nopscadlib/vitamins/ssr.scad>
use <lib/holes.scad>
use <lib/layout.scad>
use <door_hinge.scad>
use <screwholes.scad>
use <halo2.scad>
use <demo.scad>
use <electronics_box_panels.scad>
use <door_hinge.scad>
use <filament_holder.scad>
use <filament_holder2kg.scad>
use <fan_guard_removal.scad>
use <mounting_holes.scad>
use <side_panel.scad>

function panel_screw_extent(panel_length) = panel_length - 2 * panel_screw_offset() ;
function panel_screw_count(panel_length) = ceil(panel_screw_extent(panel_length) / max_panel_screw_spacing()) + 1 ;
function panel_screw_spacing(panel_length) = panel_screw_extent(panel_length) / (panel_screw_count(panel_length) - 1);
/*
function spool_topx() = 105;
function spool_topy() = 125;
function spool_bottomx() = 105;
function spool_bottomy() = -90;
*/
function spool_topx() = 105;
function spool_topy() = 121;
function spool_bottomx() = 105;
function spool_bottomy() = -86;


// BOTTOM PANEL
module bottom_panel() {
  color(panel_color())
  difference() {
    //panel(frame_size().x, frame_size().y,extend_bottom_panel_x(),0);
     //universal_panel(frame_size().x, frame_size().y,extend_bottom_panel_x());
     linear_extrude(side_panel_thickness())
       difference() {
         universal_panel_2d(x= frame_size().x,y= frame_size().y);
         universal_panel_mounting_screws_2d(x= frame_size().x,y= frame_size().y, cornercubes = true);
       }

// make Z motor holes to mount NEMA motors
    color(panel_color_holes()) {
      translate([bed_offset().x, bed_offset().y, 0]) {
        // left side holes
        mirror_y() {
          translate([-frame_size().x / 2 + extrusion_width() + leadscrew_x_offset() , bed_ear_spacing() / 2, 0])
            motor_holes(NEMAtypeZ());
        }
        // right side holes
        translate([frame_size().x / 2 - extrusion_width() - leadscrew_x_offset(), 0, 0])
          motor_holes(NEMAtypeZ());
      }
      //printer_name();
    }
    x = frame_size().x;
    y = frame_size().y;
    extent_x = x - 2 * panel_screw_offset();
    extent_y = y - 2 * panel_screw_offset();

    // How many screws in each direction
    screws_x = ceil(extent_x / max_panel_screw_spacing()) + 1;
    screws_y = ceil(extent_y / max_panel_screw_spacing()) + 1;

    // How far between screws
    screw_spacing_x = extent_x / (screws_x - 1);
    screw_spacing_y = extent_y / (screws_y - 1);
// FIXME: IF BRACES THEN
if (include_bottom_braces()) {
  mirror_x() {
      for (a =[0:(screws_y - 1)]) {
        translate ([frame_size().x / 2 - extrusion_width() * 1.5 - 2 * leadscrew_x_offset(),-y / 2 + panel_screw_offset() + (screw_spacing_y * a), -epsilon])
          // FIXME - this should be a hole not a cylinder
          cylinder(h=side_panel_thickness() + 2 * epsilon + 20, d=clearance_hole_size(extrusion_screw_size()));
        }
      }
    }
  }
}

module front_panel() {
  assert(front_window_size().x <= frame_size().x - 2 * extrusion_width(), str("Window cannot overlap extrusion in X: "));
  assert(front_window_size().y <= frame_size().z - 2 * extrusion_width(), "Window cannot overlap extrusion in Z");
  min_y_gap = (frame_size().z - front_window_size().y) / 2 - abs(front_window_offset().y);
  assert(min_y_gap >= extrusion_width(), "Window cannot overlap extrusion in Z");

color(panel_color())
linear_extrude(side_panel_thickness())
  difference() {
    //panel(frame_size().x, frame_size().z,extend_front_and_rear_x(),extendz());
    universal_panel_2d(x= frame_size().x,y= frame_size().z);
    //,addx = extend_front_and_rear_x(),addy = extendz());
    universal_panel_mounting_screws_2d(x= frame_size().x,y= frame_size().z, cornercubes = true);
    //remove window in front panel
    //color(panel_color_holes())
      //translate ([front_window_offset().x, front_window_offset().y, side_panel_thickness() / 2])
      translate ([front_window_offset().x, front_window_offset().y])
        rounded_square([front_window_size().x, front_window_size().y], front_window_radius());

/*
// IF EXTENDED PANELS AND NEMA23 MOTORS, MAKE A HOLE!
    if ((extend_front_and_rear_x() != 0)&&(NEMAtypeXY()[0] == "NEMA23")) {
      echo("NEMAtypeXY()[0]",NEMAtypeXY()[0]);
      translate([288,210, side_panel_thickness() / 2])
      rounded_rectangle([80,80,side_panel_thickness() + 2 * epsilon], front_window_radius());
    }
*/
  }
  // DEBUG cube
  //translate([-frame_size().x / 2 , -frame_size().z / 2 , side_panel_thickness()])  cube ([10,frame_size().z,10]);

}

module printer_name(){
  // Deboss a name in the bottom panel
  deboss_depth = 10;
  //translate([0, -frame_size().y/2 + extrusion_width() + 35, side_panel_thickness() - deboss_depth + epsilon]) // place on bottom panel
   translate([0, -frame_size().y/2-100, -frame_size().z/2 - side_panel_thickness() - feetheight()])
    linear_extrude(deboss_depth)
      text($branding_name, halign="center", size=35, font = "Helvetica");
}


module hinges(hinge_extension = 0) {
  translate([0, -frame_size().y/2, 0])
    rotate([90, 0, 0]) {
      mirror_xy() {
        translate([-frame_size().x / 2 + extrusion_width() /2, frame_size().z / 2 - panel_screw_spacing(frame_size().z)/2 - panel_screw_offset() , side_panel_thickness()])
          panelside_hinge(screw_distance = panel_screw_spacing(frame_size().z), acrylic_door_thickness=acrylic_door_thickness(), extension = hinge_extension , screw_type=3);
      }
      mirror_xy() {
        translate([hinge_extension-frame_size().x / 2 , frame_size().z / 2 - panel_screw_spacing(frame_size().z)/2 - panel_screw_offset(), side_panel_thickness() + acrylic_door_thickness()])
          doorside_hinge() ;
        }
    }
}

// One door - the right side as facing printer
// Origin is the centerline between the doors at the middle of the height. So not quite on the door, but rather in the gap between where they meet together
module door() {
  door_gap = 1; // How big a gap do we want between doors?
  door_overlap = 10; // How far do we want the doors to overlap the panel edges?
  door_radius_mating_corners = 2.5; // radius of the corners where the panels come together
  door_radius_outside_corners = front_window_radius() + door_overlap;

  difference() {
    // Outline of the door
    color(acrylic2_color())  {
      difference(){
      linear_extrude(acrylic_door_thickness()) {
        hull() {
          mirror_y() {
            // The smaller corners where the doors meet
            translate([door_radius_mating_corners + door_gap / 2, front_window_size().y / 2 + door_overlap - door_radius_mating_corners])
              circle(r = door_radius_mating_corners);
            // Larger corners that mirror the opening
            translate([front_window_size().x / 2 - front_window_radius(), front_window_size().y / 2 - door_overlap])
              circle(r = door_radius_outside_corners);
          }
        }
      }

translate ([0,-5,0])
mirror_y()
translate ([front_window_size().x/2+door_overlap-27.5, (86.25*1.5) ,0]) newpanelholes();
//door knob holes
translate ([20,front_window_size().y/2-10,0]) cylinder(d=3,h=30);
translate ([20+20,front_window_size().y/2-10,0]) cylinder(d=3,h=30);
//poly_cylinder(1.5, 30);
//-y / 2 + panel_screw_offset() + (screw_spacing_y * a)
//

}
    }

    // Hinge holes
    // FIXME: add these

    // Door pull holes
    // FIXME: add these
  }
}

// One door - the right side as facing printer
// Origin is the centerline between the doors at the middle of the height. So not quite on the door, but rather in the gap between where they meet together
module single_door() {
  door_gap = 1; // How big a gap do we want between doors?
  door_overlap = 10; // How far do we want the doors to overlap the panel edges?
  door_radius_mating_corners = 2.5; // radius of the corners where the panels come together
  door_radius_outside_corners = front_window_radius() + door_overlap;

  difference() {
    // Outline of the door
    color(acrylic2_color())  {
      difference(){
      linear_extrude(acrylic_door_thickness()) {
        hull() {
           {
            // The smaller corners where the doors meet
            translate([door_radius_mating_corners + door_gap / 2, front_window_size().y / 2 + door_overlap - door_radius_mating_corners])
              circle(r = door_radius_mating_corners);
            // Larger corners that mirror the opening
            translate([front_window_size().x / 2 - front_window_radius(), front_window_size().y / 2 - door_overlap])
              circle(r = door_radius_outside_corners);
          }
        }
      }

translate ([0,-5,0])
mirror_y()
translate ([front_window_size().x/2+door_overlap-27.5, (86.25*1.5) ,0]) newpanelholes();
translate ([20,front_window_size().y/2-10,0]) cylinder(d=3,h=30);
translate ([20+20,front_window_size().y/2-10,0]) cylinder(d=3,h=30);
//poly_cylinder(1.5, 30);
//-y / 2 + panel_screw_offset() + (screw_spacing_y * a)
//

}
    }

    // Hinge holes
    // FIXME: add these

    // Door pull holes
    // FIXME: add these
  }
}




// module for calling both doors.
module doors() {
translate([0, -frame_size().y / 2 - side_panel_thickness() - epsilon, 0])
  rotate([90, 0, 0])
  {
    translate(front_window_offset())
    mirror_x() {
    door();
    color(printed_part_color()) translate ([10,front_window_size().y/2-15,10]) door_knob();
  }
  }
}

module back_panel() {
  color(panel_color())
difference(){
  linear_extrude(side_panel_thickness())
    difference() {
      universal_panel_2d(x= frame_size().x,y= frame_size().z);
      universal_panel_mounting_screws_2d(x= frame_size().x,y= frame_size().z, cornercubes = true);
    }
    translate([0,frame_size().z/2-40,-side_panel_thickness()+epsilon])
      camera_mount_holes();
    translate([0,-frame_size().z/2+100,+side_panel_thickness()-epsilon])
      fan_guard_removal(size = 120,thickness = side_panel_thickness()*2);
    }
}



module back_panel_old() {
//if no back electronic box then just create the panel
if (back_panel_enclosure() == false) {
  color(panel_color())

    difference(){
    //panel(frame_size().x, frame_size().z,extend_front_and_rear_x(),extendz());
    universal_panel(x= frame_size().x,y= frame_size().z,addx = extend_front_and_rear_x(),addy = extendz());
    translate([0,frame_size().z/2-40,-side_panel_thickness()+epsilon])
      camera_mount_holes();
    translate([0,-frame_size().z/2+100,+side_panel_thickness()-epsilon])
      fan_guard_removal(size = 120,thickness = side_panel_thickness()*2);

//MAKE HOLES FOR NEMA23 - PROBABLY UNNEEDED SOON
if ((extend_front_and_rear_x() != 0)&&(NEMAtypeXY()[0] == "NEMA23"))
    translate([288,210, side_panel_thickness() / 2])
    rounded_rectangle([80,80,side_panel_thickness() + 2 * epsilon], front_window_radius());
}
translate([0,frame_size().z/2-40,-side_panel_thickness()+epsilon])
camera_mount_cover();
  }
//if back electronic box then make holes
  if (back_panel_enclosure() == true) {
    color(panel_color())
    difference()
    {
      //panel(frame_size().x, frame_size().z,extend_front_and_rear_x(),extendz());
      universal_panel(x= frame_size().x,y= frame_size().z,addx = extend_front_and_rear_x(),addy = extendz());
      color(panel_color_holes())
      translate ([0,-movedown() ,0]){
        rotate([90,0,0]) mirror_xz() {
            //translate([190.5,-5,145.5]) rotate([-90,0,0]) cylinder(d=3,h=40);  // FIXME: Use polyhole, check mounting fits Meanwell too
            translate([screwy(),-40,screwz()]) rotate([-90,0,0]) cylinder(d=3,h=150);  // FIXME: Use polyhole, check mounting fits Meanwell too
          }
      }
    }
  }
}

module right_panel() {
  color(panel_color())
    difference(){
      linear_extrude(side_panel_thickness())
        difference() {
          #universal_panel_2d(x= frame_size().y,y= frame_size().z);
          universal_panel_mounting_screws_2d(x= frame_size().y,y= frame_size().z, cornercubes = true);
          translate ([0,-movedown() ,0]) mirror_xy() translate([screwy(),screwz()]) circle(d=3.4);  // FIXME: Use polyhole, check mounting fits Meanwell too
        }
        color(panel_color_holes())
          translate ([0,-movedown() ,0]) {
            translate(cable_bundle_hole_placement())
              mirror([0,0,1])
                hole(d=26, h=side_panel_thickness() + epsilon);
          translate(DuetE_placement())  pcb_holes(DuetE);
          translate(DuetE_placement()+[7.5,-16,0])  pcb_holes(Duet3E);
          translate(Duex5_placement()+[27.5,-36,0]) pcb_holes(Duet3Exp); // Duet3 Expansion
          translate(Duex5_placement())  pcb_holes(Duex5);
          if (rpi_placement() != [0,0,0]) translate(rpi_placement())
            rotate([0,0,180])
              pcb_holes(RPI3);
          //translate(rpi_placement()+[80,-40,13+5]) rotate([0,0,180]) pcb_holes(RPI3);
          //translate(psu_placement()+[0,0,20]) rotate([0,0,90]) psu_screw_positions(S_250_48) cylinder(40,3,3);  // FIXME: Use polyhole, check mounting fits Meanwell too
          translate(psu_placement()+[0,115,-10]) rotate([0,0,90]) cylinder(40,3,3);
    //FIXME: use the ssr_hole_position library, not hack it in like this.
        translate(ssr_placement() + [0,0,-20]) rotate ([0,0,90]) {
          mirror_x()
            translate ([47.5/2,0,0])
              cylinder(h=140,d=5);
        //electronic corner holes_row_position
        //#
         {

        }
    }
  }
}
}


    //translate(ssr_placement()) ssr_hole_positions(AQA411VL);
    // cube ([50,50,50]);
    //ssr_hole_positions(ssrs[0]);
    //*translate(Duet3Exp)  pcb_holes(Duet3Exp);


// ### FIXME : Use technique on acrylic housing
//rotate([90,0,0]) mirror_xz() {
    //translate([190.5,-5,145.5]) rotate([-90,0,0]) cylinder(d=3,h=40);  // FIXME: Use polyhole, check mounting fits Meanwell too
  //  translate([screwy(),-40,screwz()]) rotate([-90,0,0]) cylinder(d=3,h=150);  // FIXME: Use polyhole, check mounting fits Meanwell too
//  }


module pcb_holes(type) {
  // Holes for PCB's
    screw = pcb_screw(type);
    ir = screw_clearance_radius(screw); {
      pcb_screw_positions(type)
        cylinder(20,ir,ir);
    }
}


module left_panel(){
color(panel_color())
difference(){
  linear_extrude(side_panel_thickness())
    difference() {
      universal_panel_2d(x= frame_size().y,y= frame_size().z);
      universal_panel_mounting_screws_2d(x= frame_size().y,y= frame_size().z, cornercubes = true);
    }
    mirror_x ()
      translate ([spool_topx(),spool_topy(),0])
        bolt_holes();
    mirror_x()
      translate ([spool_bottomx(),spool_bottomy(),0])
        bolt_holes();
      }

}

module left_panel_old(){
color(panel_color())
difference() {

  //panel(frame_size(). y, frame_size().z, 0, extendz());
  universal_panel(x= frame_size().y,y= frame_size().z,addx = 0,addy = extendz());
  // remove 3 sets of holes for filament spool holders
  mirror_x ()
    translate ([spool_topx(),spool_topy(),0])
      bolt_holes();
  mirror_x()
    translate ([spool_bottomx(),spool_bottomy(),0])
      bolt_holes();
}
}

module spool_holders(){
  translate([-frame_size().x / 2 - side_panel_thickness(), 0, 0])
    rotate([90,0,90]){
  // Add the 1kg spools at the top
  *mirror_x ()
    translate ([spool_topx(),spool_topy(),0])
      spool1kg();
  //place filament spool holders
   mirror_x ()
    translate ([spool_topx(),spool_topy(),-side_panel_thickness()-2])
    { spool_holder_assembly();
      color("DarkGreen") spool1kg();
    }
  mirror_x()
    translate ([spool_bottomx(),spool_bottomy(),-side_panel_thickness()-2])
    { spool_holder_assembly();
      color("DarkGreen") spool1kg();
    }
    //  spool_holder_assembly(); //central spool holder for larger spools. e.g. This can be swapped with a 2kg spool holder
    //spool2kg();
    }
}


module all_side_panels() {
  translate([0, 0, -frame_size().z / 2 - side_panel_thickness()])
    bottom_panel();

  translate([0, -(frame_size().y)/2, 0])
    rotate([90,0,0])
      front_panel();

  translate([-frame_size().x / 2 - side_panel_thickness(), 0, 0])
    rotate([90,0,90])
      left_panel();

  translate ([frame_size().x / 2, 0, 0])
    rotate([90,0,90])
      right_panel();

  translate ([0, frame_size().y / 2 + side_panel_thickness(),0])
    rotate([90,0,0])
      back_panel();

  translate([0, 0, frame_size().z / 2 ])
    halo(modular = false);


}
/*
module cheese_spool_assembly_eh(){
  //spool();
  mirror_y()
    translate([-frame_size().x / 2 - side_panel_thickness() - 80, 110, 110])
      rotate ([0,0,270]){
        spool_holder_assembly();
        rotate ([90,0,0]) translate ([0,-10,0]) spool1kg();
      }

  translate([-frame_size().x / 2 - side_panel_thickness() - 80, 0, -30])
      rotate ([0,0,270]) {
        spool_holder_assembly();
        rotate ([90,0,0]) translate ([0,-10,15]) spool2kg();
}
}
*/


demo() {
  all_side_panels() ;
}
