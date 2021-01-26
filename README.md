![Image of cheesecore](https://raw.githubusercontent.com/dandancheeseandham/cheesecore/master/image.png)

# cheesecore - a RailCore II inspired build

This OpenSCAD program has been developed to emulate, and be fully compatible with the RailCore II, but to extend it with parametric functionality. 
While it should be fully compatiable, please note that it is **not a RailCore II**. Because of this **please do not** direct questions about this OpenSCAD code or its models or parts to Tony Akens or J.Steve White. Please discuss with Dan White on Facebook, or idealy cheeseandham on the RailCore Discord.

If you stick with 12mm rails, everything should be fully compatible, but to protect myself I will say **mixing this design with a RailCore II is at your own risk**. 

cheesecore has been developed by cheeseandham / Dan White.

## Initial Goals

To make a RailCore2-compatible parametric OpenSCAD model that includes as standard:- 
 * doors
 * halo
 * top enclosure

The parametrics are to be able to change parameters such as:-
 * frame size (height,width,length) and panel/door thickness
 * extrusion size 
 * rail length and profile (on Z especially) e.g. MGN15
 * lead screw width
 * front window size 
 * electronic box size and electronics placement
 * NEMA stepper motor type (e.g. 17 or 23)

Where possible we stay within the RailCore ecosystem in regards to:-
 * Y carriage - keep 12mm rail on the Y (highest priority)
 * Bed - bed is modifiable
 * Keeping 8mm leadscrews and 12mm rails on Z. This is modifiable.
 
In order to take advantage of existing parts. However these parameters may also be changed - it should be understood that this especially will break compatibility with current machined parts.

## To Do
 * allow >4040 extrusion e.g. 3060 as well as ensuring all screwholes for extrusions are changed.
 * develop main parts of the hotend ecosystem.
 * export a BOM from cheesecore.
 * tidy and optimise the model and code.

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
 * core.scad is called to render the model, so you can easily omit parts by using a * to stop it being rendered by editing core.scad/
 * If you open any individual scad part, it will render as per the model in demo.scad , and therefore settings for it in the configuations (models_standard.scad and models_experimentals.scad) (if a individual file contains many parts, you can change its behaviour via editting the demo modile in this part.
 * use the scripts in the build/scripts folder to export the models - this will dump dxfs, stls and renders into the artifacts and renders folders. (any files in artifacts and renders may be deleted as they are easily recreated)
 * hotend is not part of the model yet. It assumes a 12mm rail on Y and RailCore hotend ecosystem at this time.
 * in the build directory are the files to export individual parts.
 * to export all parts, or all parts for all models, just run the appropriate script in build/scripts for your operating system (.cmd for windows, and .sh for mac/linux).
