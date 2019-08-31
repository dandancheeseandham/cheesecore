include <config.scad>


module screwholes(row_distance,numberofscrewholes,Mscrew,screwhole_increase) 
{
	// screwhole_increase = amount to increase screwholes so screws fit - 0.1 for aluminium parts and 0.25 for panels
	screwholeradius=Mscrew/2+screwhole_increase;
	gapY=(row_distance)/(numberofscrewholes-1);
	Zremoveheight=50;
	for (a =[0:(numberofscrewholes-1)])
		{ 
		translate ([0,(gapY*a),-Zremoveheight]) cylinder(Zremoveheight*2, screwholeradius,screwholeradius); 
		}
}


module singlescrewhole(Mscrew,screwhole_increase) 
{
	screwholeradius=Mscrew/2+screwhole_increase;
	Zremoveheight=50;
	translate ([0,0,-Zremoveheight]) cylinder(Zremoveheight*2, screwholeradius,screwholeradius);  
}


module longscrewhole(screwhole_length,Mscrew,screwhole_increase) 
{
	translate([0,0,-50]) linear_extrude(height = 100, twist = 0) 
		{ 
		hull() 
			{
			translate([screwhole_length,0,0]) circle((Mscrew/2)+screwhole_increase);
			circle((Mscrew/2)+screwhole_increase);
			}
		}
}

translate([50,0,0]) longscrewhole(screwhole_length=40,Mscrew=5,screwhole_increase=0.25);
screwholes(row_distance=60,numberofscrewholes=6,Mscrew=3,screwhole_increase=0.25);
translate([-50,0,0]) singlescrewhole(3,0.25);



