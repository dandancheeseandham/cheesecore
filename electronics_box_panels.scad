// vim: set nospell:
include <constants.scad>
use <config.scad>
use <screwholes.scad>
include <nopscadlib/core.scad>
include <nopscadlib/vitamins/iec.scad>
include <nopscadlib/vitamins/iecs.scad>

use <lib/holes.scad>
use <lib/layout.scad>
use <fan_guard_removal.scad>
use <electronics_box_corner.scad>
use <electronics_box_assembly.scad>
use <demo.scad>


module top_panel() {
  color(acrylic_color())
    linear_extrude (acrylic_thickness())
      difference() {
        electronics_cabinet_side_panel_2d(box_size_y());
        remove_vents_top_panel_2d(); {
          // STEPPER CABLES HOLES
          translate ([box_size_y()/2,0])
            mirror_x()
              translate ([box_size_y()/2 - 20,box_depth()])
                circle(d=15);
        }
      }
}

module bottom_panel() {
  color(acrylic_color())
    linear_extrude (acrylic_thickness())
      difference() {
        electronics_cabinet_side_panel_2d(box_size_y()); {
          // STEPPER CABLES HOLES
          translate ([box_size_y()/2,0])
            mirror_x()
              translate ([box_size_y()/2 - 105,box_depth()])
                circle(d=15);
                //FANS GUARDS
                translate ([box_size_y()/2 + 80, box_depth()-27])
                  fan_guard_2d_fast(size = 40);
                translate ([box_size_y()/2 - 80,box_depth()-27])
                  fan_guard_2d_fast(size = 40);
        }
      }
}


module IEC_hole_2d() {
  IEC_cutout_distance=20; // hole starts at this distance from bottom of panel
  cut_out_width=53;
  cut_out_depth=32;
  hole = 4;
  //IEC hole
  translate ([box_size_z()-IEC_cutout_distance-cut_out_width,(box_depth()-cut_out_depth)/2]) {
    square ([cut_out_width,cut_out_depth]);
  translate ([cut_out_width/2,cut_out_depth/2])
    mirror_y()
      translate([0,-cut_out_depth/2-hole])
        clearance_hole_2d(nominal_d=3);
    }
}

module RJ45_cutout_2d() {
//  RJ45 CAT5e Socket to RJ45 CAT5e Socket Feedthrough Connector, Metal, Silver, Plain Holes -  CP30220M3
// https://cpc.farnell.com/cliff-electronic-components/cp30220m3/feedthru-rj45-cat5e-metal-m3/dp/CN22348
translate ([90,box_depth()-28.5]) {
  circle (d=24.1);
    translate ([12,-8])
      circle (d=3.4);
    translate ([-12,8])
      circle (d=3.4);
    }
}

module emergency_stop_cutout() {
//  RJ45 CAT5e Socket to RJ45 CAT5e Socket Feedthrough Connector, Metal, Silver, Plain Holes -  CP30220M3
// https://cpc.farnell.com/cliff-electronic-components/cp30220m3/feedthru-rj45-cat5e-metal-m3/dp/CN22348
translate ([25,box_depth()-28.5,-10]) {
  cylinder (d=19.1,h=30);
  }
}

module right_side_panel() {
  color(acrylic_color())
     linear_extrude(acrylic_thickness())
       difference() {
         electronics_cabinet_side_panel_2d (box_size_z());
         IEC_hole_2d();
  }
 *rotate ([0,0,90]) translate ([box_depth()/2+1.55,-244,side_panel_thickness()]) iec_assembly(IEC_cheesecore, 3);
}

module left_side_panel() {
   color(acrylic_color())
      linear_extrude(acrylic_thickness())
        difference() {
          electronics_cabinet_side_panel_2d (box_size_z());
          RJ45_cutout_2d();
          //emergency_stop_cutout();
        }
}

module vents_2d(vent_length = 78 ,vent_height = 3, gap_between_vents = 4.5, vent_offset = [-40,80] , number_of_vents = 23, number_of_vent_sections = 1, gap_between_vent_sections = 10) {
// add psu_placement().x, psu_placement().y to psu placement side
    translate([vent_offset.x,vent_offset.y]) {
      for(ventrow = [0 : (number_of_vent_sections-1)]){
            translate([((number_of_vent_sections-1))*gap_between_vent_sections+2.5,box_depth(),0]) {
              for(vents = [0 : number_of_vents])
                translate ([ventrow*(vent_length+gap_between_vent_sections),0-(vents*(vent_height + gap_between_vents)),0])
                  hull(){
                    circle (d=3.4);
                    translate ([vent_length,0])
                      circle (d=3.4);
                  }
            }
      }
    }
}

