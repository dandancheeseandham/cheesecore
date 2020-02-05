// vim: set nospell:

module report() {
  echo ("*================================================*");
  echo ("BRANDING NAME: " , $branding_name);
  echo ("Extrusion width:", extrusion_width());
  echo ("Extrusion _screw_size:", extrusion_screw_size());
  echo ("Frame total dimensions: " , frame_size());
  echo ("Extrusions only dimensions: " , frame_size() - [extrusion_width()*2,extrusion_width()*2,extrusion_width()*2]);
  echo ("Halo dimensions: " , halo_size());
  echo ("Top Enclosure total dimensions: ", enclosure_size());
  echo ("Top Enclosure extrusion dimensions: ", enclosure_size() - [extrusion_width()*2,extrusion_width()*2,extrusion_width()*2]);
  echo ("bottom panel in core:",frame_size().x, frame_size().y);
  echo ("------------------------------------------");
  echo ("Leadscrew length: ",leadscrew_length());
  echo ("Leadscrew diameter: ",leadscrew_diameter());
  echo ("Rail lengths",rail_lengths());
  *echo ("Rail profiles",rail_profiles()); //LONG! Only run if necessary.
  echo ("------------------------------------------");
  echo ("NEMAtypeXY() :",NEMAtypeXY());
  echo ("NEMAtypeZ() :",NEMAtypeZ());
  echo ("------------------------------------------");
  echo ("bed_plate_size() :", bed_plate_size() );
  echo ("bed_ear_spacing() :", bed_ear_spacing() );
  echo ("bed_overall_size() :", bed_overall_size() );
  echo ("bed_thickness() :", bed_thickness() );
  echo ("------------------------------------------");
  echo ("ELECTRONICS BOX");
  echo ("box_size_y() :",  box_size_y() );
  echo ("box_size_z() :", box_size_z() );
  echo ("box_depth() ) :", box_depth() );
  echo ("------------------------------------------");
  echo ("PANELS");
  echo ("$panels[1]: ",$panels[1]);
  echo ("side_panel_thickness(): ",side_panel_thickness() );
  echo ("$panels: ",$panels);
  echo ("max_panel_screw_spacing(): ",max_panel_screw_spacing());
  echo ("frame_size().x : ",frame_size().x );
  echo ("panel_screw_offset(): ",panel_screw_offset());
  echo ("panel_screw_spacing(frame_size().x): ",panel_screw_spacing(frame_size().x));
  echo ("panel_screw_spacing(frame_size().y): ",panel_screw_spacing(frame_size().y));
  echo ("panel_screw_spacing(frame_size().z): ",panel_screw_spacing(frame_size().z));
  echo ("max_panel_screw_spacing(): ",max_panel_screw_spacing());
  echo ("acrylic_door_thickness(): ",acrylic_door_thickness());
  echo ("extend_front_and_rear_x() : ",extend_front_and_rear_x());
  echo ("extend_bottom_panel_x() : ",extend_bottom_panel_x());
  echo ("extendz() : ",extendz());
  echo ("------------------------------------------");
  echo ("");
}
