#!/bin/bash
cd ../../
mkdir -p artifacts/cheesecore_300zl

# openscad
OPENSCAD="openscad-nightly"
MODEL="cheesecore_300zl"

echo Creating a $MODEL
echo Parts are created in \artifacts\

echo "creating new script file."

## create renderfile

cat > make_$MODEL.scad <<EOF
// vim: set nospell:
use <models_standard.scad>
use <models_experimental.scad>
use <models_test_ground.scad>
use <core.scad>
  $MODEL()
    printer(position = [80, 90, 30]);
EOF


## create export artifacts file.
cat > build/export_config.scad <<EOF
// vim: set nospell:
use <../models_standard.scad>
use <../models_experimental.scad>
use <../models_test_ground.scad>
module export_artifacts() {
  $MODEL()
   children();
}
EOF

# loop over all .dxf.scad or .stl.scad files in build build directory
for source in build/*.dxf.scad build/*.stl.scad ; do
  dest=`basename --suffix=.scad ${source}`

  echo "Building artifacts/${dest} from ${source}"
  ${OPENSCAD} -o artifacts/cheesecore_300zl/${dest} ${source}
done


# loop over all .stl.scad files in build build directory
for source in build/*.stl.scad ; do
  dest=`basename --suffix=.scad ${source}`

  echo "Building artifacts/${dest} from ${source}"
  ${OPENSCAD} --imgsize=1920,1200 -o artifacts/cheesecore_300zl/${dest} ${source}
done




