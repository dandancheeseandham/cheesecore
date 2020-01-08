// vim: set nospell:
include <config.scad>
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
use <lib/layout.scad>
use <demo.scad>

module rail_wrapper(rail_type, length, include_screws=false, position=0)
{
  assert(length != undef, "Length must be defined");
  assert(abs(position) <= rail_travel(rail_type, length) / 2, "Carriage cannot go off end of rail");

  screw = rail_screw(rail_type);
  nut = screw_nut(screw);
  washer = screw_washer(screw);

  rail_assembly(rail_type, length, position);

  if(include_screws)
  {
    rail_screws(rail_type, length, sheet + nut_thickness(nut, true) + washer_thickness(washer));

    rail_hole_positions(rail_type, length, 0)
      translate_z(-sheet)
      vflip()
      nut_and_washer(nut, true);
  }

  //Debug - set to true for debug info
  if (false)
  {
    echo("Rail travel: ", rail_travel(rail_type, length));
    echo("position: ", position);
  }
}

module x_rails(position = 0) {

  rail_type = rail_profiles().x;
  rail_length = rail_lengths().x;
  translate([0, 0, frame_size().z / 2 - extrusion_width() / 2 ])
  {
    mirror_y()
    {
      translate ([0, frame_size().y / 2 - extrusion_width(), 0])
        rotate([90, 0, 0])
          rail_wrapper(rail_type, rail_length, position=-rail_travel(rail_type, rail_length) / 2 + position);
    }
  }
}

demo() {
  translate([0, 0, -frame_size().z / 2 + extrusion_width() / 2 ])
    x_rails(position=0);
}
