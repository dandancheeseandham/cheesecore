include <config.scad>

railcore_300ZL_compatible_with_sides()
  printer(position = [80, 90, 130]);
  // ORIGINAL RAILCORE II 300ZL
module rc300zl_compatible_with_sides(position = [0, 0, 0]) {
    $NEMA_XY            = NEMA17;
    $NEMA_Z             = NEMA17;
    $extrusion_type     = extrusion15;

    $frame_size         = frame_original_rc300zl;
    $panels             = panels_withsides;
    $enclosure_size     = enclosure_rc_standard;
    $halo_size          = halo_rc;
    $front_window_size  = front_window_original_300zl;
    $elecbox            = elecbox_original_rc300zl_with_sides;
    $branding_name      = "300ZL/Sides";

    $rail_specs         = rails_original_rc300zl;
    $leadscrew_specs    = leadscrew_original_rc300zl;
    $bed                = bed_standard_rc300;
    $feet_depth         = 50 ;
    children();
  }






module rc300zltwithcheese(position = [0, 0, 0]) {
  $NEMA_XY            = NEMA23;
  $NEMA_Z             = NEMA17;
  $extrusion_type     = extrusion15;

  $frame_size         = [460, 425+20, 415+20] + [15*2,15*2,15*2];
  $panels             = panels_cheese;
  $enclosure_size     = eenclosure_rc_standard;
  $halo_size          = halo_rc_cheese;
  $front_window_size  = front_window_original_300zl;
  $elecbox            = elec_rc300zltwithcheese;
  $branding_name      = "300ZL with Cheese";

  $rail_specs         = rails_misumi_420XY_470Z;
  $leadscrew_specs    = ["LEADSCREW_SPECS", 440, 8,     8,                 16,       22,          3.4];
  $bed                = bed_standard_rc300;
  $feet_depth         = 50 ;
  children();
}

// CUSTOMCORE FOR DEBUGGING/QUICK RENDERING
module customcore(position = [0, 0, 0]) {
  $NEMA_XY            = NEMA17;
  $NEMA_Z             = NEMA17;
  $extrusion_type     = extrusion15;

  $frame_size         = frame_rc300_custom;
  $panels             = panel_imperial;
  $enclosure_size     = enclosure_custom;
  $halo_size          = halo_rc;
  $front_window_size  = front_window_original_300zl;
  $elecbox            = elec_custom;
  $branding_name      = "CustomCore";

  $rail_specs         = rails_custom;
  $leadscrew_specs    = leadscrew_rc_custom;
  $bed                = bed_standard_rc300;
  $feet_depth         = 50 ;
  children();
}

// 2020 based on ORIGINAL RAILCORE II ZL
module 2020core(position = [0, 0, 0]) {
  $NEMA_XY            = NEMA23;
  $NEMA_Z             = NEMA17;
  $extrusion_type     = extrusion20;

  $frame_size         = frame_original_rc300zl;
  $panels             = panel_imperial;
  $enclosure_size     = enclosure_rc_standard+ [20+40,25,20];
  $halo_size          = halo_rc;
  $front_window_size  = front_window_original_300zl;
  $elecbox            = ["ELEC.BOX", 340,   270,   59 ,   6,    25,    true,   [-84,146.5,0], [-85,70,0],      [-85,-40,0],      [100,50,0],[30,-110,0] , [-90,-140,0]];
  $branding_name      = "2020 RC2-inspired";

  $rail_specs         = rails_original_rc300zl;
  $leadscrew_specs    = leadscrew_original_rc300zl;
  $bed                = bed_standard_rc300;
  $feet_depth         = 50 ;
  children();
}

module cheesecore300zl1(position = [0, 0, 0]) {
  $NEMA_XY            = NEMA23;
  $NEMA_Z             = NEMA17;
  $extrusion_type     = extrusion20;

  $frame_size         = frame_original_rc300zl;
  $panels             = panels_steel;
  $enclosure_size     = enclosure_large;
  $halo_size          = halo_rc;
  $front_window_size  = front_window_original_300zl;
  $elecbox            = ["ELEC.BOX", 340,   270,   59 ,   6,    25,    true,   [-84,146.5,0], [-85,70,0],      [-85,-40,0],      [100,50,0],[30,-110,0] , [-90,-140,0]];
  $branding_name      = "cheesecore ZL1";

  $rail_specs         = rails_misumi_420;
  $leadscrew_specs    = leadscrew_original_rc300zl;
  $bed                = bed_standard_rc300;
  $feet_depth         = 50 ;
  children();
}

// CHEESEANDHAM'S "300ZL"
module cheesecore300zl2(position = [0, 0, 0]) {
  $NEMA_XY            = NEMA23;
  $NEMA_Z             = NEMA17;
  $extrusion_type     = extrusion15;

  $frame_size         = [460, 445, 415] + [15*2,15*2,15*2];
  $panels             = panels_metric;
  $enclosure_size     = enclosure_large;
  $halo_size          = halo_rc;
  $front_window_size  = front_window_original_300zl;
  $elecbox            = elec_cheesecore; //electronics box size and placements
  $branding_name      = "cheesecore ZL2";

  $rail_specs         = rails_misumi_420;
  $leadscrew_specs    = ["LEADSCREW_SPECS", 420, 8,     4,                 16,       22,          3.4];
  $bed                = bed_standard_rc300;
  $feet_depth         = 50 ;
    children();
}

