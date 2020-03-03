// vim: set nospell:
include <colors.scad>
include <prefs.scad>
include <constants.scad>
use <validation.scad>
include <nopscadlib/vitamins/rails.scad>
include <nopscadlib/vitamins/stepper_motors.scad>

// *************************************************************************************************************************************************

// FRAME - either specify frame size complete or specify extrusion sizes and addon the corner cubes e.g. [15*2,15*2,15*2] for 15mm corner cubes.
//                        sizeX sizeY sizeZ
//Standard
frame_original_rc150mini= [270, 270, 270] + [15*2,15*2,15*2]; // defining extrusion size and then adding frame corner cubes
frame_original_rc250zl  = [400, 370, 360] + [15*2,15*2,15*2];
frame_original_rc300zl  = [460, 425, 415] + [15*2,15*2,15*2];
frame_original_rc300zlt = [460, 425, 715] + [15*2,15*2,15*2];
//Experimental
frame_rc300_custom      = [490, 500, 460];
//Test-ground
frame_rc300zl4040       = [590, 555, 545];


// PANEL - Sides, halo and doors.
//                                  Panel        panel    Extend      Panel Screw  max panel    Bottom
//                                thickness      radius   panels      Offset       screw space  braces?
//Standard
panels_imperial_250zl   = ["PANELS",0.25 * inch,  5,      0,0,0,      42.5,          101,       false];
panels_imperial         = ["PANELS",0.25 * inch,  5,      0,0,0,      50,            100,       true];
panels_metric           = ["PANELS",6,            5,      0,0,0,      50,            100,       true];
panels_aluminium        = ["PANELS",3,            5,      0,0,0,      50,            100,       false];
panels_steel            = ["PANELS",2,            5,      0,0,0,      50,            100,       false];
//Experimental
panels_custom           = ["PANELS",6,            5,      150,0,53,   55,            100,       false];
panels_cheese           = ["PANELS",3,            3,      105*2,0,53, 50,            100,       false];
function fitting_error() = 0.25; //reduce panels by this size to account for whatever +- cutting error there may be
function feetheight()               = $feet_depth;

// FRONT WINDOW / DOOR
//                            name                sizeXY   radius   offset    door thickness
//Standard
front_window_original_150mini = ["WINDOW_TYPE", [245, 210], 10,     [0, 5],   0.25 * inch];
front_window_original_250zl   = ["WINDOW_TYPE", [370, 335], 10,     [0, 5],   0.25 * inch];
front_window_original_300zl   = ["WINDOW_TYPE", [420, 385], 10,     [0, 5],   6];
front_window_original_300zlt  = ["WINDOW_TYPE", [410, 645], 10,     [0, 0],   6];
//Experimental
front_window_custom           = ["WINDOW_TYPE", [420, 385], 10,     [0, 0],   6];

// RAILS
//                           sizeX  Xtype  sizeY  Ytype    sizeZ Ztype
//Standard
rails_original_rc150mini = [[245, MGN12], [245, MGN12], [245, MGN12]];
rails_original_rc250zl   = [[350, MGN12], [350, MGN12], [350, MGN12]];
rails_original_rc300zl   = [[400, MGN12], [400, MGN12], [400, MGN12]];
rails_original_rc300zlt  = [[400, MGN12], [400, MGN12], [700, MGN12]];
//Experimental
rails_misumi_395         = [[395, MGN12], [395, MGN12], [395, MGN12]];
rails_misumi_420         = [[420, MGN12], [420, MGN12], [420, MGN12]];
rails_misumi_420XY_470Z  = [[420, MGN12], [420, MGN12], [470, MGN12]];
// Test-ground (can be deleted)
rails_300zl_4040         = [[500, MGN15], [500, MGN12], [500, MGN15]];
rails_custom             = [[420, MGN9] , [445, MGN12], [420, MGN15]];

