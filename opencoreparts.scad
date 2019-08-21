// vim: set nospell:
include <config.scad>
include <core.scad>
include <lib.scad>

// this renders the belts at the specified carriage position
// origin is the center of the build volume.  We will adjust this later when we have better data for printhead offsets
module corexy_belts(position = [0, 0]) {
  // This defines how far about the lower belt path the upper belt path is
  vertical_offset = 10;

  // This sets how far from centerline of the machine the idler stack on the x-carriages is.
  // FIXME: the 13 is approximation of MGN12 carriage height
  // FIXME: the 5 is approximation of how far from carriage face center of idler pulley is
  x_carriage_pulley_offset = extrusion_length.y/2 - 13 - 5;

  // x/y coordinate of the x-carriage stack;
  carriage_stack = [position.x, x_carriage_pulley_offset];

  // Location of steppers in x
  // FIXME: the offset is made up
  stepper_location = extrusion_length.x/2 + 50;

  // FIXME: we use 16 tooth pulley instead of 20
  // FIXME: extract out vars for idler types to shorten this?
  // FIXME: everything but the actual carriage stack needs adjusted to put pulleys correctly in line
  lower_path = [
    [[carriage_stack.x, -carriage_stack.y], GT2x20_plain_idler], // front idler stack
    [[stepper_location, -carriage_stack.y-10], GT2x20um_pulley], // front stepper
    [[-extrusion_length.x/2, -x_carriage_pulley_offset], GT2x20_toothed_idler], // front left idler
    [[-extrusion_length.x/2, x_carriage_pulley_offset], GT2x20_toothed_idler], // rear left idler
    [[carriage_stack.x, carriage_stack.y], GT2x20_toothed_idler],  // rear idler stack
  ];

  upper_path = [
    [[carriage_stack.x, -carriage_stack.y], GT2x20_toothed_idler], // front idler stack
    [[-extrusion_length.x/2, -x_carriage_pulley_offset], GT2x20_toothed_idler], // front left idler
    [[-extrusion_length.x/2, x_carriage_pulley_offset], GT2x20_toothed_idler], // rear left idler
    [[stepper_location, carriage_stack.y+10], GT2x20um_pulley], // rear stepper
    [[carriage_stack.x, carriage_stack.y], GT2x20_toothed_idler]  // rear idler stack
  ];

  belt=GT2x6;

  for(p=lower_path) {
    translate(p[0]) pulley_assembly(p[1]);
  }

  path = [ for(p=lower_path) [p[0].x, p[0].y, pulley_pr(p[1])] ];
  belt(type=belt, points=path, gap=10, gap_pt=[0,  belt_pitch_height(belt) - belt_thickness(belt) / 2]);

  translate([0,0, vertical_offset]) {
    for(p=upper_path) {
      translate(p[0]) pulley_assembly(p[1]);
    }
    path = [ for(p=upper_path) [p[0].x, p[0].y, pulley_pr(p[1])] ];
    belt(type=belt, points=path, gap=10, gap_pt=[0,  belt_pitch_height(belt) - belt_thickness(belt) / 2]);
  }
}

corexy_belts([0, 0]);
