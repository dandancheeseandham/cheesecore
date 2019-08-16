// vim: set nospell:
include <config.scad>

module leadscrews() {
//Front left leadscrew
translate ([leadscrewX1+extrusionincrease,leadscrewY1+extrusionincrease,couplerheight])
cylinder(  leadscrewheight, leadscrewwidth/2,leadscrewwidth/2);
//back left leadscrew
translate ([leadscrewX1+extrusionincrease,leadscrewY2+extrusionincrease,couplerheight])
cylinder(  leadscrewheight, leadscrewwidth/2,leadscrewwidth/2);
//right leadscrew
translate ([leadscrewX2+extrusionincrease,leadscrewY3+extrusionincrease,couplerheight])
cylinder(  leadscrewheight, leadscrewwidth/2,leadscrewwidth/2);
}

//Z Tower Extrusions
module Ztowerextrusions()
{
//Front left tower
translate ([extrusion,extrusion*2+towerY1,0])
rotate([90,0,0])
aluminiumextrusion(ztowerextrusions,0);

//back left tower
translate ([extrusion,extrusion+towerY2,0])
rotate([90,0,0])
aluminiumextrusion(ztowerextrusions,0);

//right tower
translate ([horizontalX,towerY3+extrusion+extrusionincrease,0])
rotate([90,0,0])
aluminiumextrusion(ztowerextrusions,0);
}

module motorholes(x,y,z) {
translate ([x,y,z])
cylinder(  15, 25/2,25/2);
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




module rail(lengthrail)
{
            rail = MGN12;
            length = 400;
            screw = rail_screw(rail);
            nut = screw_nut(screw);
            washer = screw_washer(screw);

            rail_assembly(rail, length, rail_travel(rail, length) / 2);

            sheet=3;  //removing this breaks nopheads stuff. Find out why.
            rail_screws(rail, length, sheet + nut_thickness(nut, true) + washer_thickness(washer));

            rail_hole_positions(rail, length, 0)
                translate_z(-sheet)
                    vflip()
                        nut_and_washer(nut, true);

     }
