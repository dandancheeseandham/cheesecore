// vim: set nospell:
use <export_config.scad>
use <../side_panels.scad>

export_artifacts() {
  rotate([0,180,0]) projection() door();
}
