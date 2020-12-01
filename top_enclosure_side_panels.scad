// vim: set nospell:
include <config.scad>
use <nopscadlib/vitamins/stepper_motor.scad>
include <nopscadlib/vitamins/stepper_motors.scad>
use <fan_guard_removal.scad>
use <lib/holes.scad>
use <lib/layout.scad>
use <door_hinge.scad>
use <screwholes.scad>
use <constants.scad>
use <side_panel.scad>
use <demo.scad>

function panel_screw_extent(panel_length) = panel_length - 2 * panel_screw_offset() ;
function panel_screw_count(panel_length) = ceil(panel_screw_extent(panel_length) / max_panel_screw_spacing()) + 1 ;
function panel_screw_spacing(panel_length) = panel_screw_extent(panel_length) / (panel_screw_count(panel_length) - 1);
function gap() = 0.5 ;
function hinge_adjustment() = (extrusion_width()/2+gap()/2-0.35);
function hinge_position() = 135;

// BACK TOP HALF OF ENCLOSURE
module top_panel_half1() {
  color(panel_color())
    difference(){
        linear_extrude(side_panel_thickness()){
            difference(){
              universal_panel_2d(enclosure_size().x, enclosure_size().y/2-gap()/2);   //PANEL
                color(panel_color_holes())
                  universal_panel_mounting_screws_2d(enclosure_size().x, enclosure_size().y/2-gap()/2); // MOUNTING HOLES
                  // HINGE SLOTS
                  mirror_x()
                    translate([enclosure_size().x/2-hinge_position(),-enclosure_size().y/4+hinge_adjustment(),0])
                      hull() {
                        translate([70,0,0])
                          circle((3.4/2));
                        circle((3.4/2));
                      }
                }
          }
      }
}
/*
module top_panel_half2_window_2d(){
  window_real_2d(enclosure_size().x, enclosure_size().y/2-epsilon);
}
module full_front_top_enclosure_panel_window_2d() {
  window_real_2d(enclosure_size().x-extrusion_width()*2, enclosure_size().z-extrusion_width()*2);
}
*/

// FRONT TOP HALF OF ENCLOSURE
module top_panel_half2() {
  color(panel_color())
      difference(){
        linear_extrude(side_panel_thickness()){
            difference(){
              universal_panel_2d(enclosure_size().x, enclosure_size().y/2-gap()/2); //PANEL
                color(panel_color_holes())
                  universal_panel_mounting_screws_2d(enclosure_size().x, enclosure_size().y/2-gap()/2); // MOUNTING HOLES
                window_2d(enclosure_size().x, enclosure_size().y/2-epsilon);  //WINDOW HOLE
                mirror_x()
                  translate([enclosure_size().x/2-hinge_position(),-enclosure_size().y/4+hinge_adjustment(),0])
                    hull() {
                      translate([70,0,0])
                        circle((3.4/2));
                      circle((3.4/2));
                    }
                    }
                }
          }
          translate([0,0,-acrylic_door_thickness()-side_panel_thickness()])  // WINDOW
            color(acrylic2_color())
              linear_extrude(acrylic_door_thickness())
                window_real_2d(enclosure_size().x, enclosure_size().y/2-epsilon);
      }


module full_front_top_enclosure_panel() {
  color(panel_color())
      difference(){
        linear_extrude(side_panel_thickness()){
            difference(){
              universal_panel_2d(enclosure_size().x, enclosure_size().z+extrusion_width());
                color(panel_color_holes())
                  translate ([0,-extrusion_width()/2]) {
                     universal_panel_mounting_screws_2d(enclosure_size().x-extrusion_width()*2, enclosure_size().z);
                     window_2d(enclosure_size().x-extrusion_width()*2, enclosure_size().z-extrusion_width()*2);
// handle holes
  mirror_y()
    translate ([0,-enclosure_size().z / 2+extrusion_width()*1.75])
      mirror_x()
        translate([60,0])
          clearance_hole_2d(nominal_d = 5, fit = "normal");
          }
              }
          }
      }
      translate([0,-extrusion_width()/2,0]) translate([0,0,-acrylic_door_thickness()-side_panel_thickness()])
        color(acrylic2_color())
          linear_extrude(acrylic_door_thickness())
            window_real_2d(enclosure_size().x-extrusion_width()*2, enclosure_size().z-extrusion_width()*2);
}

