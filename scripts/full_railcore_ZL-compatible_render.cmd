@echo off
cd /D "%~dp0"
cd "..\build"

echo A render of this build is being created in the render folder
echo.
"C:\Program Files\OpenSCAD\openscad.exe" -o "..\renders\railcore_300zl_compatible.png" --imgsize=1280,1280 "..\make_railcore300zl_compatible.scad"

pause