// vim: set nospell:
WOODY=0;
MURDERED=1;

//woody_theme = ["#999999", "#555555", "DarkRed", "#777777", "#C0C0C0" , [0.1, 0.1, 0.1, 0.9], [0.6, 0.6, 0.6, 0.7] ];
woody_theme = ["#9c9396", "#555555", "#883329", "#777777", "#C0C0C0" , [0.1, 0.1, 0.1, 0.9], [0.84, 0.97, 0.99, 0.4] , "#e7c7a1" ];
//woody_theme = ["#999999", "#555555", "DarkRed", "#777777", "#C0C0C0" , [0.1, 0.1, 0.1, 0.9], [1, 0.6, 0.6, 0.5] ];
murdered_theme = ["#444444", "#222222", "#666666", "#777777", "#C0C0C0", [0.7, 0.7, 0.7, 0.2], [0.7, 0.7, 0.7, 0.2] , "#e7c7a1"];
themes = [woody_theme, murdered_theme];

function panel_color()                = themes[theme][0];
function panel_color_holes()          = themes[theme][1];
function printed_part_color()         = themes[theme][2];
function alum_part_color()            = themes[theme][3];  // abbreviated "aluminium" to stop UK/US spelling mistakes.
function alum_commercial_part_color() = themes[theme][4];  // abbreviated "aluminium" to stop UK/US spelling mistakes.
function acrylic_color()              = themes[theme][5];
function acrylic2_color()             = themes[theme][6];
function spool_color()                = themes[theme][7];