// ELECTRONICS BOX ALONG WITH  & ELECTRONICS & CABLE PLACEMENT -  placement of parts on right panel with X/Y as centre
//                                                      DIMENSIONS               |       POSITIONS
//                           name        sizeX  sizeZ  depth thick, move lasercut   cable_bundle      DuetE            Duex            PSU        SSR            RPi
//                                                                  box
//Standard                                                         down
elecbox_original_rc150mini= ["ELEC.BOX", 298.9, 238.9, 59 ,   6,    25,    true,   [-84,126.5,0], [-84.82,50.5,0], [-84.82,-59.5,0], [90,30,0], [45,-115,0] , [90,30,0]] ;
elecbox_original_rc250zl  = ["ELEC.BOX", 298.9, 238.9, 59 ,   6,    25,    true,   [-400/2+106.68,390/2-101+25], [-84.82,50.5,0], [-84.82,-59.5,0], [90,30,0], [45,-115,0] , [90,30,0]] ;
elecbox_original_rc300zl  = ["ELEC.BOX", 298.9, 238.9, 59 ,   6,    25,    true,   [-84,126.5,0], [-84.82,50.5,0], [-84.82,-59.5,0], [90,30,0], [45,-115,0] , [90,30,0]] ;
elecbox_original_rc300zlt = ["ELEC.BOX", 298.9, 438.9, 59 ,   6,    25,    true,   [-84,226.5,0], [-84.82,150.5,0],[-84.82,40.5,0],  [80,75,0], [0,-110,0]  , [-90,-140,0]] ;
//Experimental
elecbox_300_large         = ["ELEC.BOX", 350,   290,   59,    6,    25,    true,   [-84,146.5,0], [-85,70,0],      [-85,-40,0],      [70,30,0],[160,70,0] , [-90,-130,0]] ;
elecbox_300_Duet3         = ["ELEC.BOX", 298.9, 238.9, 59 ,   6,    25,    true,   [-84,126.5,0], [-84.82,50.5,0], [-84.82,-69.5,0], [90,30,0], [45,-115,0] , [-70,-60,0]] ;
// Test-ground (can be deleted)
elec_cheesecore           = ["ELEC.BOX", 392.9, 290,   59 ,   6,    25,    true,   [-104,146.5,0],[-105,70,0],     [-105,-40,0],     [90,30,0], [70,-130,0] , [-60,-130,0]] ;
elec_miniplaceh           = ["ELEC.BOX", 118.9, 58.9,  59 ,   6,    25,    true,   [-84,126.5,0], [-84.82,50.5,0], [-84.82,-59.5,0], [60,00,0],  [145,50,0] , [-90,-140,0]] ;
elec_custom               = ["ELEC.BOX", 410,   310,   59 ,   6,    25,    false,  [-84,146.5,0], [-85,70,0],      [-85,-40,0],      [90,30,0], [70,-130,0] , [-90,-140,0]] ;
elec_rc300zltwithcheese   = ["ELEC.BOX", 445-32,380,   99 ,   6,    60,    true,   [-84,146.5,0], [-85,70,0],      [-85,-40,0],      [100,50,0],[80,-110,0] , [-90,-130,0]] ;


function back_panel_enclosure()     = false;  // is there an additional electronics box on the rear panel? FIXME: FInish off and allow conduit holes.

// HALO - Just XYZ at the moment. Z is panel thickness
//                        XY
//                      addition
//Standard, halo for 250ZL,300ZL and 300ZLT is the same
halo_rc150mini                = [125 , 0, 4];
//halo_rc                       = [75*2 , 0, 4];
halo_rc                       = [90*2+3 , 6, 4];
//Experimental
halo_rc_NEMA23                = [80*2 ,15, 4];
halo_rc_cheese                = [105*2 ,0, 4];

// ENCLOSURE BOX - size and shape - can be defined as unconstrained from the frame, or constrained using halo variables.
//                             X  Y   Z
//Standard
enclosure_rc_standard          = [0, 0, 200];
//Experimental
enclosure_large                = [0, 0, 245];
enclosure_custom               = [0, 0, 200];

