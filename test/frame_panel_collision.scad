// When rendered, this will show non-manifold surfaces where the frame and
// panels touch, but will also show areas of obvious thickness if there is
// overlap.
// We could perhaps make this work a little slicker by spacing the panels
// off the frame by a distance of epsilon (would make a "good test" yield
// a totally blank render).  If we do that, we probably want to make the
// panels thinner than required by an epsilon as well, so the outside
// don't collide with components that mount to them.  Perhaps we could
// even have a $collisiontest variable or similar to adjust this on the
// fly just for these tests?

use <../side_panels.scad>
use <../frame.scad>

intersection() {
  all_side_panels();
  frame();
}
