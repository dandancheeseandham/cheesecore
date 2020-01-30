// vim: set nospell:
include <colors.scad>
include <prefs.scad>
include <constants.scad>
use <validation.scad>
use <core.scad>
include <nopscadlib/vitamins/rails.scad>
include <nopscadlib/vitamins/stepper_motors.scad>
$draft = true;
// *************************************************************************************************************************************************

// FRAME - either specify frame size complete or specify extrusion sizes and addon the "framecornercubes()""
//                        sizeX sizeY sizeZ
//Standard
frame_original_rc150mini= [270, 270, 270] + framecornercubes(); // defining extrusion size and then adding frame corner cubes
frame_original_rc250zl  = [400, 370, 360] + framecornercubes();
frame_original_rc300zl  = [460, 425, 415] + framecornercubes();
frame_original_rc300zlt = [460, 425, 715] + framecornercubes();
//Experimental
frame_rc300zl4040       = [590, 555, 545];
frame_rc300_steel300zl  = [460, 445, 415] + framecornercubes();
frame_rc300_steel300zl2 = [490, 500, 460];
frame_rc300_custom      = [490, 500, 460];

// PANEL - Sides, halo and doors.
//                        Panel                   Door          Extend       Panel Screw
//                      thickness        radius thickness       panels by X   Offset
//Standard
panels_imperial  = ["PANELS",0.25 * inch,  5,    0.25 * inch,       0,         50];
panels_metric    = ["PANELS",6,            5,          5,           0,         50];
panels_aluminium = ["PANELS",3,            5,          6,           0,         50];
panels_steel     = ["PANELS",2,            5,          6,           0,         50];
//Experimental
panels_custom    = ["PANELS",6,            5,          5,           0,         35+20];

// FIXME: Why does a number work, but not $panels[1]???
function side_panel_thickness()     = 2 ; // $panels[1]
function panel_radius()             = 5; // $panels[2]
function extendx()                  = 0; // extendx() panels by this to make the sides bigger.
function extendy()                  = 0; // extendx() panels by this to make the sides bigger.
function panel_screw_offset()       = extrusion_width() + 35 ; // // $panels[5] - 50 in original 300ZL and 300ZLT with 1515 extrusion. 42.5 in the 250ZL
// Max allowable distance between screws on front panels
function max_panel_screw_spacing()  = 100 ;// maximum spacing allowed for the panels (exactly 100 for the 250ZL, FIXME: test this )
function feetheight()               = $feet_depth;
function bottom_braces()            = false ;
function back_panel_enclosure()     = false;  // is there an additional electronics box on the rear panel? FIXME: FInish off and allow conduit holes.

// FRONT WINDOW / DOOR
//                            name       sizeXY   depth thick
function acrylic_door_thickness() = 0.25 * inch ; // EU would be 6mm
//UNMEASURED front_window_original_250zl   = ["WINDOW_TYPE", [420, 385], 10, [0, 5]];
front_window_original_150mini = ["WINDOW_TYPE", [245, 210], 10, [0, 5]];
front_window_original_250zl   = ["WINDOW_TYPE", [370, 335], 10, [0, 5]];
front_window_original_300zl   = ["WINDOW_TYPE", [420, 385], 10, [0, 5]];
front_window_original_300zlt  = ["WINDOW_TYPE", [410, 645], 10, [0, 0]];
front_window_custom           = ["WINDOW_TYPE", [420, 385], 10, [0, 0]];

// RAILS
//                  sizeX  Xtype  sizeY  Ytype    sizeZ Ztype
//Standard
rails__original_rc150mini = [[245, MGN12], [245, MGN12], [245, MGN12]];
rails__original_rc250zl   = [[350, MGN12], [350, MGN12], [350, MGN12]];
rails__original_rc300zl   = [[400, MGN12], [400, MGN12], [400, MGN12]];
rails__original_rc300zlt  = [[400, MGN12], [400, MGN12], [700, MGN12]];
//Experimental
rails_rc300zl4040         = [[500, MGN15], [500, MGN12], [500, MGN15]];
rails_cheesecore300zl     = [[420, MGN12], [420, MGN12], [420, MGN12]];
rails_cheesecore300zl2    = [[420, MGN12], [645, MGN12], [420, MGN12]];
rails_custom              = [[420, MGN12], [445, MGN12], [420, MGN12]];

