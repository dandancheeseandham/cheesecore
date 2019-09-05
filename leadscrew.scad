include <config.scad>
include <demo.scad>

module leadscrew(leadscrew_length,leadscrewwidth)
{
color(alum_commercial_part_color()) {
cylinder(leadscrew_length, leadscrewwidth/2,leadscrewwidth/2);  // LEADSCREW
}
}

demo()
{
leadscrew(leadscrew_length,leadscrewwidth);
}