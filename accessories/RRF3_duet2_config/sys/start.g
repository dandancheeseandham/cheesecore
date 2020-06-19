G29 S1    ; (temp fix) enable mesh compensation while bed is not completely level
if heat.heaters[1].state == "Active"
  T0
  M703

if heat.heaters[1].state == "Off" || heat.heaters[1].state == "Standby"
  T0        ; select T0
  M703      ; load current filament config
  M144      ; put bed into standby mode
  T-1       ; unselect tool to put it into standby temperature.

M116      ; wait for temperatures to reach their targets
M98 P"/sys/probe/truelevel_fast_rrf3.g"  ; home and probe bed, only if needed otherwise it skips.
T0
M703
M116  ; wait for temperatures to reach their targets