// main body
$fn=40;

base_width = 24.5 ; 
base_height = 4 ; 
acrylic_thickness = 7 ;
acrylic_catchment_depth = 4 ;
wall_thickness = 10 ;
L_fillet_size = 4.5 ;
L_height = 45 ;
extrusion = 15 ; 
piece_length = 310 ;


difference(){
  rotate ([90,0,0])
    linear_extrude(piece_length) {
      difference() {
        union() {
          square(size = [base_width, base_height]) ;  //bottom of L
          square(size = [wall_thickness, L_height]) ;  // upline of L
          translate([wall_thickness,base_height])
            square(size = [L_fillet_size/2, L_fillet_size/2]) ;  //add for "crook of L" fillet removal
        }
        translate([wall_thickness - acrylic_thickness,L_height-acrylic_catchment_depth])
          square(size = [acrylic_thickness, acrylic_catchment_depth]) ;  //top cutout
        
        translate([0,L_height-2])
          rotate ([0,0,45]) 
            square(size = [4, 4]) ;  //top chamfer

        translate([wall_thickness + 2.25,acrylic_thickness-0.75])
          circle(d=L_fillet_size); // "crook of L" fillet removal
      }
    }
  for (y =[15:30:piece_length]) {
    translate([base_width-(extrusion/2),-y,-10]) cylinder(h = 20 , d=3);
    }
    //remove V fitting
     translate ([wall_thickness/2-acrylic_thickness/2+hyp,-acrylic_thickness/2-piece_length,0]) rotate ([0,0,45])
cube ([hyp,hyp,L_height-acrylic_catchment_depth]); 
}
//add V fitting
hyp = pow((pow(acrylic_thickness,2)/2),1/2) ; 
  translate ([wall_thickness/2-acrylic_thickness/2+hyp,-acrylic_thickness/2,0]) rotate ([0,0,45])
cube ([hyp,hyp,L_height-acrylic_catchment_depth]);

//30mm interval (20mm gap)
for (y =[7.5 : 30 : piece_length]) {
  translate ([11.5,-y,0])
    arm_bit();
}

module arm_bit() {
  // arm bits
  difference(){
    union(){
      rotate ([0,0,90])
        linear_extrude(L_height-1.5) 
          difference(){
            union() {
              hull(){
                circle(d=3.0);
                translate([4.0,0])
                  circle(d=3.0);
              }
            translate([-3.0,0]) square([3.0,1.5]);
            translate([4.0,0]) square([3.0,1.5]);
            }
          translate([7.0,0]) circle(d=3.0);
          translate([-3.0,0]) circle(d=3.0);
          }
    }
    translate([-4.5,-10,L_height - 1])  rotate ([0,45,0]) cube([4,20,6]);  //make diagnol
  }
}