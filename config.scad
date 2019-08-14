// vim: set nospell:

epsilon=0.01;  //epislon value for OpenSCAD reasons :)

extrusion=15;     // extrusion size for all extrusions.
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

couplerheight=30;  //an arbitary height increase during development
Zincrease=115;

fullZsize=Zheight+Zincrease;
//corneruprightZ=415; // Misumi pre-cut (Corner Uprights)
corneruprightZ=fullZsize+(2*extrusionincrease);


horizontalX=bedX+extrusionincrease+160;
echo("bedX is ", bedX);
echo("extrusionincrease are ", extrusionincrease);

//horizontalY=425;  // Misumi pre-cut (Horizontal Y)
horizontalY=bedY+bedYspacing+(2*extrusionincrease);
echo("horizontalY are ", horizontalY);

paneldepth=6;     // Depth of side panels (HDPE/plywood/etc) - THIS SHOULD BE LINKED TO SCREW SIZE
panelX=horizontalX+extrusion*2;
panelY=horizontalY+extrusion*2;
panelZ=corneruprightZ+extrusion*2;
