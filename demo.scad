include <config.scad>

// This sets all the required config variables to demo a part without needing to specify them in every file.
module demo() {
  $extrusion_type = extrusion15;
  $frame_size = frame_rc300zl;
  $rail_specs = rails_rc300zl;
  $bed = bed_rc300;
  $front_window_size = front_window_zl ;
  children();
}
