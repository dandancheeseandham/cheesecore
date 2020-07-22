// vim: set nospell:
use <export_config.scad>
use <../electronics_box_corner.scad>

//version for heat inserts with thicker "ledge"
export_artifacts() {
    rotate([90,0,0])
  electronics_box_corner();
    }

// cornersize = 15, acrylicdepth = 6.6 ,height = 60, ledgewidth = 10 , ledgethickness = 7, holesize = 4.75
