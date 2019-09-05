// vim: set nospell:
include <colors.scad>
include <prefs.scad>
include <constants.scad>
include <nopscadlib/vitamins/rails.scad>

// Extrusion information
//                              nominal size
//                                   nominal screw size
extrusion15 = ["1515 Extrusion", 15, 3];
extrusion20 = ["2020 Extrusion", 20, 4];
extrusion30 = ["3030 Extrusion", 30, 5];
extrusion40 = ["4040 Extrusion", 40, 6];

function extrusion_width(extrusion_type = $extrusion_type) = extrusion_type[1];
function extrusion_screw_size(extrusion_type = $extrusion_type) = extrusion_type[2];

// Still need to clean up everything below here
bed_offset = [0, -12.5]; // How far to offset the bed from center of frame

// These define how far from the part origin of the z-tower the leadscrew is
leadscrew_x_offset = 20 ; // how far in x the centerline of the leadscrew is from the inside edge of the frame extrusions
leadscrew_y_offset = 30 ; // taken off z yoke in fusion
gap_between_motors = 255 ;   // 255 is standard for ZL/ZLT , based on bed tongues

RC300BED = 42; // FIXME: build out an actual bed model

//          Extrusion
//              Extrusion length
//                               Rail Length
//                                                Rail types
//                                                                         leadscrew length
//                                                                              leadscrew diameter
//                                                                                 panel thickness
//                                                                                          bed model
//            0                1                2                      3    4   5          6         7
rc300zl  = [ undef, undef, undef, undef, 400,  8, 0.25*inch, RC300BED ];
rc300zl20  = [ undef, undef, undef, undef, 400,  8, 0.25*inch, RC300BED ];
rc300zlt = [ undef, undef, undef, undef, 700,  8, 0.25*inch, RC300BED ];

cc300zl  = [ undef, undef, undef, undef, 400, 10, 0.25*inch, RC300BED ];
absurdo  = [ undef, undef, undef, undef, 400, 10, 0.25*inch, RC300BED ];

andy  = [ undef, undef, undef, undef, 250, 8, 6, RC300BED ];
dan =  [ undef, undef, undef, undef, 400, 10, 6, RC300BED ];

model = rc300zl ;
//model = rc300zlt;
//model = cc300zl;
//model = absurdo; leadscrew_y_offset= 40;

leadscrew_length = model[4];

frame_rc300zl  = [490, 455, 445];
frame_rc300zl4040  = [540, 500, 475];
frame_rc300zlt = [490, 455, 745];

function frame_size() = $frame_size;
function panel_radius() = 5;
function panel_thickness() = 0.25 * inch;

rails_rc300zl = [[400, MGN12], [400, MGN12], [400, MGN12]];
rails_rc300zlt = [[400, MGN12], [400, MGN12], [700, MGN12]];

function rail_lengths() = [$rail_specs.x[0], $rail_specs.y[0], $rail_specs.z[0]];
function rail_profiles() = [$rail_specs.x[1], $rail_specs.y[1], $rail_specs.z[1]];

front_window_zl  = ["WINDOW_TYPE", [420, 385], 10, [0, 5]];
front_window_zlt = ["WINDOW_TYPE", [410, 645], 10, [0, 0]];

function front_window_size() = $front_window_size[1];
function front_window_radius() = $front_window_size[2];
function front_window_offset() = $front_window_size[3];

// How far in from edge to start panel screws
function panel_screw_offset() = extrusion_width($extrusion_type) + 35; // 50 in original 1515 machine
// Max allowable distance between screws on front panels
function max_panel_screw_spacing() = 100;

$draft = true;
