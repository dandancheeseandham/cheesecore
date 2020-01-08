// vim: set nospell:
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
use <lib/layout.scad>
include <config.scad>
use <demo.scad>
use <rail.scad>
use <x-carriage.scad>

module y_carriage(position) {
  //echo(rail_lengths().x);
  // messy bit!
  // FIXME: the +47 is a fudge to make things align
  Yrail_vector = [-rail_lengths().x/2 + position.x + 47, 0, frame_size().z / 2 - extrusion_width() / 2]; // Since a lot of things are tied to the Y-rail, I thought it might be worth investigating a base vector to simplify the code.

  // HOTEND
  translate(Yrail_vector + [-35, position.y-150, 5]) // FIXME: arbitary move to look decentish
    rotate([0,0,180]) hot_end(E3Dv6, naked=true);

  // Y-RAIL
  // FIXME: x position here is an approximation to look decent
  translate (Yrail_vector + [3 , 0, 0])
    rotate([270, 0, 90])
      rail_wrapper(rail_profiles().y, rail_lengths().y, position = position.y-150);

  // X-CARRIAGE
  // FIXME: the +17.5 in x is an approximation
  xcarriagevector = [-rail_lengths().x/2 + position.x + 17.5, frame_size().y / 2 - extrusion_width() - carriage_height(rail_profiles().x), frame_size().z / 2 - extrusion_width() / 2];
  mirror_y()
    translate (xcarriagevector)
      x_carriage();
}

demo(){
  y_carriage([0, 150, 0]);
}
