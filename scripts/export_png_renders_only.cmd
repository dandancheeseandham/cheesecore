@echo off
cd /D "%~dp0"
cd "..\build"

REM # Command to call openscad
set OPENSCAD=openscad-nightly

echo Creating pngs
echo A render is created and moved to the renders folder.
echo.

REM # loop over all .stl.scad files in build directory for images
for %%f in (*.stl.scad) do (
    echo Creating %%~nf
    "C:\Program Files\OpenSCAD\openscad.exe" -o "%%~nf.png" --imgsize=1000,620 "%%~nf.scad"
    move "%%~nf.png" ..\renders
)
pause
