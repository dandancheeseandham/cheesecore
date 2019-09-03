include <config.scad>
include <nopscadlib/core.scad>
include <lib/mirror.scad>
use <screwholes.scad>

bed_ear_x = 12.5 ;
bed_ear_y = 23.4 ;
bed_thickness = 0.25*inch; // depth of bed tool plate

module bed(bedplateX, bedplateY , bedcornerrounding)
{
	color(alum_part_color()) 
	{
		difference() 
		{
			union() 
			{
				// Main body of bed
				translate([0, 0, bed_thickness/2])
				rounded_rectangle([bedplateX,bedplateY,bed_thickness], bedcornerrounding);
				// Ears
				translate([bedplateX/2, 0, 0]) bed_ear();
				ear_y_offset=gap_between_motors / 2 ;
				mirror_y()
				translate([-bedplateX/2,ear_y_offset,0]) rotate([0,0,180]) bed_ear();
      }
      thermistor_channel();

// Grounding connection hole
//  a proper grounding connection is consists of a toothed washer, washer, ring terminal, washer, a "schnorr disk" (?) and the bolt going through all of it      
       translate ([190,-35,bed_thickness/2]) rotate ([0,90,0]) singlescrewhole(2,0);
      
// Mounting hole for wire restraint on the side where cables go.
     translate ([190,-50,bed_thickness/2]) rotate ([0,90,0]) singlescrewhole(2,0);
      }
  }
}
module thermistor_channel() {
  // FIXME: x/y position of origin of this channel is approximate
  // We want it to land in center of printable area.
  translate([-10,-20,bed_thickness-2.5+epsilon]) {
    linear_extrude(2.5+epsilon) {
      hull() {
        circle(d=3);
        translate([5000,0]) circle(d=3);
      }
    }
  }
}

module bed_ear() {
  render() { // This render fixes an artifact around where the counterbore is taken out of the ear.
    difference() {
      linear_extrude(bed_thickness){
        ear_profile();
      }

      // Counterbore around slot
      translate([0,0,3.35]) {
        linear_extrude(bed_thickness) {
          hull() {
            translate([5,0]) circle(r=5);
            translate([bed_ear_x*2, 0]) circle(r=5);
          }
        }
      }
    }
  }
}

module ear_profile() {
  ear_radius = 7.5;
  difference() {
    union() {
      // Main tab of the ear
      hull() {
        translate([-epsilon, -bed_ear_y/2])  square([epsilon, bed_ear_y]);
        mirror_y()
        translate([bed_ear_x-ear_radius, bed_ear_y/2-ear_radius]) circle(r=ear_radius);
      }

      // Fillet from ear to outside counter of bed
      mirror_y() {
        translate([5, bed_ear_y/2+5]){
          difference() {
            translate([-5-epsilon, -5-epsilon]) square([5+epsilon, 5+epsilon]);
            circle(r=5);
          }
        }
      }
    }
    //
    // through slot
    hull() {
      translate([5, 0]) circle(d=3.4);
      translate([bed_ear_x*2, 0]) circle(d=3.4);
    }
  }
}

//ear_profile();
//projection () bed();
//projection(cut = true)  translate([0, 0, -bed_thickness]) bed();
//projection(cut = true)  bed();
//bed ();
//bed_ear();
bed(325,342,7.5); // standard bed