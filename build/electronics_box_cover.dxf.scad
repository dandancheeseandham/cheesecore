// vim: set nospell:
use <export_config.scad>
use <../electronics_box_panels.scad>

export_artifacts() {
  projection() rotate ([270,0,0]) electronics_cover_panel();
  }
