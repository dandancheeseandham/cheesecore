// vim: set nospell:
use <export_config.scad>
use <lib/layout.scad>
use <../z-bracket.scad>

export_artifacts() {
    rotate([90,0,0]) mirror([0,0,0]) z_bracket(extrusion_width());
    }
