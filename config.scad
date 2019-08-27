// vim: set nospell:
include <nopscadlib/lib.scad>
include <colors.scad>
include <prefs.scad>
include <constants.scad>

bed_offset = [0, -25]; // How far to offset the bed from center of frame

couplerheight=5;  //a height for coupler


// These define how far from the part origin of the z-tower the leadscrew is
leadscrew_x_offset = 20; // how far in x the centerline of the leadscrew is from the inside edge of the frame extrusions
leadscrew_y_offset = 30; // taken off z yoke in fusion

// Extrusion information
//             nominal size
//                 nominal screw size
extrusion15 = ["1515 Extrusion", 15, 3];
extrusion20 = ["2020 Extrusion", 20, 4];
extrusion30 = ["3030 Extrusion", 30, 5];
extrusion40 = ["4040 Extrusion", 40, 6];

function extrusion_width(extrusion_type) = extrusion_type[1];
function extrusion_screw_size(extrusion_type) = extrusion_type[2];


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
rc300zl  = [ extrusion15, [460, 425, 415], [400, 400, 400], [MGN12, MGN12, MGN12], 400,  8, 0.25*inch, RC300BED ];
rc300zl20  = [ extrusion20, [460, 425, 415], [400, 400, 400], [MGN12, MGN12, MGN12], 400,  8, 0.25*inch, RC300BED ];
rc300zlt = [ extrusion15, [460, 425, 715], [400, 400, 700], [MGN12, MGN12, MGN12], 700,  8, 0.25*inch, RC300BED ];

cc300zl  = [ extrusion20, [470, 425, 415], [450, 400, 400], [MGN12, MGN12, MGN12], 400, 10, 0.25*inch, RC300BED ];
absurdo  = [ extrusion40, [470, 425, 415], [450, 400, 400], [MGN12, MGN12, MGN12], 400, 10, 0.25*inch, RC300BED ];

andy  = [ extrusion20, [370, 375, 315], [300, 350, 300], [MGN9, MGN12, MGN9], 250, 8, 6, RC300BED ];

model = rc300zl ;
//model = rc300zlt;
//model = cc300zl;
//model = absurdo; leadscrew_y_offset= 40;

extrusion_type = model[0];
screwM = model[0][1];
extrusion_length = model[1];
rail_length = model[2];
leadscrew_length = model[4];
paneldepth = model[6];


rail_type_z = model[3].z;
carriage_type_z=rail_carriage(rail_type_z);

// How far in from edge to start panel screws
panel_screw_offset=extrusion_width(extrusion_type) + 35; // 50 in original 1515 machine

assert(panel_screw_offset > extrusion_width(extrusion_type) + 10, "Panel Screws must be offset clear of the corner cubes");
// Need to also check that there is enough room for the anti-backlash nut in the yoke
assert(leadscrew_y_offset >= leadscrew_x_offset + extrusion_width(extrusion_type) / 2, "Z stepper screws will be hidden");
