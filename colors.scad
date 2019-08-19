WOODY=0;
MURDERED=1;


woody_theme = ["burlywood", "#8e6837", "#4e3807"];
murdered_theme = ["#444444", "#222222", "#666666"];
themes = [ woody_theme, murdered_theme ];

function panel_color() = themes[theme][0];
function panel_color_holes() = themes[theme][1];
function printed_part_color() = themes[theme][2];
