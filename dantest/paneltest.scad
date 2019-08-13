//module motorholes(x,y)
screwholeradius=1.75;
extrusion=15;
z=5;
screwholesX=5;
screwholesY=5;
holefromedge=50;

x=400;
gapX=(x-100)/(screwholesX-1);
y=500;
gapY=(y-100)/(screwholesY-1);

cube([x,y,z]);

 for (a =[0:(screwholesX-1)])
 { translate ([holefromedge+(gapX*a),extrusion/2,-2]) cylinder(z+4, screwholeradius,screwholeradius); }
   for (a =[0:(screwholesY-1)])
 { translate ([extrusion/2,holefromedge+(gapY*a),-2]) cylinder(z+4, screwholeradius,screwholeradius); }
  for (a =[0:(screwholesX-1)])
 { translate ([holefromedge+(gapX*a),y-extrusion/2,-2]) cylinder(z+4, screwholeradius,screwholeradius); }
    for (a =[0:(screwholesY-1)])
 { translate ([x-extrusion/2,holefromedge+(gapY*a),-2]) cylinder(z+4, screwholeradius,screwholeradius); }