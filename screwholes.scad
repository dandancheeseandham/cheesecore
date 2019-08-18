module screwholes(row_distance,numberofscrewholes,Mscrew,screwhole_increase) {
// screwhole_increase = amount to increase screwholes so screws fit - 0.1 for aluminium parts and 0.25 for panels

 screwholeradius=Mscrew/2+screwhole_increase;
 gapY=(row_distance)/(numberofscrewholes-1);
Zremoveheight=55;
  for (a =[0:(numberofscrewholes-1)])
 { translate ([0,(gapY*a),-Zremoveheight]) cylinder(Zremoveheight*2, screwholeradius,screwholeradius); }
}


module longscrewhole(screwhole_length,Mscrew,screwhole_increase) {

 translate([0,0,-30]) linear_extrude(height = 60, twist = 0, slices = 60) { hull() {
    translate([screwhole_length,0,0]) circle((Mscrew/2)+screwhole_increase);
    circle((Mscrew/2)+screwhole_increase);
}
}
}