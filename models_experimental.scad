include <config.scad>

module rc300zlwithcheese(position = [0, 0, 0]) {
  $NEMA_XY            = NEMA17;
  $NEMA_Z             = NEMA17;
  $extrusion_type     = extrusion15;

  $frame_size         = frame_original_rc300zl;
  $panels             = panels_cheese;
  $enclosure_size     = enclosure_rc300zlwithcheese;
  $halo_size          = halo_rc300zlwithcheese;
  $front_window_size  = front_window_original_300zl;
  $elecbox            = elec_new_ZL_cheese;
  $branding_name      = "Cheese 300ZL";

  $rail_specs         = rails__misumi_rc300zlt;
  $leadscrew_specs    = leadscrew_original_rc300zl;
  $bed                = bed_standard_rc300;
  $feet_depth         = 50 ;
  children();
}

module rc300zltwithcheese(position = [0, 0, 0]) {
  $NEMA_XY            = NEMA23;
  $NEMA_Z             = NEMA17;
  $extrusion_type     = extrusion15;

  $frame_size         = frame_cheese_rc300zlt;
  $panels             = panels_cheese;
  $enclosure_size     = enclosure_rc300zlwithcheese;
  $halo_size          = halo_rc300zltwithcheese;
  $front_window_size  = front_window_original_300zl;
  $elecbox            = elec_300zl_with_cheese;
  $branding_name      = "300ZL with Cheese";

  $rail_specs         = rails__misumi_rc300zlt;
  $leadscrew_specs    = leadscrew_rc300zl_with_cheese;
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
  $halo_size          = halo_rc300zl;
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
  $enclosure_size     = enclosure_rc300zl + [20+40,25,20];
  $halo_size          = halo_rc300zl;
  $front_window_size  = front_window_original_300zl;
  $elecbox            = elec_new_ZL;
  $branding_name      = "2020 RC2-inspired";

  $rail_specs         = rails__original_rc300zl;
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
  $enclosure_size     = enclosure_cheesecore300zl;
  $halo_size          = halo_rc300zl;
  $front_window_size  = front_window_original_300zl;
  $elecbox            = elec_new_ZL;
  $branding_name      = "cheesecore ZL1";

  $rail_specs         = rails_cheesecore300zl;
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

  $frame_size         = frame_rc300_steel300zl;
  $panels             = panels_metric;
  $enclosure_size     = enclosure_cheesecore300zl;
  $halo_size          = halo_rc300steel300zlv2;
  $front_window_size  = front_window_original_300zl;
  $elecbox            = elec_cheesecore; //electronics box size and placements
  $branding_name      = "cheesecore ZL2";

  $rail_specs         = rails_cheesecore300zl2;
  $leadscrew_specs    = leadscrew_rc_steel300zl2;
  $bed                = bed_standard_rc300;
  $feet_depth         = 50 ;
    children();
}

// RAILCORE II ZL improvement playground
module cheesecore300zl3(position = [0, 0, 0]) {
  $NEMA_XY            = NEMA23;
  $NEMA_Z             = NEMA17;
  $extrusion_type     = extrusion15;

  $frame_size         = frame_rc300_steel300zl;
  $panels             = panels_cheese;
  $enclosure_size     = enclosure_cheesecore300zl;
  $halo_size          = halo_rc300steel300zlv2;
  $front_window_size  = front_window_original_300zl;
  $elecbox            = elec_cheesecore; //electronics box size and placements
  $branding_name      = "cheesecore ZL3";

  $rail_specs         = rails_cheesecore300zl2;
  $leadscrew_specs    = leadscrew_rc_steel300zl2;
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
  $enclosure_size     = enclosure_rc300zl4040;
  $halo_size          = halo_rc300zl4040;
  $front_window_size  = front_window_original_300zl;
  $elecbox            = elec_custom; //electronics box size and placements
  $branding_name      = "cheesecore 4040 ZL";

  $rail_specs         = rails_rc300zl4040;
  $leadscrew_specs    = leadscrew_zl4040;
  $bed                = bed_custom;
  $feet_depth         = 50 ;
  children();
}
