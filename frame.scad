// vim: set nospell:
include <config.scad>
use <extrusion.scad>
use <corner_cube.scad>

cornercube=extrusion; //1515 and 2020 these are the same. 3030 and 4040 will need to look at corner braces perhaps?

module corneruprights()
{
// Front Left Z
translate ([0,extrusion,extrusion])
rotate([90,0,0])
aluminiumextrusion(corneruprightZ,0);
// Front Right Z
translate ([horizontalX+extrusion,extrusion,extrusion])
rotate([90,0,0])
aluminiumextrusion(corneruprightZ,0);
// Rear Right Z
translate ([horizontalX+extrusion,horizontalY+extrusion*2,extrusion])
rotate([90,0,0])
aluminiumextrusion(corneruprightZ,0);
// Rear Left Z
translate ([0,horizontalY+extrusion*2,extrusion])
rotate([90,0,0])
aluminiumextrusion(corneruprightZ,0);
}

module Xextrusions()
{
//Top Front X
translate ([extrusion,extrusion,corneruprightZ+extrusion])
rotate([0,0,-90])
aluminiumextrusion(horizontalX,0);
//Top Rear X
translate ([horizontalX+extrusion,horizontalY+extrusion,corneruprightZ+extrusion])
rotate([0,0,90])
aluminiumextrusion(horizontalX,0);
//Bottom Rear X
translate ([horizontalX+extrusion,horizontalY+extrusion,0])
rotate([0,0,90])
aluminiumextrusion(horizontalX,0);
//Bottom Front X
translate ([extrusion,extrusion,0])
rotate([0,0,-90])
aluminiumextrusion(horizontalX,0);
}

module horizontalYextrusions()
{
        // Bottom Left Y
        translate ([0,extrusion,0])
        rotate([0,0,0])
        aluminiumextrusion(horizontalY,0);
        // Bottom Right Y
        translate ([horizontalX+extrusion,extrusion,0])
        rotate([0,0,0])
        aluminiumextrusion(horizontalY,0);
        // Top Left Y
        translate ([0,extrusion,corneruprightZ+extrusion])
        rotate([0,0,0])
        aluminiumextrusion(horizontalY,0);
        // Bottom Right Y
        translate ([horizontalX+extrusion,extrusion,corneruprightZ+extrusion])
        rotate([0,0,0])
        aluminiumextrusion(horizontalY,0);
        echo("horizontalY are ", horizontalY , "mm");

}

////////////////////////
// BOM: Corner Cubes
////////////////////////
module orig_cornercube() {
  translate([extrusion/2, extrusion/2, extrusion/2])
    corner_cube(extrusion);
}
module corner_cubes()
{
  //Bottom Front Left Corner Cube
  rotate([90,00,270])
  translate ([-extrusion,0,-extrusion])
  orig_cornercube();
  //Bottom Back Left Corner Cube
  translate ([extrusion,horizontalY+extrusion*2,extrusion])
  rotate([180,90,0])
  orig_cornercube();
  //Bottom Front Right Corner Cube
  translate ([horizontalX+extrusion,extrusion,0])
  rotate([90,0,0])
  orig_cornercube();
  //Bottom Back Right Corner Cube
  translate ([horizontalX+extrusion,horizontalY+extrusion*2,extrusion])
  rotate([180,0,0])
  orig_cornercube();

  //Top Front Left Corner Cube
  translate ([extrusion,0,corneruprightZ+extrusion])
  rotate([270,270,90])
  orig_cornercube();
  //Top Back Left Corner Cube
  translate ([0,horizontalY+extrusion,corneruprightZ+extrusion])
  rotate([0,270,270])
  orig_cornercube();
  //Top Front Right Corner Cube
  translate ([horizontalX+extrusion,0,corneruprightZ+extrusion])
  rotate([0,0,0])
  orig_cornercube();
  //Top Back Right Corner Cube
  translate ([horizontalX+extrusion,horizontalY+extrusion,corneruprightZ+extrusion*2])
  rotate([270,0,0])
  orig_cornercube();
  // ** END CORNER CUBES
}

module frame() {
  // BOM Item Name: 15x15x425 (Misumi HFS3-1515-425 )
  // BOM Quantity: 4
  // BOM Link: http://railco.re/misumi
  // Notes: Misumi pre-cut (Horizontal Y)
  horizontalYextrusions();

  // BOM Item Name: 15x15x415 (Misumi HFS3-1515-415 )
  // BOM Quantity: 4
  // BOM Link: http://railco.re/misumi
  // Notes: Misumi pre-cut (Corner Uprights)
  corneruprights();

  // BOM Item Name: 15x15x460 (Misumi HFS3-1515-460 )
  // BOM Quantity: 4
  // BOM Link: http://railco.re/misumi
  // Notes: Misumi pre-cut (Horizontal X)
  //horizontalX=460;  // Misumi pre-cut (Horizontal X)

  // Manaul attempt at BOM generation :)
  echo("BOM Item Name: Quantity 4: 15x15x",horizontalX," (Misumi HFS3-1515-",horizontalX," )");
  Xextrusions();

  // BOM Item Name: 15x15 Corners (8)
  // BOM Quantity: 1
  // BOM Link: http://railco.re/1515corners
  // Notes: 4 Spare corners after ordering
  corner_cubes();
}

frame();
