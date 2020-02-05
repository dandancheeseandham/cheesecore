// vim: set nospell:
use <core.scad>

// derbycore - designed for A.Derbyshire from spare parts, 300*220 Creality CR-10 Mini bed size
module derbycore(position = [50, 50, 0]) {
//                            name       sizeXY   depth thick
$front_window_size  = ["WINDOW_TYPE", [320, 285], 10, [0, 5]];
$extrusion_type     = extrusion20;
$NEMA_XY            = NEMA17;
$NEMA_Z             = NEMA17;
//                    sizeX sizeY sizeZ
$frame_size         = [360, 425, 315] + [40,40,40];
//                    sizeX  Xtype  sizeY  Ytype    sizeZ Ztype
$rail_specs         = [[300, MGN9], [400, MGN12], [300, MGN9]];
//                     Name           height diameter
$leadscrew_specs    = ["LEADSCREW_SPECS", 330,  8];
//                      name  bed_plate_size   motor space  bed_overall_size  bed thickness
$bed                = ["BED", [245, 342],      255,        [255+10, 242],        0.25 * inch];

// ELECTRONICS BOX ALONG WITH  & ELECTRONICS & CABLE PLACEMENT -  placement of parts on right panel with X/Y as centre
//                    name       sizeX  sizeY  depth thick, lasercut cable_bundle    DuetE            Duex              PSU        SSR              RPi
$elecbox            = ["ELEC.BOX", 300, 260, 59 ,   6,     true,   [-84,126.5,0], [-84.82,50.5,0], [-84.82,-59.5,0], [60,00,0],  [145,50,0] , [-90,-140,0]] ;
$branding_name      = "DerbyCore";
$enclosure_size     = [360, 425, 315] + [40,40,40] + [150, side_panel_thickness() * 2, -150];
$panels             = panel_rc300zlt;
$halo_size          = [400 + 150, 465 + side_panel_thickness() * 2, 4];
$feet_depth         = 50 ;
children();
}

derbycore()
  printer(position = [130, 120, 50]);
