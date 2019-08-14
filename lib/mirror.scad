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

module repeat_with_offset(offset, copies=1) {
  for(i = [0:copies-1]) {
      translate(offset * i)
            children();
  }
}
