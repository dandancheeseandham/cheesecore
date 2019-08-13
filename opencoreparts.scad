module panel(x,y,d,panel) 
{

difference() {
    color("Burlywood")
    translate ([x/2,y/2,0])
    rounded_rectangle([x,y,d], panelcornerrounding);
    screwholes(x,y);
    if (panel=="bottom") {
        //front left motor hole
        motorholes(35+extrusionincrease,87.75+extrusionincrease,-paneldepth);
        //rear left motor hole
        motorholes(35+extrusionincrease,87.75+255.04+extrusionincrease,-paneldepth)  ;
        //right motor hole
        motorholes(455+extrusionincrease,215.25+extrusionincrease,-paneldepth) ;
        }
    if (panel=="front") {
    translate ([windowwidth/2+Xwindowspacing,windowheight/2+Zwindowspacingbottom,0]) rounded_rectangle([windowwidth,windowheight,paneldepth], panelcornerrounding);
    }
}
}




module bed()
{
color([188/255,188/255,188/255]) 
translate ([panelX/2,panelY/2,300])
rounded_rectangle([bedplateX,bedplateY,beddepth], bedcornerrounding);
}


module horizontalYextrusions() 
{
        // Bottom Left Y
        translate ([0,extrusion,0]) 
        rotate([0,0,0]) 
        aluminiumextrusion(horizontalY,0);
        // Bottom Right Y
        translate ([horizontalX+extrusion,extrusion,0]) 
        rotate([0,0,0]) 
        aluminiumextrusion(horizontalY,0);
        // Top Left Y
        translate ([0,extrusion,corneruprightZ+extrusion]) 
        rotate([0,0,0]) 
        aluminiumextrusion(horizontalY,0);
        // Bottom Right Y
        translate ([horizontalX+extrusion,extrusion,corneruprightZ+extrusion])
        rotate([0,0,0]) 
        aluminiumextrusion(horizontalY,0);    
        echo("horizontalY are ", horizontalY , "mm");
        
}  

module Ztowerextrusions()
{
    //Tower Extrusions

//Front left tower
translate (frontleft_tower) 
//translate ([extrusion,extrusion*2+97.4,0]) 
rotate([90,0,0]) 
aluminiumextrusion(ztowerextrusions,0);

//back left tower
//translate ([extrusion,extrusion*2+90+180+paneldepth,000]) 
translate (backleft_tower) 
rotate([90,0,0]) 
aluminiumextrusion(ztowerextrusions,0);

//right tower
//translate ([horizontalX,224.9+extrusion+extrusionincrease,0])
translate (right_tower)
rotate([90,0,0]) 
aluminiumextrusion(ztowerextrusions,0);
}

module corneruprights()
{
    // Front Left Z
translate ([0,extrusion,extrusion]) 
rotate([90,0,0]) 
aluminiumextrusion(corneruprightZ,0);
// Front Right Z
translate ([horizontalX+extrusion,extrusion,extrusion]) 
rotate([90,0,0]) 
aluminiumextrusion(corneruprightZ,0);
// Rear Right Z
translate ([horizontalX+extrusion,horizontalY+extrusion*2,extrusion]) 
rotate([90,0,0]) 
aluminiumextrusion(corneruprightZ,0);
// Rear Left Z
translate ([0,horizontalY+extrusion*2,extrusion]) 
rotate([90,0,0]) 
aluminiumextrusion(corneruprightZ,0);
}

module Xextrusions()
{
    //Top Front X
translate ([extrusion,extrusion,corneruprightZ+extrusion]) 
rotate([0,0,-90]) 
aluminiumextrusion(horizontalX,0);
//Top Rear X
translate ([horizontalX+extrusion,horizontalY+extrusion,corneruprightZ+extrusion]) 
rotate([0,0,90]) 
aluminiumextrusion(horizontalX,0);
//Bottom Rear X
translate ([horizontalX+extrusion,horizontalY+extrusion,0]) 
rotate([0,0,90]) 
aluminiumextrusion(horizontalX,0);
//Bottom Front X
translate ([extrusion,extrusion,0]) 
rotate([0,0,-90]) 
aluminiumextrusion(horizontalX,0);
}

////////////////////////
// BOM: Corner Cubes
////////////////////////

module cornercubes()
{
//Bottom Front Left Corner Cube
color("Black")  
rotate([90,00,270]) 
translate ([-extrusion,0,-extrusion]) 
cornercube();
//Bottom Back Left Corner Cube
color("Black") 
translate ([extrusion,horizontalY+extrusion*2,extrusion]) 
rotate([180,90,0]) 
cornercube();
//Bottom Front Right Corner Cube
color("Black")  
translate ([horizontalX+extrusion,extrusion,0]) 
rotate([90,0,0]) 
cornercube();
//Bottom Back Right Corner Cube
color("Black") 
translate ([horizontalX+extrusion,horizontalY+extrusion*2,extrusion]) 
rotate([180,0,0]) 
cornercube();

//Top Front Left Corner Cube
color("Black") 
translate ([extrusion,0,corneruprightZ+extrusion]) 
rotate([270,270,90]) 
cornercube();
//Top Back Left Corner Cube
color("Black") 
translate ([0,horizontalY+extrusion,corneruprightZ+extrusion]) 
rotate([0,270,270]) 
cornercube();
//Top Front Right Corner Cube
color("Black")  
translate ([horizontalX+extrusion,0,corneruprightZ+extrusion]) 
rotate([0,0,0]) 
cornercube();
//Top Back Right Corner Cube
color("Black") 
translate ([horizontalX+extrusion,horizontalY+extrusion,corneruprightZ+extrusion*2]) 
rotate([270,0,0]) 
cornercube();
// ** END CORNER CUBES

module cornercube() {
if ($preview)   {
    cube(cornercube);
    }  
    else {
    import("Corner_Cube_XL.stl");
    }
}

}

