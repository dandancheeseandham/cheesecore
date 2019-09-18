
include <config.scad>

*enclosure_fitting(100,200,true);

pass_thru_idler(100,100,0,0);

module pass_thru_idler(length1,length2,adjust1,adjust2)
{
  color(printed_part_color())  render() difference(){
  enclosure_fitting(length1,length2,true);
  translate([-adjust1,-adjust2,-1]) cube ([adjust1*2,adjust2*2,16]);
}
}


module pass_thru_motor(length1,length2,adjust1,adjust2)
{
  color(printed_part_color())  render() difference(){
  enclosure_fitting(length1,length2,true);
  translate([-adjust1,-adjust2+8,-1]) cube ([adjust1*2,adjust2*2,35]);
}
}


module enclosure_fitting(piece_length1,piece_length2,corners=false)
{

// main body
base_width = 25 ;   // extrusion + wall thickness!
base_height = 4 ;   //default 4
acrylic_thickness = 7 ;
acrylic_catchment_depth = 4 ;
wall_thickness = 10 ;
L_fillet_size = 4.5 ;
L_height = 45 ;  //default45
extrusion = 15 ;
hyp = pow((pow(acrylic_thickness,2)/2),1/2) ;

if (corners == false) translate ([base_width,0,0]) rotate ([0,0,180]) main_length(piece_length1);
if (corners == true) {
  //*translate ([0,piece_length,0]) rotate ([0,0,-90]) enclosure_fitting_corner();
  translate ([wall_thickness,30,0]) rotate ([0,0,180]) enclosure_fitting_corner(); //FIXME Magic 30 here.
  translate ([-extrusion,extrusion,0]) cube ([extrusion,extrusion,L_height-acrylic_catchment_depth]) ;
  translate ([wall_thickness,base_width+5,0]) rotate ([0,0,180]) main_length(piece_length1-base_width,false);  //FIXME Magic 5 here
  translate ([-(piece_length2),-wall_thickness+extrusion,0]) rotate ([0,0,90]) main_length(piece_length2-extrusion,true);

}

module main_length(length,no_V_slots=false)
{
color(printed_part_color()) {
  render() {

difference(){
  rotate ([90,0,0])
    linear_extrude(length) {
      //START 2D shape
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

        translate([wall_thickness + 2.25,base_height+L_fillet_size/2])
          circle(d=L_fillet_size); // "crook of L" fillet removal
      }
    }
    //END 2D shape
    if (no_V_slots==false) {//remove a slot in a V shape for enclosure_fitting
      //add V fitting //30mm interval (20mm gap)
     translate ([wall_thickness/2-acrylic_thickness/2+hyp,-acrylic_thickness/2-length,0]) rotate ([0,0,45])
    cube ([hyp,hyp,L_height-acrylic_catchment_depth]);
    }
    //SCREWHOLES in BASE
     for (y =[15:30:length-4]) {
      translate([base_width-(extrusion/2),-y,-10]) cylinder(h = 20 , d=3);
      }


}
translate ([wall_thickness/2-acrylic_thickness/2+hyp,-acrylic_thickness/2,0]) rotate ([0,0,45])
cube ([hyp,hyp,L_height-acrylic_catchment_depth]);
//END 3D SHAPE
for (y =[7.5 : 30 : length-10]) {
  translate ([11.5,-y,0])
    arm_bit();
}

}
}
}





module arm_bit() {
  // arm bits
  //render to remove an artifact.
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

module enclosure_fitting_corner(){
  color(printed_part_color())
translate ([base_width,0,0])
rotate ([0,0,90])
    rotate_extrude(angle=90, convexity=50) {
      2d_corner();
      }

    }


module 2d_corner()
{
difference() {
        union() {
          square(size = [base_width, base_height]) ;  //bottom of L
          translate ([base_width-wall_thickness,0]) square(size = [wall_thickness, L_height]) ;  // upline of L
          translate([base_width - wall_thickness-L_fillet_size/2,base_height])
            square(size = [L_fillet_size/2, L_fillet_size/2]) ;  //add for "crook of L" fillet removal
        }
        translate([base_width - wall_thickness,L_height-acrylic_catchment_depth])
          square(size = [acrylic_thickness, acrylic_catchment_depth]) ;  //top cutout

        translate([base_width,L_height-2])
          rotate ([0,0,45])
            square(size = [4, 4]) ;  //top chamfer

        translate([base_width - wall_thickness  - L_fillet_size/2,base_height + L_fillet_size/2])
          circle(d=L_fillet_size); // "crook of L" fillet removal
      }


}


}
