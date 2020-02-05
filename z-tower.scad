// vim: set nospell:
include <config.scad>
include <nopscadlib/core.scad>
include <nopscadlib/lib.scad>
use <extrusion.scad>
use <lib/layout.scad>
use <rail.scad>
use <z-yoke6.scad>
use <coupler.scad>
use <anti-backlash-nut.scad>
use <z-bracket.scad>
use <leadscrew.scad>
use <demo.scad>
use <bearing_block.scad>
use <coupler.scad>

// Adjust these three to line up the leadscrew, yoke and rail carriage
function leadscrew_nut_position() = -16;
function z_yoke_adjust() = 0.4;
function rail_carriage_adjust() = -14 ;

// FIXME: this will break down if the rails is closer to full length of extrusion
// How far the z-rails are offset from the center of the machine.  x,y should always be zero.
function offset_z_rails() = [0, 0, coupler_height() + side_panel_thickness()];// coupler lengths + panel thickness = so that end of the rail is about even with top of coupler

// FIXME: rough approximation of how to get from the nozzle tip to the centroid of the y-rail carriage
function offset_nozzle_carriage() = [-20, -5, -54];

// adjust to top of frame, down to middle of extrusion, nozzle offset, down bed thickness
function offset_bed_from_frame(position) = [bed_offset().x, bed_offset().y, frame_size().z / 2 - position.z - extrusion_width() / 2  + offset_nozzle_carriage().z - bed_thickness()];

// Basically we take the bed position, adjust for it being referenced off center of cube where this is from tower base, then adjust for offset from yoke origin to bed mounting ear
function yoke_z_offset_from_base(z_position) = offset_bed_from_frame([0, 0, z_position]).z + frame_size().z / 2 + bed_thickness() ;

module z_tower(z_position=0) {
  carriage_position = frame_size().z / 2 - z_position - offset_z_rails().z/2 + offset_nozzle_carriage().z + rail_carriage_adjust();

  // Z motors
  translate ([-leadscrew_x_offset(),0, -side_panel_thickness()])
    NEMA(NEMAtypeZ());

  //Coupler is connected to the motor
  translate ([-leadscrew_x_offset(),0,5])   // 5mm above the NEMA motor then panel
    coupler();

    if (bearing_block() == true || leadscrew_length() > 500) {
      translate ([-leadscrew_x_offset(), 0, epsilon])
        bearing_block_v3();
    }

  translate ([-leadscrew_x_offset(), 0, NEMA_shaft_length(NEMAtypeZ())])
    leadscrew();

  // Anti Backlash nut - connected to the leadscrew
  translate([-leadscrew_x_offset(), 0, yoke_z_offset_from_base(z_position) + leadscrew_nut_position()])
    rotate ([180,0,0]) anti_backlash_nut(8);

  // Z-yoke - connected to the anti-backlast nut
  translate([-extrusion_width() - carriage_height(rail_carriage(rail_profiles().z)), leadscrew_y_offset(), yoke_z_offset_from_base(z_position)+z_yoke_adjust()])
    z_yoke();

  translate ([-extrusion_width(), leadscrew_y_offset(), rail_lengths().z / 2] + offset_z_rails())
    rotate([90,270,270])
      rail_wrapper(rail_profiles().z, rail_lengths().z, position = carriage_position);

  // Extrusion
  //color("Red")
  translate ([-extrusion_width() / 2, leadscrew_y_offset(), frame_size().z / 2])
    extrusion(frame_size().z);

  // bottom Z bracket
  translate([0, leadscrew_y_offset() +extrusion_width()/2, extrusion_width()])
    z_bracket(extrusion_width());

  // top z bracket
  translate([0, leadscrew_y_offset() +extrusion_width()/2, frame_size().z - extrusion_width()])
    mirror([0, 1, 0])
      rotate([180, 0, 0])
        z_bracket(extrusion_width());

  //Debug - set to true for debug info
  if (false) {
    //echo ("rail_length.z",rail_length.z);
    echo ("z_position",z_position);
    //echo("Passing rail position of: ", position);
    //echo("extrusion_length.z",extrusion_length.z);
    echo("extrusion_width" , extrusion_width() );
    echo("NEMA_shaft_length(type)" , NEMA_shaft_length(NEMAtypeZ()) );
  }
}

module z_towers(z_position = 0) {
  translate([bed_offset().x, bed_offset().y, -frame_size().z / 2]) {
    translate([frame_size().x / 2 - extrusion_width(), 0, 0]) z_tower(z_position);
    mirror_y() {
      translate([-frame_size().x / 2 + extrusion_width(), bed_ear_spacing() / 2, 0])
        rotate([0, 0, 180])
          z_tower(z_position);
    }
  }
}

demo() {
  //z_towers(z_position = 0);
  z_tower(100);
}
