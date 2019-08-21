// vim: set nospell:
include <config.scad>
use <opencoreparts.scad>
include <core.scad>
use <lib/mirror.scad>

panelX=extrusion_length.x+extrusion*2;
panelY=extrusion_length.y+extrusion*2;
panelZ=extrusion_length.z+extrusion*2;

module motorholes() {
  // Should make stepper size parametric in config?
  NEMAhole=NEMA_boss_radius(NEMA17) * 2 + 1;
  cylinder(h=15, d=NEMAhole);
  mirror_xy() {
    translate([ NEMA_hole_pitch(NEMA17)/2, NEMA_hole_pitch(NEMA17)/2, -1 ])
      // FIXME: this diameter should be driven by stepper size
      cylinder(d=3.3, h=paneldepth*2);
  }
}

// Holes to mount panels to extrusion
module screwholes(x, y) {
  //screwholeradius=1.75;
  screwholeradius=(screwM+0.5)/2;
  screwholesX=5;
  screwholesY=5;

  gapX=(x-100)/(screwholesX-1);
  gapY=(y-100)/(screwholesY-1);

  // FIXME: something is off in how these generate in that we need to offset z=-2*epsilon
  mirror_y() {
    for (a =[0:(screwholesX-1)]) {
      translate ([-x/2 + panel_screw_offset+(gapX*a),y/2 - extrusion/2,-2*epsilon])
        cylinder(h=paneldepth + 3*epsilon, r=screwholeradius);
    }
  }

  mirror_x() {
    for (a =[0:(screwholesY-1)]) {
      translate ([x/2 - extrusion/2,-y/2 + panel_screw_offset+(gapY*a),-2*epsilon])
        cylinder(h=paneldepth + 3*epsilon, r=screwholeradius);
    }
  }
}

module panel(x, y, thickness)
{
  panelcornerrounding=5; // Corner rounding of panels
  screwholes=5;     // Number of screwholes // IS THIS REDUNDANT?

  difference() {
    color(panel_color())
      translate ([0, 0, thickness/2])
        rounded_rectangle([x, y, thickness], panelcornerrounding);
    // Color the holes darker for contrast
    color(panel_color_holes()) translate([0, 0, epsilon]) screwholes(x,y);
  }
}

// BOM Item Name: HDPE Side Panels
// BOM Quantity: 1
// BOM Link: http://railco.re/sidepanels
// Notes: DXFs available from here via

module bottom_panel() {
  translate([0, 0, -extrusion_length.z/2 - extrusion -paneldepth])
    difference() {
      panel(panelX, panelY, paneldepth);

      color(panel_color_holes()) {
        translate([bed_offset.x, bed_offset.y, 0]) {
          // left side holes
          mirror_y() {
            translate([-extrusion_length.x/2 + leadscrew_x_offset, 255/2, -1])
              motorholes();
          }
          // right side holes
          translate([extrusion_length.x/2 - leadscrew_x_offset, 0, -1])
            motorholes();
        }

        // Deboss a name in the bottom panel
        color(panel_color_holes())
          translate([0, -extrusion_length.y/2 + 25, paneldepth-3+5*epsilon])
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
  translate([0, -panelY/2, 0])
  rotate([90,0,0])
    difference() {
      panel(panelX,panelZ,paneldepth);

      // FIXME: why does this need bigger epsilon and epsilon * 3 cut depth to work right??
      epsilon=1;
      color(panel_color_holes())
        translate ([0, 0, paneldepth/2])
          rounded_rectangle([windowwidth,windowheight,paneldepth+epsilon*3], window_radius);
    }
}

module left_panel() {
  translate([-paneldepth-panelX/2,0,0])
    rotate([90,0,90])
      panel(panelY,panelZ,paneldepth);
}

module right_panel() {
  translate ([panelX/2,0,0])
    rotate([90,0,90])
      panel(panelY,panelZ,paneldepth);
}

module back_panel(){
  translate ([0,panelY/2+paneldepth,0])
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
//front_panel();
