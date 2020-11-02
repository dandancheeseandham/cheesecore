// vim: set nospell:
include <config.scad>
use <extrusion.scad>
use <corner_cube.scad>
use <lib/layout.scad>
use <demo.scad>
use <extrusion_spacers.scad>

/*
module x_extrusions() {
//back-top of main box
  translate([0, enclosure_size().y / 2 - extrusion_width() / 2, enclosure_size().z / 2 - extrusion_width() / 2])
    rotate([0,90,0])
      extrusion(enclosure_size().x - 2 * extrusion_width());
echo ("Top enclosure");
echo ("=============");
echo ("Top enclosure parts X: Qty 6 of ", enclosure_size().x - 2 * extrusion_width());
echo ("Top enclosure parts X: Qty 2 of",enclosure_size().x - 4 * extrusion_width() );
//echo ("Top enclosure parts: ", );

  translate([0, -enclosure_size().y / 2 + extrusion_width() / 2, enclosure_size().z / 2 - extrusion_width() / 2])
    rotate([0,90,0])
      extrusion(enclosure_size().x - 4 * extrusion_width());


  //front and back panel top
  *mirror_y() {
    translate([0, enclosure_size().y / 2 - extrusion_width() / 2, enclosure_size().z / 2 - extrusion_width() / 2])
      rotate([0,90,0])
        extrusion(enclosure_size().x - 2 * extrusion_width());
  }

  //rear bottom extrusion
  translate([0, enclosure_size().y / 2 - extrusion_width() / 2, -enclosure_size().z / 2 + extrusion_width() / 2])
    rotate([0,90,0])
      extrusion(enclosure_size().x - 2 * extrusion_width());

  //front bottom extrusion
    translate([0, -enclosure_size().y / 2 + extrusion_width() / 2, -enclosure_size().z / 2 + extrusion_width() *0.5])
      rotate([0,90,0])
        extrusion(enclosure_size().x - 4 * extrusion_width());


  mirror_y() {
    //top-front panel front extrusion and top-back panel back extrusion
      translate([0, (enclosure_size().y-extrusion_width())/2, (enclosure_size().z+extrusion_width())/2 ])
        rotate([0,90,0])
          extrusion(enclosure_size().x- 2*extrusion_width());
    //top-front panel back extrusion and top-back panel front extrusion(meeting in the middle)
      translate([0, -extrusion_width()/2, (enclosure_size().z+extrusion_width())/2])
        rotate([0,90,0])
          extrusion(enclosure_size().x- 2*extrusion_width());
    }
  }

module y_extrusions() {
  // left and right panel top&bottom extrusion
  echo ("Top enclosure parts Y: Qty 4 of",enclosure_size().y - 2 * extrusion_width() );
  echo ("Top enclosure parts Y: Qty 4 of",enclosure_size().y/2 - extrusion_width()*2 );
  mirror_xz(){
    translate([enclosure_size().x / 2 - extrusion_width() / 2, 0, enclosure_size().z / 2 - extrusion_width() / 2])
      rotate([90,0,0])
        extrusion(enclosure_size().y - 2 * extrusion_width());
        }


  //top panels left and right extrusions
    mirror_xy(){
      translate([(enclosure_size().x-extrusion_width()) / 2, enclosure_size().y/4, (enclosure_size().z+ extrusion_width())/2 ])
        rotate([90,0,0])
          extrusion(enclosure_size().y/2 - extrusion_width()*2);
    }
  }

module z_extrusions() {
echo ("Top enclosure parts Z: Qty 4 of",enclosure_size().z - 2*extrusion_width() );
echo ("Top enclosure parts Z: Qty 2 of",enclosure_size().z - 3*extrusion_width() );
    //four corner Z uprights
    mirror_xy() {
      translate([enclosure_size().x / 2 - extrusion_width() / 2, enclosure_size().y / 2 - extrusion_width() / 2, 0])
        extrusion(enclosure_size().z - 2*extrusion_width());

    }

    mirror_x() {
      translate([enclosure_size().x / 2 - extrusion_width() * 1.5 , -enclosure_size().y / 2 + extrusion_width() * 0.5, 0 ])
        extrusion(enclosure_size().z - 2*extrusion_width());

    }
  }

module corner_cubes() {
echo ("Top enclosure parts corner cubes",8+4+4+4 );
//main enclosure corners (8)
  mirror_xyz() {
    translate([(enclosure_size().x- extrusion_width())/2, (enclosure_size().y-extrusion_width())/2, (enclosure_size().z-extrusion_width())/2])
      rotate([0,0,90])
        corner_cube();
}
// top lid corner cubes (corners) (4)
  mirror_xy() {
    translate([(enclosure_size().x-extrusion_width())/2, (enclosure_size().y-extrusion_width()) /2, (enclosure_size().z+extrusion_width()) / 2])
      rotate([0,0,90])
        corner_cube();
        }
//top lid corner cubes (middle) (4)
  mirror_xy() {
    translate([(enclosure_size().x-extrusion_width())/ 2, -extrusion_width()/2, (enclosure_size().z+extrusion_width())/2])
      rotate([0,0,90])
        corner_cube();
  }
  //front panel (4)
    translate ([0,0,0]) mirror_xz()
      translate([(enclosure_size().x-extrusion_width()*3)/2, (-enclosure_size().y+extrusion_width())/2, (enclosure_size().z-extrusion_width()) / 2])
        rotate([0,0,90])
          corner_cube();


}

module enclosure_frame() {
  x_extrusions();
  y_extrusions();
  z_extrusions();
  corner_cubes();

  // This cube is just for debugging - it makes sure the space between brace and outside extrusion is correct
  //translate([-enclosure_size().x / 2 + extrusion_width(), 0, -enclosure_size().z / 2+ 40]) cube([40, 100, 100]);
  assert(leadscrew_x_offset() == 20, "leadscrew_x_offset() sets placement of stepper and bottom braces.  Must be 20 unless we do something besides NEMA17 z motors");
}

demo(){
  enclosure_frame();
  }
*/
function filament_enclosure_size() = [100,30,0];

module z_extrusions() {
//color("Black")  //Colours are for later documentation identification
  mirror_xy() {
    translate([filament_enclosure_size().x / 2 - extrusion_width() / 2, frame_size().y / 2 - extrusion_width() / 2, 0])
      extrusion(frame_size().z - 2 * extrusion_width());
  }
}

module x_extrusions() {
//color("Purple")
  mirror_yz() {
    translate([0, frame_size().y / 2 - extrusion_width() / 2, frame_size().z / 2 - extrusion_width() / 2])
      rotate([0,90,0])
        extrusion(filament_enclosure_size().x - 2 * extrusion_width());
  }
}

module y_extrusions() {
  //color("Blue")
  mirror_xz() {
    translate([filament_enclosure_size().x / 2 - extrusion_width() / 2, 0, frame_size().z / 2 - extrusion_width() / 2])
      rotate([90,0,0])
        extrusion(frame_size().y - 2 * extrusion_width());
  }
}

module corner_cubes() {
  mirror_xyz() {
    translate([filament_enclosure_size().x / 2 - extrusion_width() / 2, frame_size().y / 2 - extrusion_width() / 2, frame_size().z / 2 - extrusion_width() / 2])
      rotate([0,0,90])
        corner_cube();
  }
}

module filament_enclosure() {
translate ([-frame_size().x/2-filament_enclosure_size().x/2,0,0]){
  x_extrusions();
  y_extrusions();
  z_extrusions();
  corner_cubes();
  }
    }



demo() {
  filament_enclosure();
}
