// vim: set nospell:
include <constants.scad>
use <config.scad>
use <screwholes.scad>
include <nopscadlib/core.scad>
use <lib/holes.scad>
use <lib/mirror.scad>
use <lib/fan_grill_difference.scad>
use <electronics_box_corner.scad>
use <demo.scad>


module electronics_box() {
/*
  box_size_y()
  box_depth()
  acrylic_thickness()
  laser_cut_vents()
  */
  cover_corner_adjust = 29 ;  // rounded corners for cover, to match the printed corners.
  move_panels = 48.5 ;  // move the panels by this
  move_corners = 9.5 ;  // move the corners by this
  panelcornerrounding = 14 ; // rounding acrylic cover to match the corners
  translate([frame_size().x / 2 + panel_thickness(), 0, 0]  )
    rotate ([0,0,90])
{
  // 4 electronics box corners
  mirror_xz() {
    translate ([-box_size_y()/2+move_corners,-box_depth(),box_size_z()/2+-move_corners])
      electronics_box_corner(cornersize = 15, acrylicdepth = acrylic_thickness() ,height = box_depth(), ledgewidth = 10 , ledgethickness = 4, , holesize = 3.5); ;  //electronics box corners
  }
  // top panel
  translate ([-box_size_y()/2, -box_depth(), box_size_z()/2 + move_panels/2])
    make_panel(box_size_y(), box_depth(), stepper_cables = true, IEC = false);

  // side panel with IEC cutout
  translate ([box_size_y()/2 + move_panels/2, -box_depth(), box_size_z()/2])
    rotate ([0,90,0])
      make_panel (box_size_z(),box_depth(),stepper_cables = false, IEC = true);

  // bottom panel
  translate ([-box_size_y()/2,-box_depth(),-box_size_z()/2 - move_panels/2 - acrylic_thickness()])
    make_panel(box_size_y(),box_depth(),stepper_cables = false);

  // side panel
  translate ([-box_size_y()/2 - move_panels/2 - acrylic_thickness(), -box_depth(), box_size_z()/2])
    rotate ([0,90,0])
      make_panel (box_size_z(),box_depth(),stepper_cables = false, IEC = false);

  // transparent cover
  translate ([0, -box_depth(), 0])
    rotate ([90,0,0])
      electronics_cover_panel(box_size_y()+cover_corner_adjust*2, box_size_z()+cover_corner_adjust*2, panelcornerrounding);
}
  module make_panel(length,electronicscabinet_box_depth,stepper_cables,IEC) {
    topscrewhole_x = 4.5 ;
    topscrewhole_y = 15 ;
    IEC_cutout_distance=20; // hole starts at this distance from bottom of panel
    cut_out_width=57;
    cut_out_depth=28.5;

    color(acrylic_color()) {
      difference() {
        cube ([length,electronicscabinet_box_depth,acrylic_thickness()]);
        translate ([length/2,box_depth()/2,0])
          mirror_xy() {
            translate ([length/2-topscrewhole_x,box_depth()/2-topscrewhole_y,0])
              singlescrewhole(3,0.5);
          }
        if (stepper_cables) {
          translate ([length/2,0,0])
            mirror_x() {
              translate ([length/2 - 20,box_depth(), -15]) cylinder(h=30, r1=7.5, r2=7.5, center=false);
            }
        }
        if (IEC == true) {
          translate ([length-IEC_cutout_distance-cut_out_width,15.25,-epsilon/2])
            cube ([cut_out_width,cut_out_depth,acrylic_thickness()+epsilon]);
          translate ([length-IEC_cutout_distance-cut_out_width/2,9.65,0])
            screwholes(row_distance=39.7,numberofscrewholes=2,Mscrew=3,screwhole_increase=0.5);
        }
      }
    }
  }
}
  module electronics_cover_panel(x, y, panelcornerrounding) {
    vent_length = 78 ;
    vent_height = 3 ;
    gap_between_vents = 4.5 ;
    thickness = acrylic_thickness();
    difference() {
      color(acrylic2_color())
        difference () {
          translate ([0, 0, thickness/2])
            rounded_rectangle([x+thickness/2, y+thickness/2, thickness],panelcornerrounding);

          //16 vents
          if (laser_cut_vents() == true)
          translate(psu_placement()) {
            for(vents = [0 : 15])
              translate ([0,0-(vents*(vent_height + gap_between_vents)),-20])
                longscrewhole(vent_length,vent_height,0) ;
              }
          if (laser_cut_vents() == false)
            translate(psu_placement() + [-91/2,-131/2,-40/2])
              cube ([91,131,40]);

          // FIXME : These should probably be on the left hand panel as cooling occurs from the bottom on the Duet.
          if (laser_cut_vents() == true) {
            translate(DuetE_placement())
              fan_grill_difference(32,3.5,40,8 ,acrylic_thickness()*3);
            translate(Duex5_placement())
              fan_grill_difference(32,3.5,40,8 ,acrylic_thickness()*3);
          }
          if (laser_cut_vents() == false) {
            translate(DuetE_placement())
              cube ([40,40,40]);
            translate(Duex5_placement())
              cube ([40,40,40]);
          }
        }
    }
  }


demo() {

translate([frame_size().x / 2 + panel_thickness(), 0, 0]  )
    rotate ([0,0,90]) {

translate ([0,0,0])
  electronics_box (); // ZL

translate ([500,0,0])
  electronics_box (); // ZLT

translate ([0,500,0])
  electronics_box (); // New ZL

translate ([500,500,0])
  electronics_box (); // ZLT
}
}
