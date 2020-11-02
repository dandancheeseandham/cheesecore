include <config.scad>

module cheesecore_300zl(position = [0, 0, 0]) {
    $NEMA_XY            = NEMA17L;
    $NEMA_Z             = NEMA17;
    $extrusion_type     = extrusion15;

    $frame_size         = frame_original_rc300zl;
    $panels             = panels_steel;
    $enclosure_size     = enclosure_rc_standard;
    $halo_size          = halo_rc_cheese;
    $front_window_size  = front_window_cheesecore;
    //$elecbox            = elecbox_300_large;
    $elecbox            = elecbox_original_rc300zl;
    $branding_name      = "Cheese 300ZL";

    $rail_specs         = rails_original_rc300zl; //rails_rc300zlt_high_temp;
    $leadscrew_specs    = leadscrew_original_rc300zl;
    $bed                = bed_standard_rc300;
    $feet_depth         = 50 ;
    $filament_box       = filament_box_cheesecore;
    children();
  }

module cheesecore_300zl_mod(position = [0, 0, 0]) {
      $NEMA_XY            = NEMA17L;
      $NEMA_Z             = NEMA17;
      $extrusion_type     = extrusion15;

      $frame_size         = frame_original_rc300zl;
      $panels             = panels_steel;
      $enclosure_size     = enclosure_rc_standard;
      $halo_size          = halo_rc_cheese_mod; //halo_rc_NEMA23;
      $front_window_size  = front_window_cheesecore;
      //$elecbox            = elecbox_300_large;
      //$elecbox            = elecbox_original_rc300zl;
      $elecbox            = elec_cheesecore3;
      $branding_name      = "Cheese 300ZL";

      //$rail_specs         = rails_original_rc300zl; //rails_rc300zlt_high_temp;
      $rail_specs         = rails_300zl_4040;
      $leadscrew_specs    = leadscrew_cheesecore_rc300zl;
      $bed                = bed_standard_rc300;
      $feet_depth         = 50 ;
      $filament_box       = filament_box_cheesecore;
      children();
    }


// RAILCORE II 300ZL WITH EXTRA 20mm ON Y
module 300ZL_420Y(position = [0, 0, 0]) {
  $NEMA_XY            = NEMA17;
  $NEMA_Z             = NEMA17;
  $extrusion_type     = extrusion15;

  $frame_size         = frame_original_rc300zl + [0,20,0] ; // extra 20mm for Y
  $panels             = panels_metric;
  $enclosure_size     = enclosure_rc_standard;
  $halo_size          = halo_rc;
  $front_window_size  = front_window_original_300zl;
  $elecbox            = elecbox_300_large;
  $branding_name      = "300ZL/420Y";

  $rail_specs         = [[400, MGN12], [420, MGN12], [400, MGN12]]; // Y is 420
  $leadscrew_specs    = leadscrew_original_rc300zl;
  $bed                = bed_standard_rc300;
  $feet_depth         = 50 ;
  children();
}


// RAILCORE II 300ZL WITH EXTRA 20mm ON Y
module 300ZLT_420Y_15Z(position = [0, 0, 0]) {
  $NEMA_XY            = NEMA17;
  $NEMA_Z             = NEMA17;
  $extrusion_type     = extrusion15;

  $frame_size         = frame_original_rc300zlt + [0,20,0] ; // extra 20mm for Y
  $panels             = panels_metric;
  $enclosure_size     = enclosure_rc_standard;
  $halo_size          = halo_rc;
  $front_window_size  = front_window_original_300zlt;
  $elecbox            = elecbox_300_large;
  $branding_name      = "300ZL/420Y";

  $rail_specs         = [[400, MGN12], [420, MGN12], [700, MGN15]]; // Y is 420
  $leadscrew_specs    = leadscrew_original_rc300zlt;
  $bed                = bed_standard_rc300;
  $feet_depth         = 50 ;
  children();
}


// RC300ZL-inspired 2020 420Y
module 300ZL_2020_420Y(position = [0, 0, 0]) {
    $NEMA_XY            = NEMA17;
    $NEMA_Z             = NEMA17;
    $extrusion_type     = extrusion20;

    $frame_size         = frame_original_rc300zl + [0,20,0] + [5*2,5*2,5*2];  // extra 20mm for Y and 2*5mm are for the larger corner cubes.
    $panels             = panels_metric;
    $enclosure_size     = enclosure_rc_standard;
    $halo_size          = halo_rc;
    $front_window_size  = front_window_original_300zl;
    $elecbox            = elecbox_300_large;
    $branding_name      = "300ZL/420Y/2020";

    $rail_specs         = rails_misumi_420;    // Assumes all Misumi 420mm rails.
    $leadscrew_specs    = ["LEADSCREW_SPECS", 420, 8,     4,                 16,       22,          3.4];;
    $bed                = bed_standard_rc300;
    $feet_depth         = 50 ;
    children();
  }

module 300ZL_2020(position = [0, 0, 0]) {
    $NEMA_XY            = NEMA17;
    $NEMA_Z             = NEMA17;
    $extrusion_type     = extrusion20;

    $frame_size         = frame_original_rc300zl + [5*2,5*2,5*2];  // 2*5mm are for the larger corner cubes.
    $panels             = panels_metric;
    $enclosure_size     = enclosure_rc_standard;
    $halo_size          = halo_rc;
    $front_window_size  = front_window_original_300zl;
    $elecbox            = elecbox_300_large;
    $branding_name      = "300ZL/2020";

    $rail_specs         = rails_original_rc300zl;
    $leadscrew_specs    = leadscrew_original_rc300zl;
    $bed                = bed_standard_rc300;
    $feet_depth         = 50 ;
    children();
  }

  module dans_300zlt(position = [0, 0, 0]) {
    $NEMA_XY            = NEMA17;
    $NEMA_Z             = NEMA17;
    $extrusion_type     = extrusion15;

    $frame_size         = frame_original_rc300zlt;
    $panels             = panels_steel;
    $enclosure_size     = enclosure_rc_standard;
    $halo_size          = halo_rc_dans_ZLT;
    $front_window_size  = front_window_original_300zlt;
    $elecbox            = elecbox_original_rc300zlt;
    $branding_name      = "Dans 300ZLT";

    $rail_specs         = rails_original_rc300zlt;
    $leadscrew_specs    = leadscrew_original_rc300zlt;
    $bed                = bed_standard_rc300;
    $feet_depth         = 50 ;
    $filament_box       = filament_box_cheesecore;
      children();
    }




  module cheesecore_300zl_withsides(position = [0, 0, 0]) {
      $NEMA_XY            = NEMA17;
      $NEMA_Z             = NEMA17;
      $extrusion_type     = extrusion15;

      $frame_size         = frame_original_rc300zl;
      $panels             = panels_aluminium;
      $enclosure_size     = enclosure_rc_standard;
      $halo_size          = halo_rc;
      $front_window_size  = front_window_original_300zl;
      $elecbox            = elecbox_300_large;
      $branding_name      = "Cheese 300ZL";

      $rail_specs         = rails_original_rc300zl;
      $leadscrew_specs    = leadscrew_original_rc300zl;
      $bed                = bed_standard_rc300;
      $feet_depth         = 50 ;
      children();
    }
