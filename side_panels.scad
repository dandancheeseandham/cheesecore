// vim: set nospell:
include <config.scad>
include <nopscadlib/core.scad>
use <lib/holes.scad>
use <lib/mirror.scad>
use <door_hinge.scad>
use <screwholes.scad>

screwhole_distance_from_edge = 50 ; // FIXME : Where should this go?

module motorholes_panel() {
 cylinder(h=15, d=NEMA_boss_radius(NEMA17) * 2 + 1);
  mirror_xy() {
    translate([ NEMA_hole_pitch(NEMA17)/2, NEMA_hole_pitch(NEMA17)/2, -1 ])
      // FIXME: this diameter should be driven by stepper size. (Looked in modules, there is no definition for this.-dan)
      cylinder(d=3.3, h=paneldepth*2);
  }
}



module panel(x, y, thickness,screwholesX,screwholesY,panelcornerrounding)
{
  difference() {
    color(panel_color())
      translate ([0, 0, thickness/2])
        rounded_rectangle([x, y, thickness], panelcornerrounding);
    // Color the holes darker for contrast
    color(panel_color_holes()) translate([0, 0, epsilon]) screwholes_panel(x,y,screwholesX,screwholesY);
  }
}

// Holes to mount panels to extrusion
module screwholes_panel(x, y,screwholesX,screwholesY) {


// gap is calculated as "first hole is 50mm from the edge, and last hole is 50mm from the other edge. Evenly space the rest of the holes."
 gapX=(x-(screwhole_distance_from_edge*2))/(screwholesX-1);
 gapY=(y-(screwhole_distance_from_edge*2))/(screwholesY-1);
   
  mirror_y() {
    for (a =[0:(screwholesX-1)]) {
     translate ([-x/2 + panel_screw_offset()+(gapX*a),y/2 - extrusion_width()/2,-paneldepth/2])
        cylinder(h=paneldepth *2, r=clearance_hole_size(extrusion_screw_size()) / 2);
    }
  }

  mirror_x() {
    for (a =[0:(screwholesY-1)]) {
     translate ([x/2 - extrusion_width()/2,-y/2 + panel_screw_offset()+(gapY*a),-paneldepth/2])
        cylinder(h=paneldepth *2, r=clearance_hole_size(extrusion_screw_size()) / 2);
    }
  }
}




module bottom_panel() {
      difference() {
      panel((extrusion_length.x + extrusion_width()*2), (extrusion_length.y + extrusion_width()*2), paneldepth,5,5,5);

      color(panel_color_holes()) {
        translate([bed_offset.x, bed_offset.y, 0]) {
          // left side holes
          mirror_y() {
            translate([-extrusion_length.x/2 + leadscrew_x_offset, 255/2, -1])
              motorholes_panel();
          }
          // right side holes
          translate([extrusion_length.x/2 - leadscrew_x_offset, 0, -1])
            motorholes_panel();
        }

        // Deboss a name in the bottom panel
        color(panel_color_holes())
          translate([0, -extrusion_length.y/2 + 25, paneldepth-3+5*epsilon])
            linear_extrude(3)
              text(branding_name, halign="center", size=35);
      }
    }
}

