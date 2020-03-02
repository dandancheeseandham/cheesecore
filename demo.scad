// vim: set nospell:
include <config.scad>
use <models_standard.scad>
use <models_experimental.scad>
// This sets all the required config variables to demo a part without needing to specify them in every file.
module demo() {
cheesecore_300zl()
  children();
}