function enclosure_height_above_frame() = 0 ; // For the printed interface arrangement. Uneeeded with the cheesecore halo. but Left for backwards compatibility.
// FIXME: X and Y are pointless. Integrate enclosure height above frame too.

// LEADSCREW_SPECS
// PCD holes are for the leadscrew nut diameter to the holes. Two are available on the Z-yoke.
//                        Name          height diameter   number of holes    PCD hole1 PCD hole2  hole size
//Standard
leadscrew_original_rc150mini= ["LEADSCREW_SPECS", 270, 8,     8,                 16,       22,          3.4];
leadscrew_original_rc250zl  = ["LEADSCREW_SPECS", 400, 8,     8,                 16,       22,          3.4];
leadscrew_original_rc300zl  = ["LEADSCREW_SPECS", 400, 8,     8,                 16,       22,          3.4];
leadscrew_original_rc300zlt = ["LEADSCREW_SPECS", 700, 8,     4,                 16,       22,          3.4];
//Experimental
leadscrew_zl4040            = ["LEADSCREW_SPECS", 500, 8,     4,                 16,       22,          3.4];
leadscrew_rc_custom         = ["LEADSCREW_SPECS", 420, 8,     4,                 16,       22,          3.4];


function leadscrew_clearance() = 2; //central hole leadscrew clearance required for around the leadscrew so it does not hit the printed/milled part.
// These define how far from the part origin of the z-tower the leadscrew is
function leadscrew_x_offset() = 20 ; // how far in x the centerline of the leadscrew is from the inside edge of the frame extrusions
function leadscrew_y_offset() = 30 ; // taken off z yoke in fusion

// BED

//                      name  bed_plate_size   ear space  bed_overall_size  bed thickness     bed offset   flexplate thickness
//Standard
bed_standard_rc150mini= ["BED", [150, 167],      100,        [160, 167],        0.25 * inch,  [0, -12.5],   0.9];
bed_standard_rc250    = ["BED", [275, 281],      205,        [335, 342],        0.25 * inch,  [0, -12.5],   0.9];
bed_standard_rc300    = ["BED", [325, 342],      255,        [335, 342],        0.25 * inch,  [0, -12.5],   0.9];
//Experimental
bed_custom            = ["BED", [425, 442],      295,        [435, 442],        8,            [0, -12.5],   0.9];
// bed offset = How far to offset the bed from center of frame
// FIXME: what is the bed_overall_size for? Is it needed?

// MANUFACTURER DEFINED
// Extrusion information
//                              nominal size
//                                   nominal screw size
extrusion15 = ["1515 Extrusion", 15, 3];  // standard extrusion for RailCore II
extrusion20 = ["2020 Extrusion", 20, 4];
extrusion30 = ["3030 Extrusion", 30, 5];
extrusion40 = ["4040 Extrusion", 40, 6];

// *************************************************************************************************************************************************


// Note that we don't specify the finer points of the bed ears here, because it doesn't affect how the printer lays out, that's an impelementation detail fo ths bed model

function NEMAtypeXY() = $NEMA_XY ;
function NEMAtypeZ()  = $NEMA_Z ;
function extrusion_width      (extrusion_type = $extrusion_type) = extrusion_type[1];
function extrusion_screw_size (extrusion_type = $extrusion_type) = extrusion_type[2];
function frame_size() = $frame_size;
function panels() = $panels;
// *** THESE MOVE THE IDLER POSITION ON THE HALO
move_inner = -4.5 ;
move_outer = -12.5 ;
function idler_offset_outer()      =  move_outer - 1.5 ;
function halo_idler_offset_outer() =  move_outer ;
function idler_offset_inner()      =  move_inner - 22.5;
function halo_idler_offset_inner() =  move_inner ;

function bed_plate_size()       = $bed[1];
function bed_ear_spacing()      = $bed[2];
function bed_overall_size()     = $bed[3];
function bed_thickness()        = $bed[4];
function bed_offset()           = $bed[5];
function flex_plate_thickness() = $bed[6];

