// vim: set nospell:
use <export_config.scad>
use <../bed.scad>

export_artifacts() {
  projection() bed([0,0,0]);
}
