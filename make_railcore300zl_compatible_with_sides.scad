// vim: set nospell:
include <colors.scad>
include <prefs.scad>
include <constants.scad>
use <validation.scad>
include <nopscadlib/vitamins/rails.scad>
include <nopscadlib/vitamins/stepper_motors.scad>
use <models_standard.scad>
include <core.scad>
use <config.scad>

rc300zl_compatible_with_sides()
  printer(position = [80, 90, 130]);


  // ORIGINAL RAILCORE II 300ZL
module rc300zl_compatible_with_sides(position = [0, 0, 0]) {
    $NEMA_XY            = NEMA17;
    $NEMA_Z             = NEMA17;
    $extrusion_type     = extrusion15;

    $frame_size         = frame_original_rc300zl;
    $panels             = panels_withsides;
    $enclosure_size     = enclosure_rc300zl;
    $halo_size          = halo_rc300zlwithcheese;
    $front_window_size  = front_window_original_300zl;
    $elecbox            = elecbox_original_rc300zl_with_sides;
    $branding_name      = "Original 300ZL";

    $rail_specs         = rails__original_rc300zl;
    $leadscrew_specs    = leadscrew_original_rc300zl;
    $bed                = bed_standard_rc300;
    $feet_depth         = 50 ;
    children();
  }
  // PANEL - Sides, halo and doors.
  //                                  Panel        panel    Extend   Panel Screw  max panel    Bottom
  //                                thickness      radius   panels   Offset       screw space  braces?
  panels_withsides           = ["PANELS",3,            3,      105*2,0,53,50,          100,       false];

  // ELECTRONICS BOX ALONG WITH  & ELECTRONICS & CABLE PLACEMENT -  placement of parts on right panel with X/Y as centre
  //                                                      DIMENSIONS               |       POSITIONS
  //                           name        sizeX  sizeZ  depth thick, move lasercut   cable_bundle      DuetE            Duex            PSU        SSR            RPi
  //                                                                  box
  //                                                                 down

  elecbox_original_rc300zl_with_sides   = ["ELEC.BOX", 445-52,338.9, 99 ,   6,    75-12.5,    true,   [-84,126.5,0], [-84.82,50.5,0], [-84.82,-59.5,0], [90,30,0], [45,-115,0] , [90,30,0]] ;


  // HALO - Just XYZ at the moment. Z is panel thickness
  //                        XY
  //                      addition
  halo_rc300zlwithcheese       = [105*2 ,0, 4];
