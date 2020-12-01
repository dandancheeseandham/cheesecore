include <config.scad>

// ORIGINAL RAILCORE II 300ZL
module railcore_300ZL_compatible(position = [0, 0, 0]) {
  $NEMA_XY            = NEMA17;
  $NEMA_Z             = NEMA17;
  $extrusion_type     = extrusion15;

  $frame_size         = frame_original_rc300zl;
  $panels             = panels_imperial;
  $enclosure_size     = enclosure_rc_standard;
  $halo_size          = halo_rc;
  $front_window_size  = front_window_original_300zl;
  $elecbox            = elecbox_original_rc300zl;


  $rail_specs         = rails_original_rc300zl;
  $leadscrew_specs    = leadscrew_original_rc300zl;
  $bed                = bed_standard_rc300;
  $feet_depth         = 50 ;
  $branding_name      = "Original 300ZL";
  $description        = [
                        ];

  children();
}

// ORIGINAL RAILCORE II ZLT
module railcore_300ZLT_compatible(position = [0, 0, 0]) {
  $NEMA_XY            = NEMA17;
  $NEMA_Z             = NEMA17;
  $extrusion_type     = extrusion15;

  $frame_size         = frame_original_rc300zlt;
  $panels             = panels_imperial;
  $enclosure_size     = enclosure_rc_standard;
  $halo_size          = halo_rc;
  $front_window_size  = front_window_original_300zlt;
  $elecbox            = elecbox_original_rc300zlt;
  $branding_name      = "Original 300ZLT";

  $rail_specs         = rails_original_rc300zlt;
  $leadscrew_specs    = leadscrew_original_rc300zlt;
  $bed                = bed_standard_rc300;
  $feet_depth         = 50 ;
  children();
}

// ORIGINAL RAILCORE II 250ZL
module railcore_250ZL_compatible(position = [0, 0, 0]) {
  $NEMA_XY            = NEMA17;
  $NEMA_Z             = NEMA17;
  $extrusion_type     = extrusion15;

  $frame_size         = frame_original_rc250zl;
  $panels             = panels_imperial;
  $enclosure_size     = enclosure_rc_standard;
  $halo_size          = halo_rc;
  $front_window_size  = front_window_original_250zl;
  $elecbox            = elecbox_original_rc250zl;
  $branding_name      = "Original 250ZL";

  $rail_specs         = rails_original_rc250zl;
  $leadscrew_specs    = leadscrew_original_rc250zl;
  $bed                = bed_standard_rc250;
  $feet_depth         = 50 ;
  children();
}

// rc150mini - based on a bit of info about the bed from steve :)
module railcore_150_compatible(position = [80, 80, 20]) {
  $NEMA_XY            = NEMA17;
  $NEMA_Z             = NEMA17;
  $extrusion_type     = extrusion15;

  $frame_size         = frame_original_rc150mini;
  $panels             = panels_imperial;
  $enclosure_size     = enclosure_rc_standard;
  $halo_size          = halo_rc150mini;
  $front_window_size  = front_window_original_150mini;
  $elecbox            = elec_miniplaceh; //placeholder
  $branding_name      = "150mini";

  $rail_specs         = rails_original_rc150mini;
  $leadscrew_specs    = leadscrew_original_rc150mini;
  $bed                = bed_standard_rc150mini;
  $feet_depth         = 100 ;
  // 100mm "legs" that the panels extend down to cover
  children();
}

// ORIGINAL RAILCORE II 300ZL
module railcore_300ZL_compatible__production(position = [0, 0, 0]) {
  $NEMA_XY            = NEMA17L;
  $NEMA_Z             = NEMA17;
  $extrusion_type     = extrusion15;

  $frame_size         = frame_original_rc300zl;
  $panels             = panels_steel;
  $enclosure_size     = enclosure_rc_standard;
  $halo_size          = halo_rc;
  $front_window_size  = front_window_original_300zl;
  $elecbox            = elecbox_original_rc300zl;

  $rail_specs         = rails_original_rc300zl;
  $leadscrew_specs    = leadscrew_original_rc300zl;
  $bed                = bed_standard_rc300;
  $feet_depth         = 50 ;
  $branding_name      = "UK Production 300ZL";
  $description        = ["XY steppers = NEMA17L",
                        "Larger e-box.",
                        "Modular Halo",
                        "Detachable Doors",
                        "Top enclosure with 3 part lid & no interface",
                        "Duet2/Duex & Duet3 panel holes",
                        "120mm fan hole & camera mount in back panel",
                        "Spool holder holes in left panel"
                        ];
  children();
}

// EXPERIMENTAL RAILCORE II 300ZL with 450Y
module 300ZL_450Y(position = [0, 0, 0]) {
  $NEMA_XY            = NEMA17;
  $NEMA_Z             = NEMA17;
  $extrusion_type     = extrusion15;

  $frame_size         = frame_original_rc300zl + [0,50,0] ; // extra 50mm for Y
  $panels             = panels_steel;
  $enclosure_size     = enclosure_rc_standard;
  $halo_size          = halo_rc;
  $front_window_size  = front_window_original_300zl;
  $elecbox            = elecbox_original_rc300zl;


  $rail_specs         = [[400, MGN12], [450, MGN12], [400, MGN12]]; // Y is 450
  $leadscrew_specs    = leadscrew_original_rc300zl;
  $bed                = bed_standard_rc300;
  $feet_depth         = 50 ;
  $branding_name      = "300ZL/450Y";
  $description        = ["XY steppers = NEMA17",
                        "ZL 450Y",
                        ];

  children();
}
