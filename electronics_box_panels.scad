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
  color(acrylic_color())  difference() {
    electronics_cabinet_side_panel(box_size_y());
    remove_vents_top_panel();
    // STEPPER CABLES HOLES
    {
      translate ([box_size_y()/2,0,0])
        mirror_x()
          translate ([box_size_y()/2 - 20,box_depth(), -15])
            cylinder(h=30, r1=7.5, r2=7.5, center=false);

            //FANS GUARDS
            *translate ([50, box_depth()-27,acrylic_thickness()/2])
              fan_guard_removal(size = 40, thickness = acrylic_thickness()+2*epsilon);
            *translate ([115,box_depth()-27,acrylic_thickness()/2])
              fan_guard_removal(size = 40, thickness = acrylic_thickness()+2*epsilon);
    }
  }
}

module bottom_panel() {
   difference() {
  electronics_cabinet_side_panel(box_size_y());
  // STEPPER CABLES HOLES
  {
    translate ([box_size_y()/2-30,0,0])
      mirror_x()
        translate ([box_size_y()/2 - 105,box_depth(), -15])
          cylinder(h=30, r1=7.5, r2=7.5, center=false);
  }
  {
  //FANS GUARDS
    translate ([40, box_depth()-27,acrylic_thickness()/2])
      fan_guard_removal(size = 40, thickness = acrylic_thickness()+2*epsilon);
    translate ([110,box_depth()-27,acrylic_thickness()/2])
      fan_guard_removal(size = 40, thickness = acrylic_thickness()+2*epsilon);
  }

  *translate ([box_size_y()/2 - 70,box_depth(), -15])  cylinder(h=30, r1=15, r2=15, center=false);
  translate ([-67,0,0]) IEC_hole();
}
/*
//pretend "fans"
translate ([40-20, box_depth()-27-20,acrylic_thickness()/2])
  cube ([40,40,15]);
translate ([110-20,box_depth()-27-20,acrylic_thickness()/2])
  cube ([40,40,15]);
*/

  }

module IEC_hole() {
  IEC_cutout_distance=20; // hole starts at this distance from bottom of panel
  cut_out_width=53;
  cut_out_depth=32;
  hole = 4;
  //IEC hole
translate ([box_size_z()-IEC_cutout_distance-cut_out_width,15.25,-epsilon/2])
{
  cube ([cut_out_width,cut_out_depth,acrylic_thickness()+epsilon+25]);
// FIXME: this could just as well be a mirror_x of the two holes
//translate ([box_size_z()-IEC_cutout_distance-cut_out_width/2,9.65,0])
//translate ([+cut_out_width/2,0,0])
# translate([0, cut_out_depth/2,0])
    mirror_y() translate([cut_out_width/2,-cut_out_depth/2-hole,5]) clearance_hole(nominal_d=3, h=25);
    }
}

module RJ45_cutout() {
//  RJ45 CAT5e Socket to RJ45 CAT5e Socket Feedthrough Connector, Metal, Silver, Plain Holes -  CP30220M3
// https://cpc.farnell.com/cliff-electronic-components/cp30220m3/feedthru-rj45-cat5e-metal-m3/dp/CN22348

translate ([90,box_depth()-28.5,-10])
{
  cylinder (d=24.1,h=30);
  translate ([12,-8,0]) cylinder (d=3.4,h=30);
  translate ([-12,8,0]) cylinder (d=3.4,h=30);
    //cube([26,31,30]);
}
}

module emergency_stop_cutout() {
//  RJ45 CAT5e Socket to RJ45 CAT5e Socket Feedthrough Connector, Metal, Silver, Plain Holes -  CP30220M3
// https://cpc.farnell.com/cliff-electronic-components/cp30220m3/feedthru-rj45-cat5e-metal-m3/dp/CN22348

translate ([25,box_depth()-28.5,-10])
{
  cylinder (d=19.1,h=30);
  //translate ([12,-8,0]) cylinder (d=3.4,h=30);
  //translate ([-12,8,0]) cylinder (d=3.4,h=30);
    //cube([26,31,30]);
}
}



