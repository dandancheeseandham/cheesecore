// vim: set nospell:
include <lib.scad>
include <colors.scad>
include <prefs.scad>
include <constants.scad>

bed_offset = [0, -25]; // How far to offset the bed from center of frame


// BOM FRAME COMPONENTS
screwM=3; //M3 hardware for panels
// extrusion size, rail size and screw size for panels and anything attaching to extrusions will be linked

couplerheight=5;  //a height for coupler


// These define how far from the part origin of the z-tower the leadscrew is
leadscrew_x_offset = 20; // how far in x the centerline of the leadscrew is from the inside edge of the frame extrusions
leadscrew_y_offset = 30; // taken off z yoke in fusion

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
rc300zl  = [ 15, [460, 425, 415], [400, 400, 400], [MGN12, MGN12, MGN12], 400,  8, 0.25*inch, RC300BED ];
rc300zlt = [ 15, [460, 425, 715], [400, 400, 700], [MGN12, MGN12, MGN12], 700,  8, 0.25*inch, RC300BED ];

cc300zl  = [ 20, [470, 425, 415], [450, 400, 400], [MGN12, MGN12, MGN12], 400, 10, 0.25*inch, RC300BED ];
absurdo  = [ 40, [470, 425, 415], [450, 400, 400], [MGN12, MGN12, MGN12], 400, 10, 0.25*inch, RC300BED ];

model = rc300zl;
//model = rc300zlt;
//model = cc300z4;

extrusion = model[0];
extrusion_length = model[1];
rail_length = model[2];
leadscrew_length = model[4];
paneldepth = model[6];


rail_type_z = model[3].z;
carriage_type_z=rail_carriage(rail_type_z);

// How far in from edge to start panel screws
panel_screw_offset=extrusion + 35; // 50 in original 1515 machine

assert(panel_screw_offset > extrusion + 10, "Panel Screws must be offset clear of the corner cubes");
// Need to also check that there is enough room for the anti-backlash nut in the yoke
assert(leadscrew_y_offset >= leadscrew_x_offset + extrusion/2, "Z stepper screws will be hidden");