function leadscrew_length()           = $leadscrew_specs[1];
function leadscrew_diameter()         = $leadscrew_specs[2];
function leadscrew_number_of_holes()  = $leadscrew_specs[3];
function leadscrew_pcd1()             = $leadscrew_specs[4];
function leadscrew_pcd2()             = $leadscrew_specs[5];
function leadscrew_nut_screwholes()   = $leadscrew_specs[6];

function halo_size()          = [$halo_size.x + frame_size().x, $halo_size.y + frame_size().y + side_panel_thickness() * 2,$halo_size.z];

function rail_lengths()  = [$rail_specs.x[0], $rail_specs.y[0], $rail_specs.z[0]];
function rail_profiles() = [$rail_specs.x[1], $rail_specs.y[1], $rail_specs.z[1]];

function front_window_size()   = $front_window_size[1];
function front_window_radius() = $front_window_size[2];
function front_window_offset() = $front_window_size[3];
function acrylic_door_thickness() = $front_window_size[4];

function box_size_y()         = $elecbox[1] ;
function box_size_z()         = $elecbox[2] ;
function box_depth()          = $elecbox[3] ;
function acrylic_thickness()  = $elecbox[4] ;
function movedown()           = $elecbox[5] ;
function laser_cut_vents()    = $elecbox[6] ;

function cable_bundle_hole_placement() = $elecbox[7] ;
function DuetE_placement()  = $elecbox[8] ;
function Duex5_placement()  = $elecbox[9] ;
function psu_placement()    = $elecbox[10] ;
function ssr_placement()    = $elecbox[11] ;
function rpi_placement()    = $elecbox[12] ;

function enclosure_size()   = [halo_size().x, halo_size().y ,$enclosure_size.z];

function side_panel_thickness()     = $panels[1] ;
function panel_radius()             = $panels[2] ;
function extend_front_and_rear_x()  = $panels[3] ; // extend_front_and_rear_x() panels by this to make the sides bigger.
function extend_bottom_panel_x()    = $panels[4] ; // extend_front_and_rear_x() panels by this to make the sides bigger.
function extendz()                  = $panels[5] ; // extend panels down to cover the feet. 53 covers the feet
function panel_screw_offset()       = $panels[6] ;  // // $panels[5] - 50 in original 300ZL and 300ZLT with 1515 extrusion. 42.5 in the 250ZL
function max_panel_screw_spacing()  = $panels[7] ;  // maximum spacing allowed for the panels (exactly 100 for the 250ZL, FIXME: test this )
function include_bottom_braces()    = $panels[8] ;

// CONSTRAINTS
// This sets how far from centerline of the machine the idler stack on the x-carriages is.
function motor_pulley_link()  = frame_size().y / 2 - rail_height(rail_profiles().x) - carriage_height(rail_profiles().x) - extrusion_width() ;
function bearing_block()      = false;  ;  // use ZLT-style bearing blocks on the leadscrews - will come on automatically if leadscrew height > 500

// electronics box
function expand_acrylic_cover_adjustment() = 29 ;  // rounded corners for cover, to match the printed corners.
function move_panels_outwards_adjust() = 49 ;  // 48.5 based on existing corners
function move_corners_adjust() = 9.5 ;  // move the corners by this
function acrylic_cover_corner_rounding() = 14 ; // rounding acrylic cover to match the corners
function screwy() = (-box_size_y()/2 + move_corners_adjust() - 20);
function screwz() = ( box_size_z()/2 - move_corners_adjust() + 20);

//ELECTRONICS BOX CORNERS
function elec_corner_size() = 15;
function elec_corner_ledge_width() = 10;
function elec_corner_ledge_thickness() = 7;   //lostapathy setting - 4 is standard
function elec_corner_holesize() = 4.75;    // lostapathy setting - 3.5 is standard
