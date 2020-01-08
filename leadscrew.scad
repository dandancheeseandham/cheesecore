// vim: set nospell:
include <config.scad>
include <demo.scad>

module leadscrew() {
  color(alum_commercial_part_color()) {
    cylinder(h=leadscrew_length(), d = leadscrew_diameter());  // LEADSCREW
  }
}

demo() {
  leadscrew(leadscrew_length,leadscrewwidth);
}
