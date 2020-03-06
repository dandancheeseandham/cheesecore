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

module electronics_box_assembly(panelon = false) {

if (extend_front_and_rear_x() == 0)
  {
    electronics_box();
    *translate([0, 0, 0])
      rotate ([0,0,180])
        filament_box();
  }

if (back_panel_enclosure() == true) {
  translate([0, -extrusion_width()-2, 0])
    rotate ([0,0,90])
      electronics_box();
  }

if (extend_front_and_rear_x() != 0) {
    translate([frame_size().x / 2 + side_panel_thickness(), 0, -movedown()])
      rotate ([0,0,90]) {
        place_four_corners();
        difference() {
        %filament_storage_panel();
        place_four_holes_for_corners();
      }
      translate ([-box_size_y()/2,-box_depth(),-box_size_z()/2 - move_panels_outwards_adjust()/2 - acrylic_thickness()])
        bottom_panel();
      }

      translate([-frame_size().x / 2 - side_panel_thickness(), 0, -movedown()])
      rotate ([0,0,270]) {
        place_four_corners();
        difference() {
        %filament_storage_panel();
        place_four_holes_for_corners();
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
        place_four_corners();
        //if panelon == true electronics_cover_panel();
      }
      translate ([-box_size_y()/2, -box_depth(), box_size_z()/2 + move_panels_outwards_adjust()/2])
        top_panel();
      translate ([-box_size_y()/2,-box_depth(),-box_size_z()/2 - move_panels_outwards_adjust()/2 - acrylic_thickness()])
        bottom_panel();
      translate ([box_size_y()/2 + move_panels_outwards_adjust()/2, -box_depth(), box_size_z()/2])
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
          place_four_corners();
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

module place_four_corners() {
  mirror_xz() {
    translate ([-box_size_y()/2 + move_corners_adjust(), -box_depth(), box_size_z() / 2 - move_corners_adjust()])
      electronics_box_corner();  //electronics box corners
  }
}

module place_four_holes_for_corners() {
  mirror_xz() {
    translate ([-box_size_y()/2 + move_corners_adjust(), -box_depth(), box_size_z() / 2 - move_corners_adjust()])
      electronics_box_corner_hole();  //electronics box corners
  }
}
