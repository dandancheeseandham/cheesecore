// vim: set nospell:
include <config.scad>
use <nopscadlib/vitamins/stepper_motor.scad>
include <nopscadlib/vitamins/stepper_motors.scad>
use <lib/holes.scad>
use <lib/mirror.scad>
use <door_hinge.scad>
use <screwholes.scad>
use <demo.scad>


module panel(x, y)
{
  assert(x != undef, "Must specify panel x dimension");
  assert(y != undef, "Must specify panel y dimension");

  difference()
  {
    color(acrylic2_color())
      translate ([0, 0, panel_thickness()/2])
      rounded_rectangle([x, y, panel_thickness()], panel_radius());
    // Color the holes darker for contrast
    color(panel_color_holes())
    {
      panel_mounting_screws(x, y);
      // Access screws to corner cubes
      mirror_xy()
      {
        translate([x / 2 - extrusion_width() / 2, y / 2 - extrusion_width() / 2, -epsilon])
          cylinder(d=extrusion_width() * 0.5, h = panel_thickness() + 2 * epsilon);
      }
    }
  }
}

function panel_screw_extent(panel_length) = panel_length - 2 * panel_screw_offset() ;
function panel_screw_count(panel_length) = ceil(panel_screw_extent(panel_length) / max_panel_screw_spacing()) + 1 ;
function panel_screw_spacing(panel_length) = panel_screw_extent(panel_length) / (panel_screw_count(panel_length) - 1);

// Holes to mount panels to extrusion
module panel_mounting_screws(x, y)
{
  // How far from center of first hole to center of last hole
  extent_x = x - 2 * panel_screw_offset();
  extent_y = y - 2 * panel_screw_offset();

  // How many screws in each direction
  screws_x = ceil(extent_x / max_panel_screw_spacing()) + 1;
  screws_y = ceil(extent_y / max_panel_screw_spacing()) + 1;

  // How far between screws
  screw_spacing_x = extent_x / (screws_x - 1);
  screw_spacing_y = extent_y / (screws_y - 1);

  mirror_y()
  {
    for (a =[0:(screws_x - 1)])
    {
      translate ([-x/2 + panel_screw_offset() + (screw_spacing_x * a), y / 2 - extrusion_width() / 2, -epsilon])
        // FIXME - this should be a hole() not a cylinder
        cylinder(h=panel_thickness() + 2 * epsilon, d=clearance_hole_size(extrusion_screw_size()));
    }
  }

  mirror_x()
  {
    for (a =[0:(screws_y - 1)])
    {
      translate ([x / 2 - extrusion_width() / 2, -y / 2 + panel_screw_offset() + (screw_spacing_y * a), -epsilon])
        // FIXME - this should be a hole not a cylinder
        cylinder(h=panel_thickness() + 2 * epsilon, d=clearance_hole_size(extrusion_screw_size()));
    }
  }
}

module bottom_panel()
{

  difference()
  {
    panel(frame_size().x, frame_size().y);
    // Deboss a name in the bottom panel
    deboss_depth = 3;
    color("#333333")
      translate([0, -frame_size().y/2 + 50, panel_thickness() - deboss_depth + epsilon])
        linear_extrude(deboss_depth)
          text("this way up", halign="center", size=35);

  }
}

module front_panel()
{
  //assert(front_window_size().x <= frame_size().x - 2 * extrusion_width(), str("Window cannot overlap extrusion in X: "));
  //assert(front_window_size().y <= frame_size().z - 2 * extrusion_width(), "Window cannot overlap extrusion in Z");
  // FIXME to make this assert work again
  //assert(Zwindowspacingbottom >= extrusion_width(), "Window cannot overlap extrusion in Z");

  difference()
  {
    panel(frame_size().x, frame_size().z-extrusion_width($extrusion_type));

  }

  // panel hinges
  panelrounding = 5 ;
  hole_distance_from_edge = 7.5 ;
}