// RAILCORE II ZL improvement playground
module cheesecore300zl3(position = [0, 0, 0]) {
  $NEMA_XY            = NEMA23;
  $NEMA_Z             = NEMA17;
  $extrusion_type     = extrusion15;

  $frame_size         = [460, 445, 415] + [15*2,15*2,15*2];
  $panels             = panels_cheese;
  $enclosure_size     = enclosure_large;
  $halo_size          = halo_rc;
  $front_window_size  = front_window_original_300zl;
  $elecbox            = elec_cheesecore; //electronics box size and placements
  $branding_name      = "cheesecore ZL3";

  $rail_specs         = rails_misumi_420;
  $leadscrew_specs    = ["LEADSCREW_SPECS", 420, 8,     4,                 16,       22,          3.4];
  $bed                = bed_standard_rc300;
  $feet_depth         = 50 ;
  children();
}

// ABSURDO 4040 EXTRUSION RAILCORE
module rc300zl40(position = [0, 0, 0]) {
  $NEMA_XY            = NEMA23;
  $NEMA_Z             = NEMA17;
  $extrusion_type     = extrusion30;

  $frame_size         = frame_rc300zl4040;
  $panels             = panels_metric;
  $enclosure_size     = enclosure_large;
  $halo_size          = halo_rc4040;
  $front_window_size  = front_window_original_300zl;
  $elecbox            = elec_custom; //electronics box size and placements
  $branding_name      = "cheesecore 4040 ZL";

  $rail_specs         = rails_300zl_4040;
  $leadscrew_specs    = leadscrew_zl4040;
  $bed                = bed_custom;
  $feet_depth         = 50 ;
  children();
}



// ORIGINAL RAILCORE II 300ZL
module rc300zl420ya(position = [0, 0, 0]) {
  $NEMA_XY            = NEMA17;
  $NEMA_Z             = NEMA17;
  $extrusion_type     = extrusion15;

  $frame_size         = frame_original_rc300zl + [0,20,0] ;
  $panels             = panels_metric;
  $enclosure_size     = enclosure_rc_standard;
  $halo_size          = halo_rc;
  $front_window_size  = front_window_original_300zl;
  $elecbox            = elecbox_300_large;
  $branding_name      = "RC300C/420Y";

  $rail_specs         = [[420, MGN12], [420, MGN12], [420, MGN12]];;
  $leadscrew_specs    = ["LEADSCREW_SPECS", 400, 8,     4,                 16,       22,          3.4];;
  $bed                = bed_standard_rc300;
  $feet_depth         = 50 ;
  children();
}

// ORIGINAL RAILCORE II 300ZL
module rc300_2020_420ya(position = [0, 0, 0]) {
    $NEMA_XY            = NEMA17;
    $NEMA_Z             = NEMA17;
    $extrusion_type     = extrusion20;

    $frame_size         = frame_original_rc300zl + [0,20,0] + [5*2,5*2,5*2];  // extra 20mm for Y and 2*5mm larger corner cubes.
    $panels             = panels_metric;
    $enclosure_size     = enclosure_rc_standard;
    $halo_size          = halo_rc;
    $front_window_size  = front_window_original_300zl;
    $elecbox            = elecbox_300_large;
    $branding_name      = "300/2020/420Y";

    $rail_specs         = [[395, MGN12], [420, MGN12], [395, MGN12]];;
    $leadscrew_specs    = ["LEADSCREW_SPECS", 400, 8,     4,                 16,       22,          3.4];;
    $bed                = bed_standard_rc300;
    $feet_depth         = 50 ;
    children();
  }





  // derbycore - designed for A.Derbyshire from spare parts, 300*220 Creality CR-10 Mini bed size
  module derbycore(position = [50, 50, 0]) {
  //                            name       sizeXY   depth thick
  $front_window_size  = ["WINDOW_TYPE", [320, 285], 10, [0, 5]];
  $extrusion_type     = extrusion20;
  $NEMA_XY            = NEMA17;
  $NEMA_Z             = NEMA17;
  //                    sizeX sizeY sizeZ
  $frame_size         = [360, 425, 315] + [40,40,40];
  //                    sizeX  Xtype  sizeY  Ytype    sizeZ Ztype
  $rail_specs         = [[300, MGN9], [400, MGN12], [300, MGN9]];
  //                     Name           height diameter
  $leadscrew_specs    = ["LEADSCREW_SPECS", 330,  8];
  //                      name  bed_plate_size   motor space  bed_overall_size  bed thickness
  $bed                = ["BED", [245, 342],      255,        [255+10, 242],        0.25 * inch];

  // ELECTRONICS BOX ALONG WITH  & ELECTRONICS & CABLE PLACEMENT -  placement of parts on right panel with X/Y as centre
  //                    name       sizeX  sizeY  depth thick, lasercut cable_bundle    DuetE            Duex              PSU        SSR              RPi
  $elecbox            = ["ELEC.BOX", 300, 260, 59 ,   6,     true,   [-84,126.5,0], [-84.82,50.5,0], [-84.82,-59.5,0], [60,00,0],  [145,50,0] , [-90,-140,0]] ;
  $branding_name      = "DerbyCore";
  $enclosure_size     = [360, 425, 315] + [40,40,40] + [150, side_panel_thickness() * 2, -150];
  $panels             = panel_rc300zlt;
  $halo_size          = [400 + 150, 465 + side_panel_thickness() * 2, 4];
  $feet_depth         = 50 ;
  children();
  }
