// vim: set nospell:
include <lib.scad>
include <colors.scad>

epsilon=0.01;  // epislon value for OpenSCAD reasons :)
inch = 25.4; // convert imperial units

extrusion=15;     // extrusion size for all extrusions.

railXlength=400; // rail lengths will probably be linked to something else at some point?
railYlength=400;
railZlength=400;

// BOM FRAME COMPONENTS
screwM=3; //M3 hardware for panels
// extrusion size, rail size and screw size for panels and anything attaching to extrusions will be linked
Zheight=300; // printable height 300 for ZL and 600 for ZLT

// I should probably get this lot below into an array of some sort.
leadscrewX1=35; //until I can find a better name
leadscrewX2=455; //until I can find a better name
leadscrewY1=87.75; //ditto
leadscrewY2=342.79; //ditto
leadscrewY3=215.25; //ditto
towerY1=97.4;
towerY2=305.4;
towerY3=224.9;

couplerheight=5;  //a height for coupler
Zincrease=115;

fullZsize=Zheight+Zincrease;
//corneruprightZ=415; // Misumi pre-cut (Corner Uprights)
corneruprightZ=415; //fullZsize+(2*extrusionincrease);
extrusionincrease=0;


horizontalX=462 ; //bedX+extrusionincrease+160;
//echo("extrusionincrease are ", extrusionincrease);

//horizontalY=425;  // Misumi pre-cut (Horizontal Y)
horizontalY=425; //bedY+bedYspacing+(2*extrusionincrease);
echo("horizontalY are ", horizontalY);

paneldepth=0.25*inch;     // Depth of side panels (HDPE/plywood/etc) - THIS SHOULD BE LINKED TO SCREW SIZE
panelX=horizontalX+extrusion*2;
panelY=horizontalY+extrusion*2;
panelZ=corneruprightZ+extrusion*2;

rail_type_z=MGN12;
carriage_type_z=MGN12_carriage; // This is stupid we have to define it twice, but nopscadlib is goofy

// These define how far from the part origin of the z-tower the leadscrew is
leadscrew_x_offset = 20;
leadscrew_y_offset = 30.013; // taken off z yoke in fusion


// How far in from edge to start panel screws
panel_screw_offset=extrusion + 35; // 50 in original 1515 machine


assert(panel_screw_offset > extrusion + 10, "Panel Screws must be offset clear of the corner cubes");
