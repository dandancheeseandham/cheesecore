# cheesecore - a RailCore II inspired build by cheeseandham

This OpenSCAD program has been made by cheeseandham and while there are two settings (ZL & ZLT) that endevour to emulate and be fully compatible with the RailCore II, it is **not a RailCore II and mixing with a RailCore II is at your own risk**. 

Because of this **please do not** direct questions about this OpenSCAD code or its models or parts to Tony Akens or J.Steve White. Discuss with Dan White on Facebook or cheeseandham on Discord.

## Initial Goals

Make a RailCore2-inspired OpenSCAD generator that includes as standard:- 
 * doors
 * halo
 * enclosure

can change parameters such as:-
 * frame size (height,width,length) and panel/door thickness
 * extrusion size
 * rail length and profile (e.g. MGN15)
 * lead screw width
 * front window size
 * electronic box size and electronics placement.
 * NEMA type (e.g. 17 or 23)

Where possible we stay within the RailCore ecosystem in regards to:-
 * Y carriage (i.e.12mm rail on the Y)
 * Bed (i.e. make any redesign RC2 compatible)
 * Keeping 8mm leadscrews and 12mm rails also can help.
In order to take advantage of existing parts. However these parameters may also be changed - it should be understood that this especially will break compatibility with current machined parts.


### Secondary Goals

1. Adding a RPi as standard, for additional functionality.
 * Bossa for emergency Duet flashing
 * USB and Octoprint (extra features and the ability to communicate with the Duet with a network issue)
 * Extra hardware that a Duet can't support.
 * Automated backups and a simple restore procedure.

2. Include a "advanced user" Duet config and setup.

3. The ability to make modifications and improve the design where appropriate.
The base RailCore design should always be available, and options can be switched on and off as required.

4. Minimize printed part content - metals behave more predictably, espeicially at higher temperatures.

5. Safety - Add software and hardware means (such as TCO's)

6. Aid and ease assembly - anything that can reduce issues in getting it printing reliably. Such as additional parts to ensure squareness of extrusion and rails.

## To use

Some OpenSCAD experience is useful, but if you're comfortable with code in general you should be OK.

 * open a "make*.scad" file to open a whole model.
 * All variables are held in config.scad
 * Theming held in colors.scad and set in prefs.scad
 * Configurations for models are held in models_standard.scad and models_experimentals.scad
 * to play with a whole model, use make_customcore.scad and edit the variables in models_experimental.scad and config.scad regarding the custom model and open with make_customcore.scad
 * core.scad is called to render the model, so you can easily omit parts by using a * to stop it being rendered.
 * If you open any individual scad part, it will render as per settings in demo.scad
 * use the scripts in the scripts folder to export the model specified in build/export_config.scad - this will dump dxfs, stls and renders into the artifacts and renders folders. (any files in artifacts and renders may be deleted as they are easily recreated)
 * hotend is not part of the model yet. It assumes a 12mm rail on Y and RailCore hotend ecosystem at this time.
 * currently halo is not fully parametric , and can be modified more at the end of side_panels.scad - to be fixed.
 * top enclosure is not finished.
