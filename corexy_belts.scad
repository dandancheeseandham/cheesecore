// vim: set nospell:
include <config.scad>
use <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
use <demo.scad>

// this renders the belts at the specified carriage position
// origin is the center of the build volume.  We will adjust this later when we have better data for printhead offsets
module corexy_belts(position = [0, 0]) {

  // NOT USER MODIFIED
  // This defines how far above the lower belt path the upper belt path is
  vertical_offset = 9; // an 8.6mm heigh GT2 pulley, with a 0.4mm shim on top

    // x/y coordinate of the x-carriage stack;
  // FIXME: the +62 here is an approximation to make things look decent positioned over the X carriage
  carriage_stack = [position.x + 62 , motor_pulley_link()];

  // Location of steppers in x
  // FIXME: the stepper offset works for the stepper, but the idler moves also.
  gap_for_screws = 6; //
  stepper_offset = NEMA_width(NEMAtypeXY())/2 + side_panel_thickness() + gap_for_screws;

/*
  idler_offset_outer() =  0;  //tie this to the pulley location - these are relative to the centre of the extrusion on the left side
  idler_offset_inner() =  0;  //tie this to the pulley location - these are relative to the centre of the extrusion on the left side
*/
  //stepper_location = extrusion_length.x/2 + stepper_offset;

  // Where to position the crossover
  // FIXME: this is a hack that doesn't account for the bed offset of geometry
  bed_offset_of_geometry = 150;
  ypos = position.y - bed_offset_of_geometry;

  // FIXME: we use 16 tooth pulley instead of 20
  // FIXME: extract out vars for idler types to shorten this?
  // FIXME: everything but the actual carriage stack needs adjusted to put pulleys correctly in line - FIXED?
  // [ coordinate, pulley/idler type, whether to invert radius, whether to show pulley ]
  // ADDITION: new railcore addtions GT2x16_pulley_5b , GT2x20_plain_idler_5b , GT2x20_tooth_idler_5b in vitamins/pulleys.scad

  lower_path = [
    [[carriage_stack.x, -carriage_stack.y ], GT2x20_plain_idler, true, true], // front idler stack
    [[frame_size().x / 2 + stepper_offset , -carriage_stack.y - pulley_pr(GT2x20_plain_idler) - pulley_pr(GT2x16_pulley)], GT2x16_pulley, false, true], // front stepper
    [[ idler_offset_outer() + extrusion_width()/2 - frame_size().x / 2 - stepper_offset, -motor_pulley_link() - pulley_pr(GT2x20_plain_idler) - pulley_pr(GT2x16_pulley)], GT2x20_toothed_idler, false, true], // front left idler
    [[-frame_size().x / 2 + idler_offset_inner() + extrusion_width()/2, motor_pulley_link()], GT2x20_toothed_idler, false, true], // rear left idler
    [[carriage_stack.x, carriage_stack.y ], GT2x20_toothed_idler, false, true],  // rear idler stack
    [[carriage_stack.x, ypos + 7], GT2x20_plain_idler, false, false],  // fake idler to offset belt
    [[carriage_stack.x, ypos - 7], GT2x20_plain_idler, true, false],  // fake idler to offset belt
  ];

  upper_path = [
    [[carriage_stack.x, -carriage_stack.y ], GT2x20_toothed_idler, false, true], // front idler stack
    [[-frame_size().x / 2 + idler_offset_inner() + extrusion_width()/2, -motor_pulley_link()], GT2x20_toothed_idler, false, true], // front left idler
    [[idler_offset_outer() + extrusion_width()/2 - frame_size().x / 2 - stepper_offset, motor_pulley_link()+pulley_pr(GT2x20_plain_idler)+pulley_pr(GT2x16_pulley)], GT2x20_toothed_idler, false, true], // rear left idler
    [[frame_size().x / 2  + stepper_offset, carriage_stack.y+pulley_pr(GT2x20_plain_idler) + pulley_pr(GT2x16_pulley)], GT2x20um_pulley, false, true], // rear stepper
    [[carriage_stack.x, carriage_stack.y ], GT2x20_plain_idler, true, true],  // rear idler stack
    [[carriage_stack.x, ypos + 7], GT2x20_plain_idler, true, false],  // fake idler to offset belt
    [[carriage_stack.x, ypos - 7], GT2x20_plain_idler, false, false],  // fake idler to offset belt
  ];

  belt=GT2x6;

  translate([0,0,0]) {
    for(p=lower_path) {
      if(p[3])
        translate(p[0]) rotate ([0,180,0]) pulley_assembly(p[1]);  //FIXME (not sure if a FIXME, highlighting for a check!) rotate 180 so front motor pulley is in correct orientation
    }

    path = [ for(p=lower_path) [p[0].x, p[0].y, p[2] ? -pulley_pr(p[1]) : pulley_pr(p[1])] ];
    belt(type=belt, points=path, gap=10, gap_pt=[0,  belt_pitch_height(belt) - belt_thickness(belt) / 2]);
  }

  translate([0,0, vertical_offset]) {
    for(p=upper_path) {
      if(p[3])
        translate(p[0]) pulley_assembly(p[1]);
    }
    path = [ for(p=upper_path) [p[0].x, p[0].y, p[2] ? -pulley_pr(p[1]) : pulley_pr(p[1])] ];
    belt(type=belt, points=path, gap=10, gap_pt=[0,  belt_pitch_height(belt) - belt_thickness(belt) / 2]);

  }
  function aluminium_idler_mount_test() = [idler_offset_outer() + extrusion_width()/2 - frame_size().x / 2 - stepper_offset, -motor_pulley_link() - pulley_pr(GT2x20_plain_idler) - pulley_pr(GT2x16_pulley)];
  //echo (aluminium_idler_mount_test());
}

module pulley_marker()
{
cylinder(d=3,h=40);
}

demo() {
  corexy_belts([0, 0]);
}