module right_side_panel() {
   difference() {
  electronics_cabinet_side_panel (box_size_z());
  IEC_hole();
  }
 rotate ([0,0,90]) translate ([box_depth()/2+1.55,-244,0]) iec_assembly(IEC_cheesecore, 3);
}

module left_side_panel() {
   color(acrylic_color())
    difference() {
      electronics_cabinet_side_panel (box_size_z());
*IEC_hole();
RJ45_cutout();
//emergency_stop_cutout();

    }
  }

module remove_vents_top_panel() {
    gap_between_vent_sections = 10;
    vent_length = (box_size_y()-(30+30+30+gap_between_vent_sections/2))/4;
    vent_height = 1.5;
    gap_between_vents = 3 ;
    vent_offset = [-vent_length/2,box_depth()/2,0];
    number_of_vent_sections_less_one = 3;


for(ventrow = [0 : number_of_vent_sections_less_one]){
      translate([number_of_vent_sections_less_one*gap_between_vent_sections+2.5,box_depth(),0]) {
        for(vents = [2 : 11])
          translate ([ventrow*(vent_length+gap_between_vent_sections),0-(vents*(vent_height + gap_between_vents)),0])
            longscrewhole(vent_length,vent_height,0);

      }
    }
  }


module remove_vents() {
  vent_length = 78;
  vent_height = 3;
  gap_between_vents = 4.5 ;
  vent_offset = [-40,80,0];

  rotate ([270,0,0])
    translate(psu_placement()+vent_offset) {
      for(vents = [0 : 23])
        translate ([0,0-(vents*(vent_height + gap_between_vents)),-20])
          longscrewhole(vent_length,vent_height,0);
    }
}

module remove_printed_vent_area() {
  translate(psu_placement() + vent_offset + [-91/2,-131/2,-40/2])
      cube ([91,131,40]);
}

module electronics_cover_panel() {
// FIXME : draw in 2d then extrude
// vent configuration
color(acrylic2_color())
 translate([0,-box_depth(),0])
rotate ([180,0,0])
  difference() {
      difference() {

      panel_cover([box_size_y() + acrylic_thickness()*2 + expand_acrylic_cover_adjustment()*2 - fitting_error(), box_size_z() + acrylic_thickness()*2 + expand_acrylic_cover_adjustment()*2 - fitting_error(), acrylic_thickness()], acrylic_cover_corner_rounding());
    }
    place_four_holes_for_electronics_corners();
      if (laser_cut_vents() == true) remove_vents();
      if (laser_cut_vents() == false) remove_printed_vent_area();
    }

}

module filament_cover_panel() {
// FIXME : draw in 2d then extrude
// vent configuration
translate([0,-25,0])
rotate ([180,0,0])
  difference() {
      difference() {
      color(acrylic2_color())
      panel_cover([box_size_y() + acrylic_thickness()/2 + expand_acrylic_cover_adjustment()*2 - fitting_error(), box_size_z() + acrylic_thickness()/2 + expand_acrylic_cover_adjustment()*2 - fitting_error(), acrylic_thickness()], acrylic_cover_corner_rounding());
    }
        }

}


module electronics_cabinet_side_panel(length){
  // FIXME: draw this in 2d then extrude
  topscrewhole_x = 4.5 ;
  topscrewhole_y = 15 ;

  color(acrylic_color())  {
    difference() {
      cube ([length-fitting_error(),box_depth()-fitting_error(),acrylic_thickness()]);

      translate ([length/2,box_depth()/2,0])
        mirror_xy()
          translate ([length/2-topscrewhole_x,box_depth()/2-topscrewhole_y,20])
            clearance_hole(nominal_d=3, h=50);
    }
  }
}

module enclosure_electronics_storage_panel() {
  translate([0,-box_depth()-acrylic_thickness()/2,0])
    color(acrylic2_color())
      panel_cover([frame_size().y-fitting_error(), frame_size().z + feetheight()-fitting_error(), acrylic_thickness()],1);
}



module panel_cover(panel_dims,panel_rounding) {
rotate([270,0,0])
  difference() {
    translate ([0, 0, acrylic_thickness()/2 ])
      rounded_rectangle(panel_dims,panel_rounding);
  }
}

demo(){
  electronics_box();
}
