// vim: set nospell:
use <models_experimental.scad>
use <core.scad>
$vpt=[0,0,0];
$vpr=[45,0,30];
$vpd= 3000;
2020core(position = [80, 90, 30])
  translate($vpt) printer();
