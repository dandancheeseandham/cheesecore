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


module electronics_box_assembly(panelon = true) {

// if extending the front and rear
if (extend_front_and_rear_x() == 0)
  {
    electronics_box(panelon = true);
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

module electronics_box(panelon = true) {
  translate([frame_size().x / 2 + side_panel_thickness() , 0, -movedown()])
     rotate ([0,0,90]) {
      {
        place_four_electronics_box_corners();
        if (panelon == true)
        translate([0,-box_depth()-eps,0])
          rotate ([90,0,0])
            electronics_cover_panel();
        }
      translate ([-box_size_y()/2, -box_depth(), box_size_z()/2 + move_panels_outwards_adjust()/2 + (6-acrylic_thickness() ) ])
        top_panel();
      translate ([-box_size_y()/2,-box_depth(),-box_size_z()/2 - move_panels_outwards_adjust()/2 - acrylic_thickness() - (6-acrylic_thickness()) ])
        bottom_panel();
      translate ([box_size_y()/2 + move_panels_outwards_adjust()/2, -box_depth(), box_size_z()/2])
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
        #translate ([-filament_box_size_y()/2,-filament_box_depth(),-filament_box_size_z()/2 - move_panels_outwards_adjust()/2 - filament_acrylic_thickness()])
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


demo() {
  electronics_box_assembly(panelon = true);
  //fan_assembly(2,14,true);
  //echo (fan40x11);
}
