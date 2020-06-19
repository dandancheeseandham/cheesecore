# Cheesecore Build Artifact Export

Use `export_artifacts` to export OpenSCAD files under `build/` into dxf or stl files under `artifacts/`

Each file under `build/` is setup to export one artifact file.  The exported file will have the same filename as the file under `build/`, with the `.scad` extension removed.

When adding new files, we need to ensure that any stl is exported in the preferred printing orientation so that the object need not be rotated in the slicer. This should include considerations of where the seam will appear on the part.

To export a different model, edit the `export_artifacts()` module in `export_config.scad` to call the model you want to export.  (Hopefully future OpenSCAD changes will let us skip this step).
