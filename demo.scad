// vim: set nospell:
include <config.scad>
use <models_standard.scad>
use <models_experimental.scad>
use <models_test_ground.scad>
// This sets all the required config variables to demo a part without needing to specify them in every file.
module demo() {
  cheesecore_300zl_mod()
  children();
}
