// vim: set nospell:
include <core.scad>
include <lib.scad>
include <extrusion.scad>
include <opencoreparts.scad>
use <side_panels.scad>
include <frame.scad>
include <config.scad>

$preview=false;
$fullrender=false;

all_side_panels();


//rods/motors/motorholes/couplers
backleft_tower=0; //unused atm
frontleft_tower=0; //unused atm
right_tower=0; //unused atm
echo("ztowerextrusions are ", ztowerextrusions);



// NOTE , I'm using this BOM system initially to ensure I cover everything for the 1515 RC2 model. I understand the names,quantities etc can change.

// BOM Item Name: 15x15x445 (Misumi HFS3-1515-445 )
// BOM Quantity: 3
// BOM Link: http://railco.re/misumi
// Notes: Misumi pre-cut (For the Z tower Extrusions)
//ztowerextrusions=445;
ztowerextrusions=fullZsize+(2*extrusion+extrusionincrease);
Ztowerextrusions();





//////////////////////////
// BOM MOTION COMPONENTS
//////////////////////////

// BOM Item Name: 450mm TR8*4 leadscrew (400 will work)
// BOM Quantity: 3
// BOM Link: http://railco.re/motion
// Notes: DXFs available from here via

// Choose one of three
// leadscrewheight=ztowerextrusions-15; // (1) real height
// leadscrewheight=ztowerextrusions-45; // (2) "will work"
leadscrewheight=ztowerextrusions+5; // (3) BOM
echo(leadscrewheight, "mm TR8*4 leadscrew");
leadscrewwidth=8;
tr8=4;  //pitch - currently unused
leadscrews();

// BOM Item Name: TR8*4 anti-backlash nut (B-ABN84)
// BOM Quantity: 3
// BOM Link: http://railco.re/motion
// Notes:



// BOM Item Name: 400mm MGN12H + carriage
// BOM Quantity: 6
// BOM Link: http://railco.re/motion
// Notes: MGN 12H-L400MM
sheet=3;  //removing this breaks nopheads stuff. Find out why.

translate ([extrusion*2,extrusion*1.5+towerY1,(fullZsize)/2+couplerheight]) rotate([90,-90,90]) rail();
translate ([extrusion*2,extrusion*0.5+towerY2,(fullZsize)/2+couplerheight]) rotate([90,-90,90])  rail(railZlength);
translate ([horizontalX,towerY3+extrusion*0.5+extrusionincrease,(fullZsize)/2+couplerheight]) rotate([-90,-90,90]) rail(railZlength);

translate ([panelX/2,horizontalY+extrusion,corneruprightZ+extrusion*1.5]) rotate([90, 0, 0]) rail(railXlength);
translate ([panelX/2,extrusion,corneruprightZ+extrusion*1.5])  rotate([-90, 0, 0]) rail(railXlength);
translate ([250,230,corneruprightZ+extrusion*1.5]) rotate([90, 0, 90]) rail(railYlength);

// BOM Item Name: 16 tooth 5mm bore GT2 Pulley
// BOM Quantity: 2
// BOM Link: http://railco.re/motion
// Notes: For X/Y/Z steppers (Only 2 needed for the ZL Build)

// BOM Item Name: Gt2 smooth idlers 5mm ID
// BOM Quantity: 2
// BOM Link: http://railco.re/motion
// Notes:

// BOM Item Name: Gt2 20 tooth idlers 5mm ID
// BOM Quantity: 6
// BOM Link: http://railco.re/motion
// Notes: for corexy motion gear

// BOM Item Name: 5mm I.D. x 6mm O.D. x 0.40mm Shim
// BOM Quantity: 1 pack
// BOM Link: http://railco.re/motion
// Notes: For shimming the bearings

// BOM Item Name: GT2 Belt (5m)
// BOM Quantity: 1
// BOM Link: http://railco.re/motion
// Notes: X/Y Motion belts (4400mm total, 2200mm per side)
translate ([250,200,corneruprightZ+50]) rotate ([0,0,90])  corexy_belt();





//
//BOM ELECTRONICS
//


// BOM Item Name: 24v PSU 350w PSU (needs to be 200w or greater with AC bed)
// BOM Quantity: 1
// BOM Link: http://railco.re/sidepanels
// Notes: DAny 24v PSU > 200W works with the AC bed.
//rotate([90,0,90])
// translate(panelY-100,panelZ-100,paneldepth)
translate ([50,-320,0]) psu(S_250_48);


//random extras
translate ([panelX/2,panelY/2,300]) bed();

translate([panelY+40,panelZ-100,280]) rotate([90,90,90])  psu(S_250_48);
translate([panelY+40,panelZ-300,330]) rotate([90,0,90])  pcb(DuetE);
translate([panelY+40,panelZ-200,430]) rotate([90,0,90])  translate ([-100,-220,0]) pcb(Duex5);
translate([panelY+40,panelZ-200,130]) rotate([90,0,90])  ssr_assembly(ssrs[1], M3_cap_screw, 3);
translate ([leadscrewX1+extrusionincrease,leadscrewY1+extrusionincrease,-paneldepth]) NEMA(NEMA17);
translate ([leadscrewX1+extrusionincrease,leadscrewY2+extrusionincrease,-paneldepth]) NEMA(NEMA17);
translate ([leadscrewX2+extrusionincrease,leadscrewY3,-paneldepth]) NEMA(NEMA17);
translate ([50,-220,0]) hot_end(E3Dv6);
translate ([50,-150,0]) iec(IEC_fused_inlet);
translate ([50,-120,0]) leadnut(LSN8x8);
//translate ([50,-320,0]) psu(S_250_48);


//debug nonsense
        echo ("panelX", panelX);
        echo ("horizontalX", horizontalX);