module hinges()
{
  mirror_x()
    translate ([frame_size().x/2-extrusion_width($extrusion_type)/2-50-86.25/2, frame_size().y/2+6,frame_size().z/2-extrusion_width($extrusion_type)/2])
    rotate([0, 270, 270])
    front_panel_doors_hinge(screw_distance = 86.25 ,acrylic_door_thickness=6,extension = 5,screw_type=3 , $draft = false);

  mirror_x()     
    translate ([frame_size().x/2-extrusion_width($extrusion_type)/2-50-86.25/2, frame_size().y/2+6-27.5,frame_size().z/2-extrusion_width($extrusion_type)/2+15])
    rotate([0, 270, 270]) rotate([0, 90, 0])  doorside();    
}

// One door - the right side as facing printer
// Origin is the centerline between the doors at the middle of the height. So not quite on the door, but rather in the gap between where they meet together
module door()
{
  door_gap = 1; // How far do we want between doors?
  door_overlap = 10; // How far do we want the doors to overlap the panel edges?
  door_radius_mating_corners = 2.5; // radius of the corners where the panels come together
  door_radius_outside_corners = front_window_radius() + door_overlap;
  difference()
  {
    // Outline of the door
    color(acrylic2_color())
    {
      // FIXME - make door thickness parametric
      linear_extrude(1/8 * inch)
      {
        hull()
        {
          mirror_y()
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
    }

    // Hinge holes
    // FIXME: add these

    // Door pull holes
    // FIXME: add these
  }
}

module doors()
{
  rotate([90, 0, 0])
    translate(front_window_offset())
    mirror_x()
    door();
}

module side_panel()
{
  panel(frame_size(). y, frame_size().z-extrusion_width($extrusion_type)/2);
}

module back_panel()
{
  panel(frame_size().x, frame_size().z-extrusion_width($extrusion_type)/2);
}

module all_side_panels()
{
  translate([0, 0, frame_size().z / 2]) bottom_panel();
  translate([0, -(frame_size().y)/2, extrusion_width($extrusion_type)/2]) rotate([90,0,0]) front_panel();
  translate([-frame_size().x / 2 - panel_thickness(), 0, extrusion_width($extrusion_type)/2]) rotate([90,0,90]) side_panel();
  // FIXME: should move this into a right_side_panel() module and call that.
  translate ([frame_size().x / 2, 0, extrusion_width($extrusion_type)/2]) rotate([90,0,90]) side_panel();
  translate ([0, frame_size().y / 2 + panel_thickness(),extrusion_width($extrusion_type)/2]) rotate([90,0,0]) back_panel();
}

module all_side_panels_dxf()
{
  projection(cut = true) translate([0, 0, 0]) bottom_panel();
  projection(cut = true) translate([0, -(frame_size().y)-30, -6])  bottom_panel();
  projection(cut = true) translate([0, -(frame_size().y)*2-30, 0])  front_panel(Xwindowspacing=35,Zwindowspacingtop=25, Zwindowspacingbottom=35,screwhole_X = 5, screwhole_Y = 5, corner_radius = 5); // ZL spacing
  // projection(cut = true) translate([0, -(frame_size().y)*2-30, 0])  front_panel(Xwindowspacing=35,Zwindowspacingtop=50, Zwindowspacingbottom=50,screwhole_X = 5, screwhole_Y = 7, corner_radius = 5) // ZLT spacing
  projection(cut = true) translate([-(frame_size().x)-30,0,0])  side_panel();
  projection(cut = true) translate ([(frame_size().x)+30,0,0])  side_panel();
  projection(cut = true) translate ([0,(frame_size().y)+30,0])  back_panel();
}

//all_side_panels_dxf();
//all_side_panels();
//bottom_panel();
// Must supply these params when calling this and not define it global to the file
front_panel($extrusion_type = extrusion15, $front_window_size = front_window_zl, $frame_size = frame_rc300zl);
// side_panel($extrusion_type = extrusion15);
//hinges();
//doors();
