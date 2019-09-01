WOODY=0;
MURDERED=1;

woody_theme = ["burlywood", "#8e6837", "#222222", "#777777", "#C0C0C0" , "#555"];
murdered_theme = ["#444444", "#222222", "#666666", "#777777", "#C0C0C0", "#555" ];
themes = [ woody_theme, murdered_theme ];

function panel_color() = themes[theme][0];
function panel_color_holes() = themes[theme][1];
function printed_part_color() = themes[theme][2];
function alum_part_color() = themes[theme][3];  // abbreviated "aluminium" to stop UK/US spelling mistakes.
function alum_commercial_part_color() = themes[theme][4];  // abbreviated "aluminium" to stop UK/US spelling mistakes.
function electronics_box_acrylic_color() = themes[theme][5];