// ELECTRONICS BOX ALONG WITH  & ELECTRONICS & CABLE PLACEMENT -  placement of parts on right panel with X/Y as centre
//                                                      DIMENSIONS               |       POSITIONS
//                           name        sizeX  sizeY  depth thick, move lasercut   cable_bundle      DuetE            Duex            PSU        SSR            RPi
//                                                                  box
//Standard                                                         down
elecbox_original_rc150mini= ["ELEC.BOX", 298.9, 238.9, 59 ,   6,    25,    true,   [-84,126.5,0], [-84.82,50.5,0], [-84.82,-59.5,0], [90,30,0], [45,-115,0] , [90,30,0]] ;
elecbox_original_rc250zl  = ["ELEC.BOX", 298.9, 238.9, 59 ,   6,    25,    true,   [-400/2+106.68,390/2-101+25], [-84.82,50.5,0], [-84.82,-59.5,0], [90,30,0], [45,-115,0] , [90,30,0]] ;
elecbox_original_rc300zl  = ["ELEC.BOX", 348.9, 288.9, 59 ,   6,    25,    true,   [-84,126.5,0], [-84.82,50.5,0], [-84.82,-59.5,0], [90,30,0], [45,-115,0] , [90,30,0]] ;
elecbox_original_rc300zlt = ["ELEC.BOX", 298.9, 438.9, 59 ,   6,    25,    true,   [-84,226.5,0], [-84.82,150.5,0],[-84.82,40.5,0],  [80,75,0], [0,-110,0]  , [-90,-140,0]] ;
//Experimental
elec_ZL_Duet3             = ["ELEC.BOX", 298.9, 238.9, 59 ,   6,    25,    true,   [-84,126.5,0], [-84.82,50.5,0], [-84.82,-69.5,0], [90,30,0], [45,-115,0] , [-70,-60,0]] ;
elec_new_ZL               = ["ELEC.BOX", 340,   270,   59 ,   6,    25,    true,   [-84,146.5,0], [-85,70,0],      [-85,-40,0],      [100,50,0],[30,-110,0] , [-90,-140,0]] ;
elec_new_ZL_cheese        = ["ELEC.BOX", 348.9, 288.9, 59 ,   6,    25,    true,   [-84,146.5,0], [-85,70,0],      [-85,-40,0],      [100,50,0],[30,-110,0] , [-90,-140,0]] ;
elec_new_ZLT              = ["ELEC.BOX", 298.9, 438.9, 59 ,   6,    25,    true,   [-84,166.5,0], [-84.82,50.5,0], [-84.82,-59.5,0], [80,30,0], [30,-110,0] , [-90,-140,0]] ;
elec_steel300zl           = ["ELEC.BOX", 350,   260,   59 ,   6,    25,    true,   [-104,146.5,0],[-105,70,0],     [-105,-40,0],     [80,30,0], [70,-130,0] , [-60,-130,0]] ;
elec_cheesecore           = ["ELEC.BOX", 410,   290,   59 ,   6,    25,    true,   [-104,146.5,0],[-105,70,0],     [-105,-40,0],     [90,30,0], [70,-130,0] , [-60,-130,0]] ;
elec_miniplaceh           = ["ELEC.BOX", 118.9, 58.9,  59 ,   6,    25,    true,   [-84,126.5,0], [-84.82,50.5,0], [-84.82,-59.5,0], [60,00,0],  [145,50,0] , [-90,-140,0]] ;
elec_custom               = ["ELEC.BOX", 410,   310,   59 ,   6,    25,    false,  [-84,146.5,0], [-85,70,0],      [-85,-40,0],      [90,30,0], [70,-130,0] , [-90,-140,0]] ;


