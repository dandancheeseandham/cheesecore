// vim: set nospell:
include <config.scad>
use <models_standard.scad>
// This sets all the required config variables to demo a part without needing to specify them in every file.
module demo() {
railcore_300ZL_compatible()
  children();
}
