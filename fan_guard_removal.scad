// vim: set nospell:
include <nopscadlib/core.scad>
include <constants.scad>
use <nopscadlib/utils/layout.scad>
include <nopscadlib/printed/fan_guard.scad>
include <nopscadlib/vitamins/fans.scad>


// fans = [fan25x10, fan30x10, fan40x11, fan50x15, fan60x15, fan60x25, fan70x15, fan80x25, fan80x38, fan120x25];

fan_guard_removal(120,6);

module fan_guard_removal(size = 40, thickness = 6){
difference(){
  rounded_rectangle([size-1,size-1,thickness],7);
if (size == 40) {
  translate ([0,0,-thickness/2-epsilon])
    fan_guard(fan40x11, name = false, thickness = thickness+epsilon*2, spokes = 4, finger_width = 4, grill = true);
}

if (size == 80) {
  translate ([0,0,-thickness/2-1]) fan_guard(fan80x25, name = false, thickness = thickness+2, spokes = 6, finger_width = 7, grill = true);
}

if (size == 120) {
  translate ([0,0,-thickness/2-epsilon]) fan_guard(fan120x25, name = false, thickness = thickness+epsilon*2, spokes = 8, finger_width = 10, grill = true);
}

}

}
