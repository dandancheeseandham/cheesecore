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
      strain_relief_holes();  // we can put strain relief on the bed instead of on the Z-yokes.
       *earthing_hole();  // earthing
      magnets();
    }
  }
}

// Mounting holes for wire restraint on the side where cables go.
module strain_relief_holes() {
  translate ([bed_plate_size().x / 2 - 5, -35, bed_thickness()+1]) hole(d=3.2, h=20);
  translate ([bed_plate_size().x / 2 - 5, -55, bed_thickness()+1]) hole(d=3.2, h=20);
}

// Top grounding connection hole
//  a proper grounding connection is consists of a toothed washer, washer, ring terminal,
// washer, a "schnorr disk" (?) and the bolt going through all of it
module earthing_hole() {
  translate ([bed_plate_size().x / 2 - 5, 15, bed_thickness()+1]) hole(d=2, h=20);
}

// Side grounding connection hole
//  a proper grounding connection is consists of a toothed washer, washer, ring terminal, washer, a "schnorr disk" (?) and the bolt going through all of it
module side_mounted_holes() {
  translate ([bed_plate_size().x / 2, -35, bed_thickness()/2])
    rotate ([0,90,0])
      hole(d=2, h=5);
  // Mounting hole for wire restraint on the side where cables go.
  translate ([bed_plate_size().x / 2, -50, bed_thickness()/2])
    rotate ([0,90,0])
      hole(d=2, h=5);
  }

module thermistor_channel() {
  // FIXME: x/y position of origin of this channel is approximate
  // We want it to land in center of printable area.
  translate([-10,-20,bed_thickness()-2.5+epsilon]) {
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

module magnets(){
sizeofmagnetx = 20;
sizeofmagnety = 20;
depthofmagnet = 4;
no_of_magnets_x = 3;
no_of_magnets_y = 3;
magnet_edge_gap_x = 35;
magnet_edge_gap_y = 35;
    fudgex = 10;
    fudgey = 10;
spacingx = (bed_plate_size().x-(magnet_edge_gap_x-sizeofmagnetx))/no_of_magnets_x+fudgex;
spacingy = (bed_plate_size().y-(magnet_edge_gap_y-sizeofmagnety))/no_of_magnets_y+fudgey;

for (j = [1:no_of_magnets_x]) {
for (i = [1:no_of_magnets_y]) {    
    translate([(-spacingx*no_of_magnets_x), (-spacingy*no_of_magnets_y),0])
    
    translate ([bed_plate_size().x/2,bed_plate_size().y/2,0])
    translate ([-magnet_edge_gap_x,-magnet_edge_gap_y,0])
    translate ([-sizeofmagnetx,-sizeofmagnety,0])
    translate([(j*spacingx), i*spacingy, -1/128]) 
    //cube([sizeofmagnetx,sizeofmagnety,depthofmagnet+1/128]);
    cylinder(d=sizeofmagnetx,h=depthofmagnet+1/128);
}
    
}

}


module flex_plate(bed_frame_offset) {
  ear_width = 50;
  steel_sheet_thickness = 0.7;
  translate (bed_frame_offset) {
    color([0.7, 0.7, 0.7]) {
      translate([0, 0, bed_thickness()]) {
        // FIXME: we should draw the whole flex plate in 2d and extrude it once, rather than mixing a bunch of 3d solids
        rounded_rectangle([bed_plate_size().x, bed_plate_size().y, flex_plate_thickness()], bed_radius);
        mirror_x() {
          translate([bed_plate_size().x/2 - ear_width/2,-bed_plate_size().y /2, 0]) {
            rounded_rectangle([ear_width, 30, flex_plate_thickness()], bed_radius);
            linear_extrude(steel_sheet_thickness) {
              difference() {
                translate([-ear_width/2-bed_radius,-bed_radius, 0]) square(bed_radius);
                translate([-ear_width/2-bed_radius,-bed_radius,0]) circle(r=bed_radius);
              }
            }
          }
        }
      }
    }
  }
}

demo() {
  //flex_plate([0,0,0]);
  bed ([0,0,0]);
}
