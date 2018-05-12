use <publicDomainGearV1.1.scad>;

module gear1() {
    gear(
        mm_per_tooth    = 30,    //this is the "circular pitch", the circumference of the pitch circle divided by the number of teeth
        number_of_teeth = 40,   //total number of teeth around the entire perimeter
        thickness       = 6,    //thickness of gear in mm
        hole_diameter   = 25.4/2,    //diameter of the hole in the center, in mm
        twist           = 0,    //teeth rotate this many degrees from bottom of gear to top.  360 makes the gear a screw with each thread going around once
        teeth_to_hide   = 0,    //number of teeth to delete to make this only a fraction of a circle
        pressure_angle  = 28,   //Controls how straight or bulged the tooth sides are. In degrees.
        clearance       = 0.0,  //gap between top of a tooth on one gear and bottom of valley on a meshing gear (in millimeters)
        backlash        = 0.0   //gap between two meshing teeth, in the direction along the circumference of the pitch circle
    );
}

module gear2() {
    gear(
        mm_per_tooth    = 30,    //this is the "circular pitch", the circumference of the pitch circle divided by the number of teeth
        number_of_teeth = 16,   //total number of teeth around the entire perimeter
        thickness       = 6,    //thickness of gear in mm
        hole_diameter   = 25.4/2,    //diameter of the hole in the center, in mm
        twist           = 0,    //teeth rotate this many degrees from bottom of gear to top.  360 makes the gear a screw with each thread going around once
        teeth_to_hide   = 0,    //number of teeth to delete to make this only a fraction of a circle
        pressure_angle  = 28,   //Controls how straight or bulged the tooth sides are. In degrees.
        clearance       = 0.0,  //gap between top of a tooth on one gear and bottom of valley on a meshing gear (in millimeters)
        backlash        = 0.0   //gap between two meshing teeth, in the direction along the circumference of the pitch circle
    );
}

module doit_rack() {
    rack (
        mm_per_tooth    = 30,    //this is the "circular pitch", the circumference of the pitch circle divided by the number of teeth
        number_of_teeth = 25,   //total number of teeth along the rack
        thickness       = 10,    //thickness of rack in mm (affects each tooth)
        height          = 50,   //height of rack in mm, from tooth top to far side of rack.
        pressure_angle  = 28,   //Controls how straight or bulged the tooth sides are. In degrees.
        backlash        = 0.0   //gap between two meshing teeth, in the direction along the circumference of the pitch circle
    );
}


$2d = 0;
if ($2d) {
    projection(cut=true) {
        translate([220,220,0]) {
            gear1();
            translate([260,-110,-9]) {
                rotate([0,0,0]) {
                    gear2();
                }
            }
        }
    }
} else {
    /*
    translate([0,110,0]) {
        cube([566,2,12]);
    }
    */
    translate([220,220,0]) {
        gear1();
        translate([260,-110,0]) {
            rotate([0,0,0]) {
                gear2();
            }
        }
    }
}
