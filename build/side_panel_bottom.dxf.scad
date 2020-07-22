// vim: set nospell:
use <export_config.scad>
use <../side_panels.scad>

export_artifacts() {
  projection() rotate ([180,0,0]) bottom_panel();

}
