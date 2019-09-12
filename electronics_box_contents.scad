// vim: set nospell:
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
use <demo.scad>
use <electronics_placement.scad>

module electronics_box_contents() {
  extrusion=extrusion_width($extrusion_type);
    rotate([90,0,90]) {
      translate(DuetE_placement()) pcb_assembly(DuetE, 12, 3); // DuetE
      translate(Duex5_placement()) pcb_assembly(Duex5, 12 , 3); // Duex5
      translate(psu_placement()) rotate([0,0,90])   psu(S_250_48);
      translate(psu_placement()) rotate([0,0,90])   psu_screw_positions(S_250_48)
        translate_z(5)
                screw_and_washer(psu_screw(S_250_48), 8);
      translate(ssr_placement()) ssr_assembly(ssrs[1], M3_cap_screw, 3);
    translate (rj45_coupler_cutout()) rotate([0,0,180])  rj45(cutout = false)  ; 
    translate (rj45_coupler_cutout()+[5,0,0]) rotate([0,0,0])  rj45(cutout = false)  ; 
    //playing with the idea of a RJ45 coupler for DuetEthernet versions
  
  
 //below is development crap to be removed later.
 // * translate ([59/2,electronicsbox_size_x/2-20,-76])  rotate([90,0,180]) iec(IEC_fused_inlet);
 // * rj45(cutout = false)       
//translate([-84.82,50.5])  pcb(Duex5);
//pcb_base(Duex5, 13, 3, wall = 2)	
//standoff(3, 12);        
//        *pcb_holes(DuetE) {
//            cylinder(d=3.3,h=100);
//          }
    }
}

module standoff(screw, height, wall = 1.8, taper = 0) {
  ir = screw_clearance_radius(screw);
    or = corrected_radius(ir) + wall;

        linear_extrude(height = height)
            poly_ring(or, ir);
}

demo() {
electronics_box_contents();
}
