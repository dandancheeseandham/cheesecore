include <core.scad>
include <lib.scad>
include <extrusion.scad>
include <opencoreparts.scad>

$preview=true;
$fullrender=false;

// BOM FRAME COMPONENTS					
extrusion=15;     // extrusion size for all extrusions.
screwM=3; //M3 hardware for panels

extrusionincrease=extrusion-15; // because design is based on 1515

//BED
bedX=300;  // bed printable X
bedY=300;  // bed printable Y
bedYspacing=125; // extra space around Y
Zheight=300; // printable height 300 for ZL and 600 for ZLT

bedplateX=bedX+25; // bed plate size X
bedplateY=bedY+41; // bed plate size Y
bedcornerrounding=7.5; // bed plate corner rounding
beddepth=6.35; // depth of bed tool plate
bedlipX=12.5; // lip of bed for mounting
railXlength=400; 
railYlength=400;
railZlength=400;

epsilon=0.01;

horizontalX=bedX+extrusionincrease+160;
echo("bedX are ", bedX);
echo("extrusionincrease are ", extrusionincrease);

//rods/motors/motorholes/couplers
backleft_tower=[extrusion,extrusion+305.4,0];
frontleft_tower=[extrusion,extrusion*2+97.4,0];
right_tower=[horizontalX,224.9+extrusion+extrusionincrease,0];
echo("ztowerextrusions are ", ztowerextrusions);





// BOM Item Name: 15x15x445 (Misumi HFS3-1515-445 )
// BOM Quantity: 3
// BOM Link: http://railco.re/misumi
// Notes: Misumi pre-cut (For the Z tower Extrusions)
//ztowerextrusions=445;
ztowerextrusions=Zheight+115+(2*extrusion+extrusionincrease);



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
corneruprightZ=Zheight+115+(2*extrusionincrease);
corneruprights();

// BOM Item Name: 15x15x460 (Misumi HFS3-1515-460 )
// BOM Quantity: 4
// BOM Link: http://railco.re/misumi
// Notes: Misumi pre-cut (Horizontal X)
//horizontalX=460;  // Misumi pre-cut (Horizontal X)

echo("BOM Item Name: Quantity 4: 15x15x",horizontalX," (Misumi HFS3-1515-",horizontalX," )");
Xextrusions();



// BOM Item Name: 15x15 Corners (8)
// BOM Quantity: 1
// BOM Link: http://railco.re/1515corners
// Notes: 4 Spare corners after ordering
cornercube=extrusion; //1515 and 2020 these are the same
cornercubes();

// BOM Item Name: HDPE Side Panels
// BOM Quantity: 1
// BOM Link: http://railco.re/sidepanels
// Notes: DXFs available from here via
paneldepth=6;     // Depth of side panels (HDPE/plywood/etc) - LINK TO SCREW SIZE
panelcornerrounding=5; // Corner rounding of panels
screwholes=5;     // Number of screwholes // REDUNDANT?
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
tr8=4;  //pitch
leadscrews();

// BOM Item Name: TR8*4 anti-backlash nut (B-ABN84)
// BOM Quantity: 3
// BOM Link: http://railco.re/motion
// Notes: 



// BOM Item Name: 400mm MGN12H + carriage
// BOM Quantity: 6
// BOM Link: http://railco.re/motion
// Notes: MGN 12H-L400MM
sheet=3;
translate ([extrusion*2,extrusion*1.5+97.4,(Zheight+115)/2+30]) rotate([90,-90,90]) rail();
translate ([extrusion*2,extrusion*0.5+305.4,(Zheight+115)/2+30]) rotate([90,-90,90])  rail(railZlength);
translate ([horizontalX,224.9+extrusion*0.5+extrusionincrease,(Zheight+115)/2+30]) rotate([-90,-90,90]) rail(railZlength);

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


bed();

//debug
        echo ("window", windowwidth);
        echo ("panelX", panelX);
        echo ("horizontalX", horizontalX);
                echo ("horizontalX", horizontalX);
                
//
//BOM ELECTRONICS					
//


// BOM Item Name: 450mm TR8*4 leadscrew (400 will work)
// BOM Quantity: 3
// BOM Link: http://railco.re/sidepanels
// Notes: DXFs available from here via              
                
translate ([-100,-100,0]) pcb(DuetE);
translate ([-100,-220,0]) pcb(Duex5);
translate ([0,-220,0]) ssr_assembly(ssrs[1], M3_cap_screw, 3);