module right_side_top_enclosure_panel() {
  color(panel_color())
  difference(){
    linear_extrude(side_panel_thickness()){
      translate ([0,extrusion_width()/2])
        difference(){
          universal_panel_2d(enclosure_size().y, enclosure_size().z + extrusion_width());
          translate ([0,-extrusion_width()/2])
            color(panel_color_holes())
              universal_panel_mounting_screws_2d(enclosure_size().y,enclosure_size().z);
            }
      }
  translate([enclosure_size().y/4,0,side_panel_thickness()-epsilon])
    fan_guard_removal(size = 120,thickness = side_panel_thickness()*2);
    }
}

module left_side_top_enclosure_panel() {
  color(panel_color())
    linear_extrude(side_panel_thickness()){
      translate ([0,extrusion_width()/2])
        difference(){
          universal_panel_2d(enclosure_size().y, enclosure_size().z + extrusion_width());
          translate ([0,-extrusion_width()/2])
            color(panel_color_holes())
              universal_panel_mounting_screws_2d(enclosure_size().y,enclosure_size().z);
            }
      }
}

module back_top_enclosure_panel() {
  color(panel_color())
  difference(){
    linear_extrude(side_panel_thickness()){
      translate ([0,-extrusion_width()/2])
        difference(){
          universal_panel_2d(enclosure_size().x, enclosure_size().z);
            color(panel_color_holes())
              universal_panel_mounting_screws_2d(enclosure_size().x, enclosure_size().z);
              mirror_x()
                translate([enclosure_size().x/2-hinge_position(),enclosure_size().z/2-hinge_adjustment(),0])
                  hull() {
                    translate([70,0,0])
                      circle((3.4/2));
                    circle((3.4/2));
                  }
            }
      }
  translate([0,0,side_panel_thickness()-epsilon])
    fan_guard_removal(size = 120,thickness = side_panel_thickness()*2);
    }
}

/*
module enclosure_hinges() {
  mirror_x()
    translate ([enclosure_size().x/2-extrusion_width()/2-50-86.25/2, enclosure_size().y/2+6,enclosure_size().z/2-extrusion_width()/2])
      rotate([0, 270, 270])
        panelside_hinge(screw_distance = 86.25 ,acrylic_door_thickness=6,extension = 5,screw_type=3);

  mirror_x()
    translate ([enclosure_size().x/2-extrusion_width()/2-50-86.25/2, enclosure_size().y/2+30,enclosure_size().z/2-extrusion_width()/2+15])
      rotate([0, 270, 270])
        rotate([0, 90, 0])  doorside_hinge();

}
*/
module enclosure_side_panels() {
  translate([0, enclosure_size().y/4, enclosure_size().z / 2 + extrusion_width()])
    top_panel_half1();
  rotate ([0,0,180])
    translate([0, enclosure_size().y/4, enclosure_size().z / 2 + extrusion_width()])
      top_panel_half2();
  translate([0, -(enclosure_size().y)/2, extrusion_width()/2])
    rotate([90,0,0]) full_front_top_enclosure_panel();
  translate ([-enclosure_size().x /2 - side_panel_thickness(), 0, 0])
    rotate([90,0,90]) left_side_top_enclosure_panel();
  translate ([enclosure_size().x / 2, 0, 0])
    rotate([90,0,90]) right_side_top_enclosure_panel();
  translate ([0, enclosure_size().y / 2 + side_panel_thickness(),extrusion_width()/2]) rotate([90,0,0])
    back_top_enclosure_panel();

    mirror_x()
      translate ([enclosure_size().x/2-75,0,enclosure_size().z/2+18+side_panel_thickness()])
        rotate ([0,0,90])
          misumi_detachable_hinge();

    mirror_x()
      translate ([enclosure_size().x/2-75,enclosure_size().y/2+5,enclosure_size().z/2+0])
        rotate ([0,90,90])
          misumi_detachable_hinge();


}




demo(){
  enclosure_side_panels();
  }
