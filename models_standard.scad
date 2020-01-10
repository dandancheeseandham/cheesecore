include <config.scad>

// ORIGINAL RAILCORE II ZL
module rc300zl(position = [0, 0, 0]) {
  $NEMA_XY            = NEMA17;
  $NEMA_Z             = NEMA17;
  $extrusion_type     = extrusion15;

  $frame_size         = frame_rc300zl;
  $rail_specs         = rails_rc300zl;
  $enclosure_size     = enclosure_rc300zl;
  $halo_size          = halo_rc300zl ;

  $leadscrew_specs    = leadscrew_rc300zl ;
  $front_window_size  = front_window_zl;
  $bed                = bed_rc300;

  $elecbox            = elec_ZL;
  $branding_name      = "Original ZL";

  //$feet_depth         = 50 ;
  children();
}

// ORIGINAL RAILCORE II ZLT
module rc300zlt(position = [0, 0, 0]) {
  $front_window_size  = front_window_zlt;
  $extrusion_type     = extrusion15;
  $NEMA_XY            = NEMA17;
  $NEMA_Z             = NEMA17;
  $frame_size         = frame_rc300zlt;
  $rail_specs         = rails_rc300zlt;
  $leadscrew_specs    = leadscrew_rc300zlt ;
  $bed                = bed_rc300;
  $elecbox            = elec_ZLT ; //electronics box size and placements
  $branding_name      = "Original ZLT";
  $enclosure_size     = enclosure_rc300zl;
  $halo_size          = halo_rc300zl ;
  children();
}
