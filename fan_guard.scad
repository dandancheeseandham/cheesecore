// vim: set nospell:
use <nopscadlib/vitamins/fan_guard.scad>
include <nopscadlib/core.scad>
use <nopscadlib/utils/layout.scad>
include <nopscadlib/vitamins/fans.scad>

module fan_guards()
    layout([for(f = fans) fan_width(f)], 10)
        color(pp1_colour) fan_guard(fans[$i], spokes = fan_width(fans[$i]) > 60 ? 8 : 4);

fan_guards();