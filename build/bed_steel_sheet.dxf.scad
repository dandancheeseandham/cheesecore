// vim: set nospell:
use <export_config.scad>
use <../bed.scad>

export_artifacts() {
  projection() flex_plate([0,0,0]);;
}
