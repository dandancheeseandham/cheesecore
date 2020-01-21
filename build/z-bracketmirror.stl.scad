// vim: set nospell:
use <export_config.scad>
use <../z-bracket.scad>

export_artifacts() {
    rotate([90,0,0]) mirror([1,0,0]) z_bracket(extrusion_width());
    }