module leadscrews() {
    //Front left leadscrew
translate ([35+extrusionincrease,87.75,25])  
cylinder(  leadscrewheight, leadscrewwidth/2,leadscrewwidth/2);
//back left leadscrew
translate ([35+extrusionincrease,87.75+255.04,25])  
cylinder(  leadscrewheight, leadscrewwidth/2,leadscrewwidth/2);
//right leadscrew
translate ([455+extrusionincrease,215.25,25])  
cylinder(  leadscrewheight, leadscrewwidth/2,leadscrewwidth/2);
}



module motorholes(x,y,z) {
translate ([x,y,z])
cylinder(  15, 25/2,25/2);
translate ([x-15.33,y-15.39,z-2]) cylinder(25, 1.75,1.75);
translate ([x-15.33,y+15.39,z-2]) cylinder(25, 1.75,1.75);
translate ([x+15.33,y-15.39,z-2]) cylinder(25, 1.75,1.75);
translate ([x+15.33,y+15.39,z-2]) cylinder(25, 1.75,1.75);
}


module screwholes(x,y) {
//screwholeradius=1.75;
screwholeradius=(screwM+0.5)/2;
z=25;
screwholesX=5;
screwholesY=5;
holefromedge=50;


gapX=(x-100)/(screwholesX-1);

gapY=(y-100)/(screwholesY-1);

//cube([x,y,z]);

 for (a =[0:(screwholesX-1)])
 { translate ([holefromedge+(gapX*a),extrusion/2,-paneldepth]) cylinder(paneldepth*2, screwholeradius,screwholeradius); }
   for (a =[0:(screwholesY-1)])
 { translate ([extrusion/2,holefromedge+(gapY*a),-paneldepth]) cylinder(paneldepth*2, screwholeradius,screwholeradius); }
  for (a =[0:(screwholesX-1)])
 { translate ([holefromedge+(gapX*a),y-extrusion/2,-paneldepth]) cylinder(paneldepth*2, screwholeradius,screwholeradius); }
    for (a =[0:(screwholesY-1)])
 { translate ([x-extrusion/2,holefromedge+(gapY*a),-paneldepth]) cylinder(paneldepth*2, screwholeradius,screwholeradius); }
}



module corexy_belt() {
    p1 = [250,  -250];
    p2 = [-200, -250];
    p3 = [-200, 250];
    p4 = [250,  250];

    p5 = [250  - pulley_pr(GT2x20ob_pulley) - pulley_pr(GT2x16_plain_idler),  -pulley_pr(GT2x16_plain_idler)];
    p6 = [-200 + pulley_pr(GT2x20ob_pulley) + pulley_pr(GT2x16_plain_idler),  -pulley_pr(GT2x16_plain_idler)];

    translate(p1) pulley_assembly(GT2x20ob_pulley);
    translate(p2) pulley_assembly(GT2x20ob_pulley);
    translate(p3) pulley_assembly(GT2x20_toothed_idler);
    translate(p4) pulley_assembly(GT2x20_toothed_idler);

    translate(p5) {
        pulley = GT2x16_plain_idler;
        screw = find_screw(hs_cs_cap, pulley_bore(pulley));
        insert = screw_insert(screw);

        pulley_assembly(pulley);
        translate_z(pulley_height(pulley) + pulley_offset(pulley) + screw_head_depth(screw, pulley_bore(pulley)))
            screw(screw, 20);

        translate_z(pulley_offset(pulley) - insert_length(insert))
            vflip()
                insert(insert);

    }
    translate(p6) pulley_assembly(GT2x16_plain_idler);

    path = [ [p1.x, p1.y, pulley_pr(GT2x20ob_pulley)],
             [p5.x, p5.y, -pulley_pr(GT2x16_plain_idler)],
             [p6.x, p6.y, -pulley_pr(GT2x16_plain_idler)],
             [p2.x, p2.y, pulley_pr(GT2x20ob_pulley)],
             [p3.x, p3.y, pulley_pr(GT2x20ob_pulley)],
             [p4.x, p4.y, pulley_pr(GT2x20ob_pulley)]
           ];
    belt = GT2x6;
    belt(belt, path, 80, [0,  belt_pitch_height(belt) - belt_thickness(belt) / 2]);

   * translate([-25, 0])
        layout([for(b = belts) belt_width(b)], 10)
            rotate([0, 90, 0])
                belt(belts[$i], [[0, 0, 20], [0, 1, 20]]);
}




module rail(lengthrail)
{

            rail = MGN12;
           length = 400;
            screw = rail_screw(rail);
            nut = screw_nut(screw);
            washer = screw_washer(screw);

            rail_assembly(rail, length, rail_travel(rail, length) / 2);

            rail_screws(rail, length, sheet + nut_thickness(nut, true) + washer_thickness(washer));

            rail_hole_positions(rail, length, 0)
                translate_z(-sheet)
                    vflip()
                        nut_and_washer(nut, true);
         
     }
     

     