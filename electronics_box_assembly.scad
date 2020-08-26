// vim: set nospell:
include <constants.scad>
use <config.scad>
use <screwholes.scad>
include <nopscadlib/core.scad>
use <lib/holes.scad>
use <lib/layout.scad>
use <fan_guard_removal.scad>
use <electronics_box_corner.scad>
use <electronics_box_panels.scad>
use <demo.scad>
use <nopscadlib/vitamins/fan.scad>
use <nopscadlib/vitamins/fans.scad>


module electronics_box_assembly(panelon = false) {

if (extend_front_and_rear_x() == 0)
  {
    electronics_box();
    *translate([0, 0, 0])
      rotate ([0,0,180])
        cheesecore_filament_box();
  }

if (back_panel_enclosure() == true) {
  translate([0, -extrusion_width()-2, 0])
    rotate ([0,0,90])
      electronics_box();
  }

if (extend_front_and_rear_x() != 0) {
    translate([frame_size().x / 2 + side_panel_thickness(), 0, -movedown()])
      rotate ([0,0,90]) {
        place_four_electronics_box_corners();
        difference() {
        enclosure_electronics_storage_panel();
        place_four_holes_for_electronics_corners();
      }
      translate ([-box_size_y()/2,-box_depth(),-box_size_z()/2 - move_panels_outwards_adjust()/2 - acrylic_thickness()])
        bottom_panel();
      }

      translate([-frame_size().x / 2 - side_panel_thickness(), 0, 0])
      rotate ([0,0,270]) {
        place_four_filament_box_corners();
        difference() {
        filament_cover_panel();
        place_four_holes_for_filament_box_corners();
      }
      translate ([-box_size_y()/2,-box_depth(),-box_size_z()/2 - move_panels_outwards_adjust()/2 - acrylic_thickness()])
        bottom_panel();
      }
    }
}

module electronics_box(panelon) {
  translate([frame_size().x / 2 + side_panel_thickness() , 0, -movedown()])
     rotate ([0,0,90]) {
      {
        place_four_electronics_box_corners();
        //if panelon == true electronics_cover_panel();
        *electronics_cover_panel();
        }
      translate ([-box_size_y()/2, -box_depth(), box_size_z()/2 + move_panels_outwards_adjust()/2 + (6-acrylic_thickness() ) ])
        top_panel();
      translate ([-box_size_y()/2,-box_depth(),-box_size_z()/2 - move_panels_outwards_adjust()/2 - acrylic_thickness() - (6-acrylic_thickness()) ])
        bottom_panel();
      translate ([box_size_y()/2 + move_panels_outwards_adjust()/2 + (6-acrylic_thickness()), -box_depth(), box_size_z()/2])
        rotate ([0,90,0])
          right_side_panel();
      translate ([-box_size_y()/2 - move_panels_outwards_adjust()/2 - acrylic_thickness() - (6-acrylic_thickness() ), -box_depth(), box_size_z()/2])
        rotate ([0,90,0])
          left_side_panel();
      }
  }

  module cheesecore_filament_box(panelon) {
    translate([frame_size().x / 2 + side_panel_thickness() , 0, -movedown()])
      rotate ([0,0,90]) {
        {
          place_four_filament_box_corners();
          //if panelon == true electronics_cover_panel();
        }
        translate ([-filament_box_size_y()/2, -filament_box_depth(), filament_box_size_z()/2 + move_panels_outwards_adjust()/2])
          top_panel();
        translate ([-filament_box_size_y()/2,-filament_box_depth(),-filament_box_size_z()/2 - move_panels_outwards_adjust()/2 - filament_acrylic_thickness()])
          bottom_panel();
        translate ([filament_box_size_y()/2 + filament_move_panels_outwards_adjust()/2, -filament_box_depth(), box_size_z()/2])
          rotate ([0,90,0])
            right_side_panel();
        translate ([-box_size_y()/2 - move_panels_outwards_adjust()/2 - acrylic_thickness(), -box_depth(), box_size_z()/2])
          rotate ([0,90,0])
            left_side_panel();
        }
    }

  module filament_box() {
    translate([frame_size().x / 2 + side_panel_thickness() , 0, -movedown()])
      rotate ([0,0,90]) {
        {
          place_four_electronics_box_corners();
          filament_cover_panel();
        }
        translate ([-box_size_y()/2, -box_depth(), box_size_z()/2 + move_panels_outwards_adjust()/2])
          top_panel();
        translate ([-box_size_y()/2,-box_depth(),-box_size_z()/2 - move_panels_outwards_adjust()/2 - acrylic_thickness()])
          bottom_panel();
        translate ([box_size_y()/2 + move_panels_outwards_adjust()/2, -box_depth(), box_size_z()/2])
          rotate ([0,90,0])
            electronics_cabinet_side_panel (box_size_z());
        translate ([-box_size_y()/2 - move_panels_outwards_adjust()/2 - acrylic_thickness(), -box_depth(), box_size_z()/2])
          rotate ([0,90,0])
            electronics_cabinet_side_panel (box_size_z());
        }
    }

module place_four_electronics_box_corners() {
  mirror_xz() {
    translate ([-box_size_y()/2 + move_corners_adjust(), -box_depth(), box_size_z() / 2 - move_corners_adjust()])
      electronics_box_corner();  //electronics box corners
  }
}


module place_four_holes_for_electronics_corners() {
  mirror_x() {
    translate ([-box_size_y()/2 + move_corners_adjust(), -box_depth(), box_size_z() / 2 - move_corners_adjust()])
    rotate ([90,270,0])
      translate ([elec_corner_size()+elec_corner_ledge_width()-(elec_corner_ledge_width()-10),elec_corner_size()+elec_corner_ledge_width()-(elec_corner_ledge_width()-10),-box_depth()]) {
        translate ([-5,-5,-box_depth()/2])
        linear_extrude(box_depth()*2){

translate ([7,0]) circle (d=7);
hull(){
circle (d=3.4);
translate ([7,0]) circle (d=3.4);
}
  }
}
}


mirror_x() {
translate ([-box_size_y()/2 + move_corners_adjust(), -box_depth(), box_size_z() / 2 - move_corners_adjust()])
  rotate ([90,270,0])
    translate ([elec_corner_size()+elec_corner_ledge_width()-(elec_corner_ledge_width()-10),elec_corner_size()+elec_corner_ledge_width()-(elec_corner_ledge_width()-10),-box_depth()])
    translate ([-box_size_y()+38,0,5]) //FIXME HACK FIX FOR PRODUCTION!!!!
    {
      translate ([-5,-5,-box_depth()/2])
      linear_extrude(box_depth()*2){

translate ([7,0]) circle (d=7);
hull(){
circle (d=3.4);
translate ([7,0]) circle (d=3.4);
}
}
}
}




}

/*
module place_four_filament_box_corners() {
  mirror_xz() {
    translate ([-filament_box_size_y()/2 + move_corners_adjust(), -filament_box_depth(), filament_box_size_z() / 2 - move_corners_adjust()])
      electronics_box_corner();  //electronics box corners
  }
}

module place_four_holes_for_filament_box_corners() {
  mirror_xz() {
    translate ([-filament_box_size_y()/2 + move_corners_adjust(), -filament_box_depth(), filament_box_size_z() / 2 - move_corners_adjust()])
      electronics_box_corner_hole();  //electronics box corners
  }
}
*/

demo() {
  electronics_box_assembly(panelon = false);
  //fan_assembly(2,14,true);
  //echo (fan40x11);
}