module remove_vents_top_panel_2d() {
  nvs = 4; // number_of_vent_sections
  gbvs = 10;  // gap_between_vent_sections
  totalgap = (gbvs * (nvs+2) );
  minimum_side_gap = 15 ;
  vl = (box_size_y() - totalgap - minimum_side_gap) / nvs ; // vent_length

 vh = 1.5 ;
 gbv = 4.5 ;
  nov = 6;
  tv = (nov * vh) + (gbv * nov) ;
  vo = [-gbvs , -box_depth()/2+16];  //vent_offset
  echo ("vl",vl);

  //vl = (box_size_y()-50)/4 ; // vent_length
  //vl = box_size_y()/2 ;  // vent_length
  //vo = [-(box_size_y()-50)/8+8,box_depth()/2-43];  //vent_offset
  // (vl*4 + gap_between_vents*3)/2


  vents_2d(vent_length = vl ,vent_height = vh,gap_between_vents = gbv, vent_offset = vo , number_of_vents = nov, number_of_vent_sections = nvs, gap_between_vent_sections = gbvs );
}

module electronics_cover_panel_2d() {
  difference(){
    rounded_square([box_size_y() + acrylic_thickness() + expand_acrylic_cover_adjustment() - fitting_error(), box_size_z() + acrylic_thickness() + expand_acrylic_cover_adjustment() - fitting_error()], acrylic_cover_corner_rounding());
    mirror_x() {
      translate ([-11,4])
      translate ([-box_size_y()/2, box_size_z() / 2 ])
        keyhole();
        //clearance_hole_2d(3);  //electronics box corners
    }
    mirror_x() {
      translate ([11,-17])
        translate ([box_size_y()/2, -box_size_z() / 2 ])
          keyhole();
    }
    *translate ([psu_placement().x, psu_placement().y]) vents_2d(vent_length = 100 ,vent_height = 3, gap_between_vents = 4.5, vent_offset = [-53,40] , number_of_vents = 24, number_of_vent_sections = 1, gap_between_vent_sections = 10);
  }
}

module electronics_cover_panel(){
  color(acrylic2_color())
    linear_extrude(acrylic_thickness())
        electronics_cover_panel_2d();
  }

module keyhole() {
  circle (d=7);
  hull(){
    circle (d=3.4);
    translate ([0,7])
      circle (d=3.4);
  }
}

module remove_vents_2d(vent_length = 78,vent_height = 3,gap_between_vents = 4.5, vent_offset = [-40,80] , number_of_vents = 23) {
  translate([psu_placement().x+vent_offset.x,psu_placement().y+vent_offset.y]) {
      for(vents = [0 : number_of_vents])
        translate ([0,0-(vents*(vent_height + gap_between_vents))])
        hull(){
          circle (d=3.4);
          translate ([vent_length,0])
            circle (d=3.4);
        }
    }
}

module filament_cover_panel() {
  // FIXME : draw in 2d then extrude
  // vent configuration
  translate([0,-25,0])
    rotate([180-270,0,0])
      difference() {
        difference() {
          color(acrylic2_color())
            panel_cover([box_size_y() + acrylic_thickness()/2 + expand_acrylic_cover_adjustment() - fitting_error(), box_size_z() + acrylic_thickness()/2 + expand_acrylic_cover_adjustment() - fitting_error(), acrylic_thickness()], acrylic_cover_corner_rounding());
        }
      }
}

module electronics_cabinet_side_panel_2d(length){
  topscrewhole_x = 4.5 ;
  topscrewhole_y = 14.5 ;
  color(acrylic_color())  {
    difference() {
      square ([length-fitting_error(),box_depth()-fitting_error()]);
      translate ([length/2,box_depth()/2])
      translate ([0,1])
        mirror_xy()
          translate ([length/2-topscrewhole_x,box_depth()/2-topscrewhole_y,20])
            clearance_hole_2d(nominal_d=3);
    }
  }
}

module enclosure_electronics_storage_panel() {
  translate([0,-box_depth()-acrylic_thickness()/2,0])
    color(acrylic2_color())
      rotate([270,0,0])
        panel_cover([frame_size().y-fitting_error(), frame_size().z + feetheight()-fitting_error(), acrylic_thickness()],1);
}

module panel_cover(panel_dims,panel_rounding) {
  linear_extrude(acrylic_thickness())
    rounded_square([panel_dims.x,panel_dims.y],panel_rounding);
  }

demo(){

//IEC_hole_2d();
//remove_vents_top_panel_2d();
  //vents_2d();
  //difference() {
    //electronics_cabinet_side_panel_2d(box_size_y());
    //remove_vents_top_panel_3d();
  //}
}
