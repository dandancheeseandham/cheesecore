@echo off
cd /D "%~dp0"
cd "..\build"

echo A render of this build is being created in the render folder
echo.
"C:\Program Files\OpenSCAD\openscad.exe" -o "..\renders\2020_cheesecore.png" --imgsize=1280,1280 "..\make_2020_cheesecore.scad"

pause