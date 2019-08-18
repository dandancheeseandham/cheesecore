// vim: set nospell:
include <config.scad>
include <core.scad>
include <lib.scad>

// FIXME: if we're going to use nopscadlib, use his methods for this
module motorholes(x,y,z) {
   NEMAhole=25;
  translate ([x,y,z])
  cylinder(  15, NEMAhole/2,NEMAhole/2);
  translate ([x-15.33,y-15.39,z-2]) cylinder(25, 1.75,1.75);
  translate ([x-15.33,y+15.39,z-2]) cylinder(25, 1.75,1.75);
  translate ([x+15.33,y-15.39,z-2]) cylinder(25, 1.75,1.75);
  translate ([x+15.33,y+15.39,z-2]) cylinder(25, 1.75,1.75);
}

module corexy_belt() {
  p1 = [250,  -250];
  p2 = [-200, -250];
  p3 = [-200, 250];
  p4 = [250,  250];

  p5 = [250  - pulley_pr(GT2x20ob_pulley) - pulley_pr(GT2x16_plain_idler),  -pulley_pr(GT2x16_plain_idler)];
  p6 = [-200 + pulley_pr(GT2x20ob_pulley) + pulley_pr(GT2x16_plain_idler),  -pulley_pr(GT2x16_plain_idler)];

  translate(p1) pulley_assembly(GT2x20ob_pulley);
  translate(p2) pulley_assembly(GT2x20ob_pulley);
  translate(p3) pulley_assembly(GT2x20_toothed_idler);
  translate(p4) pulley_assembly(GT2x20_toothed_idler);

  translate(p5) {
      pulley = GT2x16_plain_idler;
      screw = find_screw(hs_cs_cap, pulley_bore(pulley));
      insert = screw_insert(screw);

      pulley_assembly(pulley);
      translate_z(pulley_height(pulley) + pulley_offset(pulley) + screw_head_depth(screw, pulley_bore(pulley)))
          screw(screw, 20);

      translate_z(pulley_offset(pulley) - insert_length(insert))
          vflip()
              insert(insert);

  }
  translate(p6) pulley_assembly(GT2x16_plain_idler);

  path = [ [p1.x, p1.y, pulley_pr(GT2x20ob_pulley)],
            [p5.x, p5.y, -pulley_pr(GT2x16_plain_idler)],
            [p6.x, p6.y, -pulley_pr(GT2x16_plain_idler)],
            [p2.x, p2.y, pulley_pr(GT2x20ob_pulley)],
            [p3.x, p3.y, pulley_pr(GT2x20ob_pulley)],
            [p4.x, p4.y, pulley_pr(GT2x20ob_pulley)]
          ];
  belt = GT2x6;
  belt(belt, path, 80, [0,  belt_pitch_height(belt) - belt_thickness(belt) / 2]);

  * translate([-25, 0])
      layout([for(b = belts) belt_width(b)], 10)
          rotate([0, 90, 0])
              belt(belts[$i], [[0, 0, 20], [0, 1, 20]]);
}

