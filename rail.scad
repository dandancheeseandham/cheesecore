include <config.scad>
include <core.scad>
include <lib.scad>

module rail_wrapper(length, include_screws=false, position=0)
{
  assert(length != undef, "Length must be defined");
  rail = MGN12;
  screw = rail_screw(rail);
  nut = screw_nut(screw);
  washer = screw_washer(screw);

  //position = rail_travel(rail, length) /2;
  rail_assembly(rail, length, position);

  sheet=3;

  if(include_screws) {
    rail_screws(rail, length, sheet + nut_thickness(nut, true) + washer_thickness(washer));

    rail_hole_positions(rail, length, 0)
        translate_z(-sheet)
            vflip()
                nut_and_washer(nut, true);

  }

  echo("Rail travel: ", rail_travel(rail, length));
  echo("position: ", position);
}