// HALO - Just XYZ at the moment. Z is panel thickness
// can be defined as unconstrained from the frame, or constrained using frame variables.
//Standard
halo_rc150mini                = [frame_original_rc150mini.x + 125 , frame_original_rc150mini.y + side_panel_thickness() * 2, 4];
halo_rc250zl                  = [frame_original_rc250zl.x + 150, frame_original_rc250zl.y + side_panel_thickness() * 2, 4];
halo_rc300zl                  = [frame_original_rc300zl.x + 150, frame_original_rc300zl.y + side_panel_thickness() * 2, 4];
halo_rc300zlt                 = [frame_original_rc300zlt.x + 150, frame_original_rc300zlt.y + side_panel_thickness() * 2, 4];
//Experimental
halo_rc300zlNEMA23            = [frame_original_rc300zl.x + 160, frame_original_rc300zl.y + side_panel_thickness() * 2 + 15, 4];
halo_rc300_steel300zl         = [frame_rc300_steel300zl.x + 150, frame_rc300_steel300zl.y + side_panel_thickness() * 2, 4];
halo_rc300steel300zlv1        = [638, 465 ,4];
halo_rc300steel300zlv2        = [640, 465 ,4];
halo_rc300steel300zlv2nema23  = [640+40, 465 ,4];


// ENCLOSURE BOX - size and shape - can be defined as unconstrained from the frame, or constrained using halo variables.
//                        X    Y    Z
//Standard
enclosure_rc150mini   = [halo_rc150mini.x, halo_rc150mini.y, 200];;
enclosure_rc250zl     = [halo_rc250zl.x, halo_rc250zl.y, 200];
enclosure_rc300zl     = [halo_rc300zl.x, halo_rc300zl.y, 200];
enclosure_rc300zlt    = [halo_rc300zlt.x, halo_rc300zlt.y, 200];
//Experimental
enclosure_rc300zl4040 = [590, 555, 245];
enclosure_steel300zl  = [633, 459, 245];
enclosure_cheesecore300zl = [490, 500, 245];
enclosure_custom      = frame_rc300_custom + [150, 3, -200];
function enclosure_height_above_frame() = 0 ; // For the printed interface arrangement. Uneeeded with the cheesecore halo. but Left for backwards compatibility.

// LEADSCREW_SPECS
// PCD holes are for the leadscrew nut diameter to the holes. Two are available on the Z-yoke.
//                        Name          height diameter   number of holes    PCD hole1 PCD hole2  hole size
//Standard
leadscrew_original_rc150mini= ["LEADSCREW_SPECS", 270, 8,     8,                 16,       22,          3.4];
leadscrew_original_rc250zl  = ["LEADSCREW_SPECS", 400, 8,     8,                 16,       22,          3.4];
leadscrew_original_rc300zl  = ["LEADSCREW_SPECS", 400, 8,     8,                 16,       22,          3.4];
leadscrew_original_rc300zlt = ["LEADSCREW_SPECS", 700, 8,     4,                 16,       22,          3.4];
//Experimental
leadscrew_rc_steel300zl = ["LEADSCREW_SPECS", 540, 8,     4,                 16,       22,          3.4];
leadscrew_rc_steel300zl2= ["LEADSCREW_SPECS", 420, 8,     4,                 16,       22,          3.4];
leadscrew_zl4040        = ["LEADSCREW_SPECS", 500, 8,     4,                 16,       22,          3.4];
leadscrew_rc_custom     = ["LEADSCREW_SPECS", 420, 8,     4,                 16,       22,          3.4];
function leadscrew_clearance() = 2; //central hole leadscrew clearance required for around the leadscrew so it does not hit the printed/milled part.

