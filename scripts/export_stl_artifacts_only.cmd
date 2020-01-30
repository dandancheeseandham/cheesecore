@echo off
cd /D "%~dp0"
cd "..\build"

REM # Command to call openscad
set OPENSCAD=openscad-nightly

echo Creating a CheeseCore
echo A part is created and moved to the artifacts folder.
echo.

REM # loop over all .stl.scad files in build build directory
for %%f in (*.stl.scad) do (
    echo Creating %%~nf
    "C:\Program Files\OpenSCAD\openscad.exe" -o "%%~nf" "%%~nf.scad"
    move "%%~nf" ..\artifacts
)

REM Review output and press any key.
pause
