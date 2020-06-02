include <config.scad>

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

module cheesecore_300zl(position = [0, 0, 0]) {
    $NEMA_XY            = NEMA17;
    $NEMA_Z             = NEMA17;
    $extrusion_type     = extrusion15;

    $frame_size         = frame_original_rc300zl;
    $panels             = panels_steel;
    $enclosure_size     = enclosure_rc_standard;
    $halo_size          = halo_rc;
    $front_window_size  = front_window_cheesecore;
    $elecbox            = elecbox_300_large;
    $branding_name      = "Cheese 300ZL";

    $rail_specs         = rails_original_rc300zl;
    $leadscrew_specs    = leadscrew_original_rc300zl;
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
