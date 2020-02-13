// vim: set nospell:
use <models_experimental.scad>
use <core.scad>

customcore()
  printer(position = [40, 110, 130]);



  // *************************************************************************************************************************************************

  // FRAME - either specify frame size complete or specify extrusion sizes and addon the corner cubes e.g. [15*2,15*2,15*2] for 15mm corner cubes.
  //                        sizeX sizeY sizeZ
  //Standard
  frame_custom             = [270, 270, 270] + [15*2,15*2,15*2]; // defining extrusion size and then adding frame corner cubes

  // PANEL - Sides, halo and doors.
  //                                  Panel        panel    Extend   Panel Screw  max panel    Bottom
  //                                thickness      radius   panels   Offset       screw space  braces?
  panels_custom           = ["PANELS",6,            5,      150,0,53,55,            100,       false];

  // function fitting_error() = 0.25; //reduce panels by this size to account for whatever +- cutting error there may be

  // FRONT WINDOW / DOOR
  //                            name                sizeXY   radius   offset    door thickness
  //UNMEASURED front_window_original_250zl   = ["WINDOW_TYPE", [420, 385], 10, [0, 5]];
  front_window_custom           = ["WINDOW_TYPE", [420, 385], 10,     [0, 0],   6];

  // RAILS
  //                  sizeX  Xtype  sizeY  Ytype    sizeZ Ztype
  //Standard
  rails_custom              = [[420, MGN12], [445, MGN12], [420, MGN12]];

  // ELECTRONICS BOX ALONG WITH  & ELECTRONICS & CABLE PLACEMENT -  placement of parts on right panel with X/Y as centre
  //                                                      DIMENSIONS               |       POSITIONS
  //                           name        sizeX  sizeZ  depth thick, move lasercut   cable_bundle      DuetE            Duex            PSU        SSR            RPi
  //                                                                  box
  elec_custom               = ["ELEC.BOX", 410,   310,   59 ,   6,    25,    false,  [-84,146.5,0], [-85,70,0],      [-85,-40,0],      [90,30,0], [70,-130,0] , [-90,-140,0]] ;

  // function back_panel_enclosure()    = false;  // is there an additional electronics box on the rear panel? FIXME: FInish off and allow conduit holes.

  // HALO - Just XYZ at the moment. Z is panel thickness
  //                        XY
  //                      addition
  halo_custom                   = [150 , 0, 4];

  // ENCLOSURE BOX - size and shape - can be defined as unconstrained from the frame, or constrained using halo variables.
  //                             X  Y   Z
  enclosure_custom            = [0, 0, 200];


  // LEADSCREW_SPECS
  // PCD holes are for the leadscrew nut diameter to the holes. Two are available on the Z-yoke.
  //                        Name          height diameter   number of holes    PCD hole1 PCD hole2  hole size
  //Standard
  leadscrew_rc_custom     = ["LEADSCREW_SPECS", 420, 8,     4,                 16,       22,          3.4];


  // BED
    //                      name  bed_plate_size   ear space  bed_overall_size  bed thickness     bed offset   flexplate thickness
  bed_custom          = ["BED", [325, 342],      255,        [335, 342],        0.25 * inch,  [0, -12.5],   0.9];
