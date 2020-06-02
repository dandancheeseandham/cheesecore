@echo off
cd /D "%~dp0"
cd "..\..\build"

for /F "tokens=*" %%A in (..\artifacts\scripts\standard_models.txt) do (

echo %%A
rem create renderfile
echo // vim: set nospell: >..\make_%%A.scad
echo use ^<models_standard.scad^> >>..\make_%%A.scad
echo use ^<core.scad^> >>..\make_%%A.scad
echo   %%A^(^) >>..\make_%%A.scad
echo      printer^(position = [80, 90, 30]^); >>..\make_%%A.scad

rem create export artifacts file.
echo // vim: set nospell: >export_config.scad
echo use ^<../models_standard.scad^> >>export_config.scad
echo module export_artifacts^(^) { >>export_config.scad
echo   %%A^(^) >>export_config.scad
echo    children^(^); >>export_config.scad
echo } >>export_config.scad

mkdir ..\artifacts\%%A

REM # Command to call openscad
set OPENSCAD=openscad-nightly

echo Creating a %%A
echo Parts are created in \artifacts\%%A
echo.

REM # loop over all .dxf.scad files in build build directory
for %%f in (*.dxf.scad) do (
    echo Creating %%~nf
    "C:\Program Files\OpenSCAD\openscad.exe" -o "..\artifacts\%%A\%%~nf" "%%~nf.scad"
)

REM # loop over all .stl.scad files in build build directory
for %%f in (*.stl.scad) do (
    echo Creating %%~nf
    "C:\Program Files\OpenSCAD\openscad.exe" -o "..\artifacts\%%A\%%~nf" "%%~nf.scad"
)

REM # Command to call openscad
set OPENSCAD=openscad-nightly

REM # loop over all .stl.scad files in build directory for images
for %%f in (*.stl.scad) do (
    echo Creating %%~nf
    "C:\Program Files\OpenSCAD\openscad.exe" -o "..\artifacts\%%A\%%~nf.png" --imgsize=1920,1200 "%%~nf.scad"
)


echo A render of this build is being created in the render folder
echo.
"C:\Program Files\OpenSCAD\openscad.exe" -o "..\artifacts\%%A\render_%%A.png" --imgsize=1280,1280 "..\make_%%A.scad" > ..\artifacts\%%A\build_notes.txt 2>&1
)
