// vim: set nospell:
include <nopscadlib/core.scad>
use <nopscadlib/utils/layout.scad>
include <nopscadlib/printed/fan_guard.scad>
include <nopscadlib/vitamins/fans.scad>

fan_guard(fan120x25, name = false, thickness = 6, spokes = 4, finger_width = 7, grill = true);




