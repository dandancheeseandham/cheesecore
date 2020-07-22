include <dotSCAD.scad>
$fn = 24;
epsilon = 0.1;//very small number
w = 0.1;
wt = w *0.1;
module line_segment(p1, p2, w) {  
  hull() {
    translate(p1) circle(r=w);
    translate(p2) circle(r=w);
  }
}
module line_segment_thin(p1, p2, wt) {  
  hull() {
    translate(p1) circle(r=w*0.1);
    translate(p2) circle(r=w*0.1);
  }
}
// Thin grid
for (i =[-150-w:10:150-w]){   
    line_segment_thin(p1 = [-150, i], p2 = [150, i]);
    line_segment_thin(p1 = [i, -150], p2 = [i, 150,]);
}    
// Thick grid
for (i =[-150-w:50:150-w]){   
    line_segment(p1 = [-150, i], p2 = [150, i]);
    line_segment(p1 = [i, -150], p2 = [i, 150,]);
}
if(false){
//Text
for (i =[0:50:300]){
 translate([-155 +i, -162]) {
   text(str(i), font = "Liberation Sans");
     }
 translate([-175, -155+ i]) {
   text(str(i), font = "Liberation Sans");
     }     
 }
 // Bounding box
line_segment_thin(p1 = [-180, -170], p2 = [-180, 170]);
line_segment_thin(p1 = [180, -170], p2 = [180, 170]); 
line_segment_thin(p1 = [-180, -170], p2 = [180, -170]);
line_segment_thin(p1 = [-180, 170], p2 = [180, 170]); 
 }