// vim: set nospell:
include <constants.scad>
use <config.scad>
use <screwholes.scad>
include <nopscadlib/core.scad>
use <lib/holes.scad>
use <lib/layout.scad>
use <fan_guard_removal.scad>
use <electronics_box_corner.scad>
use <electronics_box_assembly.scad>
use <demo.scad>

module top_panel() {
  difference() {
    electronics_cabinet_side_panel(box_size_y());
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
    *translate ([box_size_y()/2-20,0,0])
      mirror_x()
        translate ([box_size_y()/2 - 110,box_depth(), -15])
          cylinder(h=30, r1=7.5, r2=7.5, center=false);
  }
  *translate ([box_size_y()/2 - 70,box_depth(), -15])  cylinder(h=30, r1=15, r2=15, center=false);
  translate ([-box_size_y()/2+35,0,0]) IEC_hole();
}

  }

module IEC_hole() {
  IEC_cutout_distance=20; // hole starts at this distance from bottom of panel
  cut_out_width=57;
  cut_out_depth=28.5;
  //IEC hole
translate ([box_size_z()-IEC_cutout_distance-cut_out_width,15.25,-epsilon/2])
  cube ([cut_out_width,cut_out_depth,acrylic_thickness()+epsilon+25]);
// FIXME: this could just as well be a mirror_x of the two holes
translate ([box_size_z()-IEC_cutout_distance-cut_out_width/2,9.65,0])
  linear_repeat(extent = [0, 39.7, 0], count = 2)
    mirror([0, 0, 1]) clearance_hole(nominal_d=3, h=25);
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
}

module left_side_panel() {
  color(acrylic_color())
    difference() {
      electronics_cabinet_side_panel (box_size_z());
IEC_hole();
RJ45_cutout();
//emergency_stop_cutout();

//FANS GUARDS
translate ([50, box_depth()-27,acrylic_thickness()/2])
  fan_guard_removal(size = 40, thickness = acrylic_thickness()+2*epsilon);
translate ([170,box_depth()-27,acrylic_thickness()/2])
  fan_guard_removal(size = 40, thickness = acrylic_thickness()+2*epsilon);
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
translate([0,-box_depth(),0])
rotate ([180,0,0])
  difference() {
      difference() {
      color(acrylic2_color())
      panel_cover([box_size_y() + acrylic_thickness()/2 + expand_acrylic_cover_adjustment()*2 - fitting_error(), box_size_z() + acrylic_thickness()/2 + expand_acrylic_cover_adjustment()*2 - fitting_error(), acrylic_thickness()], acrylic_cover_corner_rounding());
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

  color(acrylic_color()) {
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
