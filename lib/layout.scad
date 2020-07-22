// MIT License
// From https://github.com/lostapathy/openscad-libs/blob/master/openscad_util/layout/layout.scad


module mirror_x() {
  children();
    mirror([1, 0, 0]) children();
}

module mirror_y() {
  children();
    mirror([0, 1, 0]) children();
}

module mirror_z() {
  children();
    mirror([0, 0, 1]) children();
}

module mirror_xy() {
  mirror_x() mirror_y() children();
}

module mirror_xz() {
  mirror_x() mirror_z() children();
}

module mirror_yz() {
  mirror_y() mirror_z() children();
}

module mirror_xyz() {
  mirror_x() mirror_y() mirror_z() children();
}

module assert_one_defined(a=undef, b=undef, message="Exactly one must be defined") {
  function is_def(a) = !is_undef(a);

  assert(!is_undef(a) || !is_undef(b), message);
  if(is_def(a))
    assert(is_undef(b), message);
  if(is_def(b))
    assert(is_undef(a), message);
}

module assert_numeric(val, message="Must be a number") {
  assert(is_num(val), message);
}

module assert_xyz(val, message="Must be a vector of [x,y,z]") {
  assert(is_list(val), message);
  assert(len(val) == 3, message);
}

module linear_repeat(offset=undef, extent=undef, count) {
  assert_numeric(count, "Count must be passed as a number");
  assert_one_defined(offset, extent, "Excactly one of extent or offset must be passed");

  true_offset = is_undef(offset) ? extent / (count - 1) : offset;

  assert_xyz(true_offset, "Offset must compute to an [x, y, z] vector");

  for(i = [0:count - 1]) {
    translate(true_offset * i) children();
  }
}