// BED
//                      name  bed_plate_size   motor space  bed_overall_size  bed thickness
//Standard
bed_standard_rc150mini= ["BED", [150, 167],      100,        [160, 167],        0.25 * inch];
bed_standard_rc250    = ["BED", [275, 281],      205,        [335, 342],        0.25 * inch];
bed_standard_rc300    = ["BED", [325, 342],      255,        [335, 342],        0.25 * inch];
//Experimental
bed_custom            = ["BED", [425, 442],      295,        [435, 442],        8];
// FIXME: what is the bed_overall_size for? Is it needed?


// NOTE: CAN X SIZE CONSTRAIN TO EXTRUSION & RAIL SIZE?

// MANUFACTURER DEFINED
// Extrusion information
//                              nominal size
//                                   nominal screw size
extrusion15 = ["1515 Extrusion", 15, 3];  // standard extrusion for RailCore II
extrusion20 = ["2020 Extrusion", 20, 4];
extrusion30 = ["3030 Extrusion", 30, 5];
extrusion40 = ["4040 Extrusion", 40, 6];

//This should be per machine


// *************************************************************************************************************************************************

// Still need to clean up everything below here
bed_offset = [0, -12.5]; // How far to offset the bed from center of frame
// These define how far from the part origin of the z-tower the leadscrew is
leadscrew_x_offset = 20 ; // how far in x the centerline of the leadscrew is from the inside edge of the frame extrusions
leadscrew_y_offset = 30 ; // taken off z yoke in fusion
//RC300BED = 42; // FIXME: build out an actual bed model
//           type,  dimensions, ear spacing, nominal mount distance in x
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

function bed_plate_size()   = $bed[1];
function bed_ear_spacing()  = $bed[2];
function bed_overall_size() = $bed[3];
function bed_thickness()    = $bed[4];

function leadscrew_length()           = $leadscrew_specs[1];
function leadscrew_diameter()         = $leadscrew_specs[2];
function leadscrew_number_of_holes()  = $leadscrew_specs[3];
function leadscrew_pcd1()             = $leadscrew_specs[4];
function leadscrew_pcd2()             = $leadscrew_specs[5];
function leadscrew_nut_screwholes()   = $leadscrew_specs[6];

function halo_size()          = $halo_size;
function halo_thickness()     = $halo_size.z ;

function rail_lengths()  = [$rail_specs.x[0], $rail_specs.y[0], $rail_specs.z[0]];
function rail_profiles() = [$rail_specs.x[1], $rail_specs.y[1], $rail_specs.z[1]];

function front_window_size()   = $front_window_size[1];
function front_window_radius() = $front_window_size[2];
function front_window_offset() = $front_window_size[3];

function box_size_y() = $elecbox[1] ;
function box_size_z() = $elecbox[2] ;
function box_depth()   = $elecbox[3] ;
function acrylic_thickness()  = $elecbox[4] ;
function movedown()           = $elecbox[5] ;
function laser_cut_vents()    = $elecbox[6] ;

function cable_bundle_hole_placement() = $elecbox[7] ;
function DuetE_placement()  = $elecbox[8] ;
function Duex5_placement()  = $elecbox[9] ;
function psu_placement()    = $elecbox[10] ;
function ssr_placement()    = $elecbox[11] ;
function rpi_placement()    = $elecbox[12] ;

function enclosure_size()   = $enclosure_size ;

// FIXME: corner cubes frame hack
function framecornercubes() = [15*2,15*2,15*2]; // add 15mm corner cubes to each end of the frame so we can specify EXTRUSION sizes for the frame
function top_enclosure_cornercubes() = [15*2,15*2,15*2]; // add 15mm corner cubes to each end of the frame so we can specify EXTRUSION sizes for the frame

// CONSTRAINTS
// This sets how far from centerline of the machine the idler stack on the x-carriages is.
function motor_pulley_link() = frame_size().y / 2 - rail_height(rail_profiles().x) - carriage_height(rail_profiles().x) - extrusion_width() ;
function bearing_block() = false;  ;  // use ZLT-style bearing blocks on the leadscrews - will come on automatically if leadscrew height > 500
