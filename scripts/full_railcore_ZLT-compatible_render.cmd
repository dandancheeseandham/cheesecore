@echo off
cd /D "%~dp0"
cd "..\build"

echo A render of this build is being created in the render folder
echo.
"C:\Program Files\OpenSCAD\openscad.exe" -o "..\renders\railcore_300zlt.png" --imgsize=1280,1280 "..\make_railcore300zlt_compatible.scad" > ..\artifacts\build_notes.txt 2>&1