// vim: set nospell:
include <config.scad>
include <opencoreparts.scad>
include <core.scad>

// FIXME: if we're going to use nopscadlib, use his methods for this
module motorholes(x,y,z) {
   NEMAhole=25;
  translate ([x,y,z])
  cylinder(  15, NEMAhole/2,NEMAhole/2);
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

  gapX=(x-100)/(screwholesX-1);
  gapY=(y-100)/(screwholesY-1);

  //cube([x,y,z]);

 for (a =[0:(screwholesX-1)])
 { translate ([panel_screw_offset+(gapX*a),extrusion/2,-paneldepth]) cylinder(paneldepth*2, screwholeradius,screwholeradius); }
  for (a =[0:(screwholesY-1)])
 { translate ([extrusion/2,panel_screw_offset+(gapY*a),-paneldepth]) cylinder(paneldepth*2, screwholeradius,screwholeradius); }
  for (a =[0:(screwholesX-1)])
 { translate ([panel_screw_offset+(gapX*a),y-extrusion/2,-paneldepth]) cylinder(paneldepth*2, screwholeradius,screwholeradius); }
    for (a =[0:(screwholesY-1)])
 { translate ([x-extrusion/2,panel_screw_offset+(gapY*a),-paneldepth]) cylinder(paneldepth*2, screwholeradius,screwholeradius); }
}

module panel(x,y,d)
{
  panelcornerrounding=5; // Corner rounding of panels
  screwholes=5;     // Number of screwholes // IS THIS REDUNDANT?

  difference() {
    color(panel_color())
      translate ([x/2,y/2,d/2])
        rounded_rectangle([x,y,d], panelcornerrounding);
    // Color the holes darker for contrast
    color(panel_color_holes()) translate([0, 0, epsilon]) screwholes(x,y);
  }
}

// BOM Item Name: HDPE Side Panels
// BOM Quantity: 1
// BOM Link: http://railco.re/sidepanels
// Notes: DXFs available from here via

module bottom_panel() {
  translate([0,0,-paneldepth])
    difference() {
      panel(panelX,panelY,paneldepth);

      color(panel_color_holes()) {
        //front left motor hole
        motorholes(leadscrewX1+extrusionincrease,leadscrewY1+extrusionincrease,-paneldepth);
        //rear left motor hole
        motorholes(leadscrewX1+extrusionincrease,leadscrewY2+extrusionincrease,-paneldepth);
        //right motor hole
        motorholes(leadscrewX2+extrusionincrease,leadscrewY3,-paneldepth) ;

        color("black")
        translate([panelX/2, 80, paneldepth-3+5*epsilon])
          linear_extrude(3)
            text(branding_name, halign="center", size=35);
      }
    }
}

module front_panel() {
  // Define Panel Window Area (ZL match)
  Xwindowspacing=35;
  Zwindowspacingtop=25;  // 25 for ZL , 50 for ZLT
  Zwindowspacingbottom=35;  // 35 for ZL , 50 for ZLT

  windowwidth = panelX - (Xwindowspacing*2);
  windowheight = panelZ - (Zwindowspacingtop+Zwindowspacingbottom);
  window_radius = 5;

  rotate([90,0,0])
    difference() {
      panel(panelX,panelZ,paneldepth);

      // FIXME: why does this need bigger epsilon and epsilon * 3 cut depth to work right??
      epsilon=1;
      color(panel_color_holes())
        translate ([windowwidth/2+Xwindowspacing,windowheight/2+Zwindowspacingbottom,paneldepth/2])
          rounded_rectangle([windowwidth,windowheight,paneldepth+epsilon*3], window_radius);
    }
}

module left_panel() {
  translate([-paneldepth,0,0])
    rotate([90,0,90])
      panel(panelY,panelZ,paneldepth);
}

module right_panel() {
  translate ([panelX,0,0])
    rotate([90,0,90])
      panel(panelY,panelZ,paneldepth);
}

module back_panel(){
  translate ([0,panelY+paneldepth,0])
    rotate([90,0,0])
      panel(panelX,panelZ,paneldepth);
}

module all_side_panels() {
  bottom_panel();
  front_panel();
  left_panel();
  right_panel();
  back_panel();
}

all_side_panels();