module front_panel(Xwindowspacing,Zwindowspacingtop, Zwindowspacingbottom,screwhole_X, screwhole_Y, corner_radius) {
assert(Xwindowspacing >= extrusion_width(), str("Window cannot overlap extrusion in X: ", Xwindowspacing, " vs ", extrusion_width()));
assert(Zwindowspacingtop >= extrusion_width(), "Window cannot overlap extrusion in Z");
assert(Zwindowspacingbottom >= extrusion_width(), "Window cannot overlap extrusion in Z");

windowwidth = (extrusion_length.x+extrusion_width()*2) - (Xwindowspacing*2);
windowheight = (extrusion_length.z+extrusion_width()*2) - (Zwindowspacingtop+Zwindowspacingbottom);


gapY=((extrusion_length.z+extrusion_width()*2)-screwhole_distance_from_edge*2)/(screwhole_Y-1);
      difference() {
      panel((extrusion_length.x+extrusion_width()*2),(extrusion_length.z+extrusion_width()*2),paneldepth,screwhole_X,screwhole_Y,corner_radius);

      color(panel_color_holes())
        translate ([0, 0, paneldepth/2 + epsilon])
          // FIXME - this is still goofy with the 3* epsilon
          rounded_rectangle([windowwidth,windowheight,paneldepth+ 3*epsilon], corner_radius);
      }

// panel hinges
panelrounding = 5 ;
hole_distance_from_edge = 7.5 ;


mirror_x() 
mirror_y() {
{
	translate([-(extrusion_length.x/2+extrusion_width()),-(extrusion_length.y/2+extrusion_width())-panelrounding/2+gapY+hole_distance_from_edge+screwhole_distance_from_edge ,paneldepth]) front_panel_doors_hinge(screw_distance = gapY ,acrylic_door_thickness=5,screw_type=3); 
	}
}	
}


module side_panel() {
      panel((extrusion_length.y+extrusion_width()*2),(extrusion_length.z+extrusion_width()*2),paneldepth,5,5,5);
}

module back_panel(){
      panel((extrusion_length.x+extrusion_width()*2),(extrusion_length.z+extrusion_width()*2),paneldepth,5,5,5);
}


module all_side_panels()
{
translate([0, 0, -(extrusion_length.z+extrusion_width()*2)/2 -paneldepth]) bottom_panel();
translate([0, -(extrusion_length.y+extrusion_width()*2)/2, 0]) rotate([90,0,0]) front_panel(Xwindowspacing=35,Zwindowspacingtop=25, Zwindowspacingbottom=35,screwhole_X = 5, screwhole_Y = 5, corner_radius = 5); // ZL spacing
// translate([0, -(extrusion_length.y+extrusion_width()*2)/2, 0]) rotate([90,0,0]) front_panel(Xwindowspacing=35,Zwindowspacingtop=50, Zwindowspacingbottom=50,screwhole_X = 7, screwhole_Y = 5, corner_radius = 5); // ZLT spacing
translate([-(extrusion_length.x+extrusion_width()*2)/2-paneldepth,0,0]) rotate([90,0,90]) side_panel();
translate ([(extrusion_length.x+extrusion_width()*2)/2,0,0]) rotate([90,0,90]) side_panel();
translate ([0,(extrusion_length.y+extrusion_width()*2)/2+paneldepth,0]) rotate([90,0,0]) back_panel();
}

module all_side_panels_dxf()
{
projection(cut = true) translate([0, 0, 0]) bottom_panel();
projection(cut = true) translate([0, -(extrusion_length.y+extrusion_width()*2)-30, -6])  bottom_panel();
projection(cut = true) translate([0, -(extrusion_length.y+extrusion_width()*2)*2-30, 0])  front_panel(Xwindowspacing=35,Zwindowspacingtop=25, Zwindowspacingbottom=35,screwhole_X = 5, screwhole_Y = 5, corner_radius = 5); // ZL spacing
// projection(cut = true) translate([0, -(extrusion_length.y+extrusion_width()*2)*2-30, 0])  front_panel(Xwindowspacing=35,Zwindowspacingtop=50, Zwindowspacingbottom=50,screwhole_X = 5, screwhole_Y = 7, corner_radius = 5) // ZLT spacing
projection(cut = true) translate([-(extrusion_length.x+extrusion_width()*2)-30,0,0])  side_panel();
projection(cut = true) translate ([(extrusion_length.x+extrusion_width()*2)+30,0,0])  side_panel();
projection(cut = true) translate ([0,(extrusion_length.y+extrusion_width()*2)+30,0])  back_panel();   
}

//all_side_panels_dxf();
all_side_panels();
//front_panel();
