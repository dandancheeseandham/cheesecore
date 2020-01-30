@echo off
cd /D "%~dp0"
cd "..\build"

REM # Command to call openscad
set OPENSCAD=openscad-nightly

echo Creating a CheeseCore
echo A part is created and moved to the artifacts folder.
echo.

REM # loop over all .dxf.scad files in build build directory
for %%f in (*.dxf.scad) do (
    echo Creating %%~nf
    "C:\Program Files\OpenSCAD\openscad.exe" -o "%%~nf" "%%~nf.scad"
    move "%%~nf" ..\artifacts
)

REM # loop over all .stl.scad files in build build directory
for %%f in (*.stl.scad) do (
    echo Creating %%~nf
    "C:\Program Files\OpenSCAD\openscad.exe" -o "%%~nf" "%%~nf.scad"
    move "%%~nf" ..\artifacts
)

REM # Command to call openscad
set OPENSCAD=openscad-nightly

REM # loop over all .stl.scad files in build directory for images
for %%f in (*.stl.scad) do (
    echo Creating %%~nf
    "C:\Program Files\OpenSCAD\openscad.exe" -o "%%~nf.png" --imgsize=1920,1200 "%%~nf.scad"
    move "%%~nf.png" ..\renders
)

REM Review output and press any key.
pause
