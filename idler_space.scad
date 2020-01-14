// vim: set nospell:
include <constants.scad>
include <demo.scad>

module idler_spacer(){
spacer_height = 10 ;
spacer_diameter = 16 ;
spacer_hole_diameter = 5.5 ;

difference() {
cylinder ($fn = 50, h = spacer_height , d = spacer_diameter);
translate ([0,0,-epsilon]) cylinder ($fn = 50, h = spacer_height+epsilon*2 , d = spacer_hole_diameter);
}
}

demo() {
  idler_spacer();
}
