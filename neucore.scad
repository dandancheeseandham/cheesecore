include <core.scad>
include <lib.scad>
include <extrusion.scad>
include <opencoreparts.scad>

$preview=false;
$fullrender=false;

// BOM FRAME COMPONENTS					
extrusion=15;     // extrusion size for all extrusions.
screwM=3; //M3 hardware for panels
// extrusion size, rail size and screw size for panels and anything attaching to extrusions will be linked
Zheight=300; // printable height 300 for ZL and 600 for ZLT
extrusionincrease=extrusion-15; // because design is based on 1515

//BED
bedX=300;  // bed printable X
bedY=300;  // bed printable Y
bedplateX=bedX+25; // bed plate size X
bedplateY=bedY+41; // bed plate size Y
bedcornerrounding=7.5; // bed plate corner rounding
beddepth=6.35; // depth of bed tool plate
bedlipX=12.5; // lip of bed for mounting
bedYspacing=125; // extra space around Y


railXlength=400; // rail lengths will probably be linked to something else at some point?
railYlength=400;
railZlength=400;

epsilon=0.01;  //epislon value for OpenSCAD reasons :)

horizontalX=bedX+extrusionincrease+160;
echo("bedX is ", bedX);
echo("extrusionincrease are ", extrusionincrease);

//rods/motors/motorholes/couplers
backleft_tower=0; //unused atm
frontleft_tower=0; //unused atm
right_tower=0; //unused atm
echo("ztowerextrusions are ", ztowerextrusions);

// I should probably get this lot below into an array of some sort.
leadscrewX1=35; //until I can find a better name
leadscrewX2=455; //until I can find a better name
leadscrewY1=87.75; //ditto
leadscrewY2=342.79; //ditto
leadscrewY3=215.25; //ditto
towerY1=97.4;
towerY2=305.4;
towerY3=224.9;


couplerheight=30;  //an arbitary height increase during development
Zincrease=115;
fullZsize=Zheight+Zincrease;

// NOTE , I'm using this BOM system initially to ensure I cover everything for the 1515 RC2 model. I understand the names,quantities etc can change.

// BOM Item Name: 15x15x445 (Misumi HFS3-1515-445 )
// BOM Quantity: 3
// BOM Link: http://railco.re/misumi
// Notes: Misumi pre-cut (For the Z tower Extrusions)
//ztowerextrusions=445;
ztowerextrusions=fullZsize+(2*extrusion+extrusionincrease);
Ztowerextrusions();

// BOM Item Name: 15x15x425 (Misumi HFS3-1515-425 )
// BOM Quantity: 4
// BOM Link: http://railco.re/misumi
// Notes: Misumi pre-cut (Horizontal Y)
//horizontalY=425;  // Misumi pre-cut (Horizontal Y)
horizontalY=bedY+bedYspacing+(2*extrusionincrease);
echo("horizontalY are ", horizontalY);
horizontalYextrusions();

// BOM Item Name: 15x15x415 (Misumi HFS3-1515-415 )
// BOM Quantity: 4
// BOM Link: http://railco.re/misumi
// Notes: Misumi pre-cut (Corner Uprights)
//corneruprightZ=415; // Misumi pre-cut (Corner Uprights)
corneruprightZ=fullZsize+(2*extrusionincrease);
corneruprights();

// BOM Item Name: 15x15x460 (Misumi HFS3-1515-460 )
// BOM Quantity: 4
// BOM Link: http://railco.re/misumi
// Notes: Misumi pre-cut (Horizontal X)
//horizontalX=460;  // Misumi pre-cut (Horizontal X)

// Manaul attempt at BOM generation :)
echo("BOM Item Name: Quantity 4: 15x15x",horizontalX," (Misumi HFS3-1515-",horizontalX," )");
Xextrusions();



// BOM Item Name: 15x15 Corners (8)
// BOM Quantity: 1
// BOM Link: http://railco.re/1515corners
// Notes: 4 Spare corners after ordering
cornercube=extrusion; //1515 and 2020 these are the same. 3030 and 4040 will need to look at corner braces perhaps?
cornercubes();

// BOM Item Name: HDPE Side Panels
// BOM Quantity: 1
// BOM Link: http://railco.re/sidepanels
// Notes: DXFs available from here via
paneldepth=6;     // Depth of side panels (HDPE/plywood/etc) - THIS SHOULD BE LINKED TO SCREW SIZE
panelcornerrounding=5; // Corner rounding of panels
screwholes=5;     // Number of screwholes // IS THIS REDUNDANT?
// Define Panel Window Area (ZL match)
Xwindowspacing=35;
Zwindowspacingtop=25;  // 25 for ZL , 50 for ZLT
Zwindowspacingbottom=35;  // 35 for ZL , 50 for ZLT

panelX=horizontalX+extrusion*2;
panelY=horizontalY+extrusion*2;
panelZ=corneruprightZ+extrusion*2;

windowwidth = panelX - (Xwindowspacing*2);
windowheight = panelZ - (Zwindowspacingtop+Zwindowspacingbottom);


//Bottom Panel
panel(panelX,panelY,paneldepth,"bottom");
//Front Panel
rotate([90,0,0])
panel(panelX,panelZ,paneldepth,"front");
//Left Panel
rotate([90,0,90])  
panel(panelY,panelZ,paneldepth);
//Right panel
translate ([panelX+paneldepth/2,0,0]) 
rotate([90,0,90]) 
panel(panelY,panelZ,paneldepth);
//Back Panel
translate ([0,panelY+paneldepth/2,0]) 
rotate([90,0,0]) 
panel(panelX,panelZ,paneldepth);

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
translate ([250,200,corneruprightZ+50]) rotate ([0,0,90])  corexy_belt()





                
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
        echo ("window", windowwidth);
        echo ("panelX", panelX);
        echo ("horizontalX", horizontalX);