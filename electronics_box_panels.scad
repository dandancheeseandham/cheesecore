// vim: set nospell:
include <constants.scad>
use <config.scad>
use <screwholes.scad>
include <nopscadlib/core.scad>
use <lib/holes.scad>
use <lib/layout.scad>
use <lib/fan_grill_difference.scad>
use <electronics_box_corner.scad>
use <demo.scad>

function expand_acrylic_cover_adjustment() = 29 ;  // rounded corners for cover, to match the printed corners.
function move_panels_outwards_adjust() = 49 ;  // 48.5 based on existing corners
function move_corners_adjust() = 9.5 ;  // move the corners by this
function acrylic_cover_corner_rounding() = 14 ; // rounding acrylic cover to match the corners
function screwy() = (-box_size_y()/2 + move_corners_adjust() - 20);
function screwz() = ( box_size_z()/2 - move_corners_adjust() + 20);


module electronics_box_panels_assembly() {
  {
  translate([frame_size().x / 2 + side_panel_thickness(), 0, -movedown()])
    rotate ([0,0,90]) {
      place_four_corners();

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

      translate ([0, -box_depth(), 0])
        rotate ([90,0,0])
          electronics_cover_panel();
      // FIXME: bug spotted when no electronics is rendered included with panels.
      //echo ("frame",frame_size().x);
      //echo ("box", box_size_z());

  }
}
if (back_panel_enclosure() == true) {
  translate([0, frame_size().y / 2 + side_panel_thickness(), -movedown()])
    rotate ([0,0,180]) {
      place_four_corners();

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

      translate ([0, -box_depth(), 0])
        rotate ([90,0,0])
          electronics_cover_panel();



}
}
}
module place_four_corners() {
  mirror_xz() {
    translate ([-box_size_y()/2 + move_corners_adjust(), -box_depth(), box_size_z() / 2 - move_corners_adjust()])
      electronics_box_corner(cornersize = 15, acrylicdepth = acrylic_thickness() ,height = box_depth(), ledgewidth = 10 , ledgethickness = 4, , holesize = 3.5); ;  //electronics box corners
    }
}


module top_panel() {
    make_panel(box_size_y(), box_depth(), stepper_cables = true, IEC = false);
}

module bottom_panel() {
  make_panel(box_size_y(),box_depth(),stepper_cables = false);
}

module right_side_panel() {
  make_panel (box_size_z(),box_depth(),stepper_cables = false, IEC = true);
}

module left_side_panel(){
  color(acrylic_color()) render()
  difference()
    {
    make_panel (box_size_z(),box_depth(),stepper_cables = false, IEC = false);
    translate ([70,30,0])  fan_grill_difference(32,3.5,40,8 ,acrylic_thickness()+epsilon);
    translate ([180,30,0]) fan_grill_difference(32,3.5,40,8 ,acrylic_thickness()+epsilon);
   }
}


module electronics_cover_panel()
{
  // FIXME : draw in 2d then extrude
  // vent configuration
  vent_length = 78 ;
  vent_height = 3 ;
  gap_between_vents = 4.5 ;

    difference() {
      color(acrylic2_color())
        difference () {
          translate ([0, 0, acrylic_thickness()/2])
            rounded_rectangle([box_size_y()+acrylic_thickness()/2+expand_acrylic_cover_adjustment()*2, box_size_z()+acrylic_thickness()/2 + expand_acrylic_cover_adjustment()*2, acrylic_thickness()],acrylic_cover_corner_rounding());
            rotate([90,0,0]) mirror_xz() translate([screwy(),-50,screwz()]) rotate([-90,0,0]) cylinder(d=3,h=100);  // FIXME: Use polyhole, check mounting fits Meanwell too
          //16 vents
          if (laser_cut_vents() == true)
          translate(psu_placement() + [-40,90,0])  {
            for(vents = [0 : 23])
              translate ([0,0-(vents*(vent_height + gap_between_vents)),-20])
                longscrewhole(vent_length,vent_height,0);
          }
          if (laser_cut_vents() == false)
            translate(psu_placement() + [-91/2,-131/2,-40/2])
              cube ([91,131,40]);
/*
          // FIXME : These should probably be on the left hand panel as cooling occurs from the bottom on the Duet.
          if (laser_cut_vents() == true) {
            %translate(DuetE_placement()-[0,0,-epsilon])
              fan_grill_difference(32,3.5,40,8 ,acrylic_thickness()+epsilon);
            %translate(Duex5_placement()-[0,0,-epsilon])
              fan_grill_difference(32,3.5,40,8 ,acrylic_thickness()+epsilon);
          }

          if (laser_cut_vents() == false) {
            translate(DuetE_placement())
              cube ([40,40,40]);
            translate(Duex5_placement())
              cube ([40,40,40]);
            }
            */
        }
    }
  }

module make_panel(length,electronicscabinet_box_depth,stepper_cables,IEC) {
    // FIXME: draw this in 2d then extrude
    topscrewhole_x = 4.5 ;
    topscrewhole_y = 15 ;
    IEC_cutout_distance=20; // hole starts at this distance from bottom of panel
    cut_out_width=57;
    cut_out_depth=28.5;

    color(acrylic_color()) {
      difference() {
        cube ([length,electronicscabinet_box_depth,acrylic_thickness()]);

        translate ([length/2,box_depth()/2,0])
          mirror_xy()
            translate ([length/2-topscrewhole_x,box_depth()/2-topscrewhole_y,20])
              clearance_hole(nominal_d=3, h=50);


        if (stepper_cables) {
          translate ([length/2,0,0])
            mirror_x()
              translate ([length/2 - 20,box_depth(), -15]) cylinder(h=30, r1=7.5, r2=7.5, center=false);

        }

        if (IEC == true) {
          translate ([length-IEC_cutout_distance-cut_out_width,15.25,-epsilon/2])
            cube ([cut_out_width,cut_out_depth,acrylic_thickness()+epsilon]);
          // FIXME: this could just as well be a mirror_x of the two holes
          translate ([length-IEC_cutout_distance-cut_out_width/2,9.65,0])
            linear_repeat(extent = [0, 39.7, 0], count = 2)
              mirror([0, 0, 1]) clearance_hole(nominal_d=3, h=25);
        }

      }
    }
  }

  demo() {
    translate([frame_size().x / 2 + side_panel_thickness(), 0, 0])
        rotate ([0,0,90]) {
          translate ([0,0,0])
            electronics_box();
  }
}
