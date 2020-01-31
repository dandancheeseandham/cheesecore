// vim: set nospell:
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
include <nopscadlib/printed/ssr_shroud.scad>
use <demo.scad>

module electronics_box_contents() {
  // FIXME - should not need to translate here just by side_panel_thickness()
  // ask lostapathy "why?"
  translate([frame_size().x / 2 + side_panel_thickness(), 0, -movedown()])
    rotate([90,0,90]) {
      translate(DuetE_placement()) pcb_assembly(DuetE, 12, 3); // DuetE
      translate(Duex5_placement()) pcb_assembly(Duex5, 12 , 3); // Duex5
      //translate(DuetE_placement()) pcb_assembly(Duet3E, 12, 3); // Duet3 Ehternet
      //translate(Duex5_placement()) pcb_assembly(Duet3Exp, 12 , 3); // Duet3 Expansion
      translate(psu_placement()) rotate([0,0,90])   psu(S_250_48);
      translate(psu_placement()) rotate([0,0,90])   psu_screw_positions(S_250_48)
        translate_z(5)
                screw_and_washer(psu_screw(S_250_48), 8);
      translate(ssr_placement()) rotate([0,0,180]) ssr_assembly(ssrs[0], M3_cap_screw, 3);
      translate(ssr_placement()) rotate([0,0,180]) ssr_shroud_fastened_assembly(SSR25DA, 12,6,SSR25DA);
      translate(rpi_placement()) rotate([0,0,0]) pcb(RPI3);
/*
//below is development crap which can be removed later.
//playing with the idea of a RJ45 coupler for DuetEthernet versions
translate (rj45_coupler_cutout()) rotate([0,0,180])  rj45(cutout = false)  ;
translate (rj45_coupler_cutout()+[5,0,0]) rotate([0,0,0])  rj45(cutout = false)  ;
translate ([59/2,electronicsbox_size_x/2-20,-76])  rotate([90,0,180]) iec(IEC_fused_inlet);
rj45(cutout = false)
pcb_base(Duex5, 13, 3, wall = 2)
standoff(3, 12);
        *pcb_holes(DuetE) {
            cylinder(d=3.3,h=100);
          }
*/

    }
}

module standoff(screw, height, wall = 1.8, taper = 0) {
  ir = screw_clearance_radius(screw);
    or = corrected_radius(ir) + wall;
      linear_extrude(height = height)
        poly_ring(or, ir);
}

demo() {
    translate([-frame_size().x / 2 - side_panel_thickness(), 0, 0])
  electronics_box_contents();
}
