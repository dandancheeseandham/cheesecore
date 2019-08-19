// vim: set nospell:
include <lib.scad>
include <colors.scad>
include <prefs.scad>
include <constants.scad>

bed_offset = [0, -25]; // How far to offset the bed from center of frame

extrusion=15;     // extrusion size for all extrusions.

rail_length=[400, 400, 400];

leadscrew_length = 400;

// BOM FRAME COMPONENTS
screwM=3; //M3 hardware for panels
// extrusion size, rail size and screw size for panels and anything attaching to extrusions will be linked

couplerheight=5;  //a height for coupler

extrusion_length= [462, 425, 415];

paneldepth=0.25*inch;     // Depth of side panels (HDPE/plywood/etc) - THIS SHOULD BE LINKED TO SCREW SIZE

rail_type_z=MGN12;
carriage_type_z=MGN12_carriage; // This is stupid we have to define it twice, but nopscadlib is goofy

// These define how far from the part origin of the z-tower the leadscrew is
leadscrew_x_offset = 20; // how far in x the centerline of the leadscrew is from the inside edge of the frame extrusions
leadscrew_y_offset = 30; // taken off z yoke in fusion

// How far in from edge to start panel screws
panel_screw_offset=extrusion + 35; // 50 in original 1515 machine

assert(panel_screw_offset > extrusion + 10, "Panel Screws must be offset clear of the corner cubes");
