// vim: set nospell:
include <colors.scad>
include <prefs.scad>
include <constants.scad>
include <nopscadlib/vitamins/rails.scad>

// *************************************************************************************************************************************************
// USER DEFINED

function aluminium_part_depth() = 6 ;
function panel_radius() = 5;
function panel_thickness() = 0.25 * inch ;        // EU would be 6mm
function acrylic_door_thickness() = 0.25 * inch ; // EU would be 6mm

// FRAME
//                   sizeX sizeY sizeZ
frame_rc300zl      = [490, 455, 445];
frame_rc300zl4040  = [540, 500, 475];
frame_rc300zlt     = [490, 455, 745];
frame_rc300_custom = [490, 455, 445];

// RAILS
//              sizeX  Xtype  sizeY  Ytype    sizeZ Ztype
rails_rc300zl = [[400, MGN12], [400, MGN12], [400, MGN12]];
rails_rc300zlt= [[400, MGN12], [400, MGN12], [700, MGN12]];
rails_custom  = [[400, MGN12], [400, MGN12], [400, MGN12]];

// FRONT WINDOW / DOOR
//                            name       sizeXY   depth thick
front_window_zl      = ["WINDOW_TYPE", [420, 385], 10, [0, 5]];
front_window_zlt     = ["WINDOW_TYPE", [410, 645], 10, [0, 0]];
front_window_custom  = ["WINDOW_TYPE", [420, 385], 10, [0, 5]];

// ELECTRONICS BOX ALONG WITH  & ELECTRONICS & CABLE PLACEMENT -  placement of parts on right panel with X/Y as centre
//               name       sizeX  sizeY  depth thick, lasercut cable_bundle    DuetE            Duex              PSU        SSR
elec_ZL     = ["ELEC.BOX", 298.9, 238.9, 59 ,   6,     true,   [-84,126.5,0], [-84.82,50.5,0], [-84.82,-59.5,0], [60,00,0],  [145,50,0] ] ;
elec_ZLT    = ["ELEC.BOX", 298.9, 438.9, 59 ,   6,     false,  [-84,226.5,0], [-84.82,150.5,0],[-84.82,40.5,0],  [80,80,0],  [0,-110,0] ] ;
elec_new_ZL = ["ELEC.BOX", 320,   300,   59 ,   6,     false,  [-84,146.5,0], [-85,70,0],      [-85,-40,0],      [100,50,0], [30,-110,0] ] ;
elec_new_ZLT= ["ELEC.BOX", 298.9, 438.9, 59 ,   6,     false,  [-84,166.5,0], [-84.82,50.5,0], [-84.82,-59.5,0], [80,30,0],  [30,-110,0] ] ;
elec_custom = ["ELEC.BOX", 298.9,  238.9, 59 ,  6,     true,   [-84,126.5,0], [-84.82,50.5,0], [-84.82,-59.5,0], [60,00,0],  [145,50,0] ] ;

// ENCLOSURE BOX - size and shape - left unconstrained from the frame
//                       X    Y    Z
enclosure_rc300zl    = [490, 455, 245];
enclosure_rc300zlt   = [490, 455, 245];
enclosure_rc300zl4040= [540, 500, 275];
enclosure_custom     = [490, 455, 245];

// LEADSCREW_SPECS
//                        Name          height diameter
leadscrew_rc300zl   = ["LEADSCREW_SPECS", 400, 8];
leadscrew_rc300zlt  = ["LEADSCREW_SPECS", 700, 8];
leadscrew_rc_custom = ["LEADSCREW_SPECS", 400, 8];
// BED
//             name  bed_plate_size   motor space  bed_overall_size  bed thickness
bed_rc300 =  ["BED", [325, 342], 255, [335, 342],0.25 * inch];
bed_custom = ["BED", [325, 342],      295,         [335, 342],       0.25 * inch];
// NOTE: CAN X SIZE CONSTRAIN TO EXTRUSION & RAIL SIZE?

// MANUFACTURER DEFINED
// Extrusion information
//                              nominal size
//                                   nominal screw size
extrusion15 = ["1515 Extrusion", 15, 3];
extrusion20 = ["2020 Extrusion", 20, 4];
extrusion30 = ["3030 Extrusion", 30, 5];
extrusion40 = ["4040 Extrusion", 40, 6];


// *************************************************************************************************************************************************


// Still need to clean up everything below here
bed_offset = [0, -12.5]; // How far to offset the bed from center of frame
// These define how far from the part origin of the z-tower the leadscrew is
leadscrew_x_offset = 20 ; // how far in x the centerline of the leadscrew is from the inside edge of the frame extrusions
leadscrew_y_offset = 30 ; // taken off z yoke in fusion
//RC300BED = 42; // FIXME: build out an actual bed model
//           type,  dimensions, ear spacing, nominal mount distance in x
// Note that we don't specify the finer points of the bed ears here, because it doesn't affect how the printer lays out, that's an impelementation detail fo ths bed model

function NEMAtype() = NEMA17 ;


function bed_plate_size() = $bed[1];
function bed_ear_spacing() = $bed[2];
function bed_overall_size() = $bed[3];
function bed_thickness() = $bed[4];

function leadscrew_length() = $leadscrew_specs[1];
function leadscrew_diameter() = $leadscrew_specs[2];

function frame_size() = $frame_size;

function rail_lengths() = [$rail_specs.x[0], $rail_specs.y[0], $rail_specs.z[0]];
function rail_profiles() = [$rail_specs.x[1], $rail_specs.y[1], $rail_specs.z[1]];

function front_window_size() = $front_window_size[1];
function front_window_radius() = $front_window_size[2];
function front_window_offset() = $front_window_size[3];

// How far in from edge to start panel screws
function panel_screw_offset() = extrusion_width($extrusion_type) + 35; // 50 in original 1515 machine
// Max allowable distance between screws on front panels
function max_panel_screw_spacing() = 100;

function box_size_y() = $elecbox[1] ;
function box_size_z() = $elecbox[2] ;
function box_depth() = $elecbox[3] ;
function acrylic_thickness() = $elecbox[4] ;
function laser_cut_vents() = $elecbox[5] ;

function cable_bundle_hole_placement() = $elecbox[6] ;
function DuetE_placement()  = $elecbox[7] ;
function Duex5_placement() = $elecbox[8] ;
function psu_placement() = $elecbox[9] ;
function ssr_placement() = $elecbox[10] ;
function enclosure_size() = $enclosure_size ;


function extrusion_width(extrusion_type = $extrusion_type) = extrusion_type[1];
function extrusion_screw_size(extrusion_type = $extrusion_type) = extrusion_type[2];

// CONSTRAINTS
function motor_pulley_link() = frame_size().y / 2 - rail_height(rail_profiles().x) - carriage_height(rail_profiles().x) - extrusion_width();



































$draft = true;
