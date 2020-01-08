// vim: set nospell:
include <config.scad>

// This sets all the required config variables to demo a part without needing to specify them in every file.
module demo() {
  $front_window_size = front_window_zl;
  $branding_name = "300 ZL";
  $NEMA_XY = NEMA17;
  $NEMA_Z = NEMA17;
  $elecbox = elec_ZL;
  $extrusion_type = extrusion15;
  $frame_size = frame_rc300zl;
  $rail_specs = rails_rc300zl;
  $leadscrew_specs = leadscrew_rc300zl ;
  $bed = bed_rc300;
  $enclosure_size = enclosure_rc300zl;
  $draft = false;
  $panels = panels_custom;
  children();
}
