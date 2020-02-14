@echo off
cd /D "%~dp0"
cd "..\..\build"
SET /P model="Input model to export: "

rem create renderfile
echo // vim: set nospell: >..\make_%model%.scad
echo use ^<models_standard.scad^> >>..\make_%model%.scad
echo use ^<models_experimental.scad^> >>..\make_%model%.scad
echo use ^<models_test_ground.scad^> >>..\make_%model%.scad
echo use ^<core.scad^> >>..\make_%model%.scad
echo   %model%^(^) >>..\make_%model%.scad
echo      printer^(position = [80, 90, 30]^); >>..\make_%model%.scad

rem create export artifacts file.
echo // vim: set nospell: >export_config.scad
echo use ^<../models_standard.scad^> >>export_config.scad
echo use ^<../models_experimental.scad^> >>export_config.scad
echo use ^<../models_test_ground.scad^> >>export_config.scad
echo module export_artifacts^(^) { >>export_config.scad
echo   %model%^(^) >>export_config.scad
echo    children^(^); >>export_config.scad
echo } >>export_config.scad

mkdir ..\artifacts\%model%

REM # Command to call openscad
set OPENSCAD=openscad-nightly

echo Creating a %model%
echo Parts are created in \artifacts\%model%
echo.

REM # loop over all .dxf.scad files in build build directory
for %%f in (*.dxf.scad) do (
    echo Creating %%~nf
    "C:\Program Files\OpenSCAD\openscad.exe" -o "..\artifacts\%model%\%%~nf" "%%~nf.scad"
)

REM # loop over all .stl.scad files in build build directory
for %%f in (*.stl.scad) do (
    echo Creating %%~nf
    "C:\Program Files\OpenSCAD\openscad.exe" -o "..\artifacts\%model%\%%~nf" "%%~nf.scad"
)

REM # Command to call openscad
set OPENSCAD=openscad-nightly

REM # loop over all .stl.scad files in build directory for images
for %%f in (*.stl.scad) do (
    echo Creating %%~nf
    "C:\Program Files\OpenSCAD\openscad.exe" -o "..\artifacts\%model%\%%~nf.png" --imgsize=1920,1200 "%%~nf.scad"
)


echo A render of this build is being created in the render folder
echo.
"C:\Program Files\OpenSCAD\openscad.exe" -o "..\artifacts\%model%\render_%model%.png" --imgsize=1280,1280 "..\make_%model%.scad" > ..\artifacts\%model%\build_notes.txt 2>&1

REM Review output and press any key.
pause
