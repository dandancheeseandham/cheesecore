// vim: set nospell:
include <config.scad>
use <lib/layout.scad>
use <lib/holes.scad>
use <screwholes.scad>
use <demo.scad>

bed_ear_x = 12.5;
bed_ear_y = 23.4;
bed_radius = 7.5;

// The origin of the bed is on the back of the bed (the surface that touches the yokes) at the centroid between the mounting ears
module bed(bed_frame_offset)
{
  // Printable area will vary with the printhead setup and isn't an exact dimension at design time.
translate (bed_frame_offset)
  color(alum_part_color()) {
    difference() {
      union() {

        // Main body of bed
        translate([0, 0, bed_thickness()/2 ])
          rounded_rectangle([bed_plate_size().x, bed_plate_size().y, bed_thickness()], bed_radius);
        // Ears
        translate([bed_plate_size().x / 2, 0, 0]) bed_ear();
        mirror_y()
          translate([-bed_plate_size().x / 2, bed_ear_spacing() / 2, 0])
            rotate([0,0,180])
              bed_ear();
      }
      thermistor_channel();

      //side_mounted_holes();
       strain_relief_holes();
       *earthing_hole();
    }
  }
}


module strain_relief_holes(){

// Mounting holes for wire restraint on the side where cables go.
translate ([bed_plate_size().x / 2 - 5, -35, bed_thickness()+1]) hole(d=3.2, h=20);
translate ([bed_plate_size().x / 2 - 5, -55, bed_thickness()+1]) hole(d=3.2, h=20);
}


module earthing_hole(){
// Grounding connection hole
//  a proper grounding connection is consists of a toothed washer, washer, ring terminal, washer, a "schnorr disk" (?) and the bolt going through all of it
translate ([bed_plate_size().x / 2 - 5, 15, bed_thickness()+1]) hole(d=2, h=20);
}


module side_mounted_holes(){
// Grounding connection hole
//  a proper grounding connection is consists of a toothed washer, washer, ring terminal, washer, a "schnorr disk" (?) and the bolt going through all of it
translate ([bed_plate_size().x / 2, -35, bed_thickness()/2]) rotate ([0,90,0]) hole(d=2, h=5);

// Mounting hole for wire restraint on the side where cables go.
translate ([bed_plate_size().x / 2, -50, bed_thickness()/2]) rotate ([0,90,0]) hole(d=2, h=5);
}



module thermistor_channel() {
  // FIXME: x/y position of origin of this channel is approximate
  // We want it to land in center of printable area.
  translate([-10,-20,bed_thickness()-2.5+epsilon]) {
    linear_extrude(2.5+epsilon) {
      hull() {
        circle(d=3);
        #translate([5000,0]) circle(d=3);
      }
    }
  }
}

module bed_ear() {
  render() { // This render fixes an artifact around where the counterbore is taken out of the ear.
    difference() {
      linear_extrude(bed_thickness()){
        ear_profile();
      }

      // Counterbore around slot
      translate([0,0,3.35]) {
        linear_extrude(bed_thickness()) {
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
  difference() {
    union() {
      // Main tab of the ear
      hull() {
        translate([-epsilon, -bed_ear_y/2])  square([epsilon, bed_ear_y]);
        mirror_y()
          translate([bed_ear_x - bed_radius, bed_ear_y / 2 - bed_radius]) circle(r=bed_radius);
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

    // through slot
    hull() {
      translate([5, 0]) circle(d=3.4);
      translate([bed_ear_x*2, 0]) circle(d=3.4);
    }
  }
}

demo() {
*ear_profile();
//projection () bed();
//projection(cut = true)  translate([0, 0, -bed_thickness()]) bed();
//projection(cut = true)  bed();
bed ([0,0,0]);
*bed_ear();
}
