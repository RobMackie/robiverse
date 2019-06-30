
module parts() {
    translate([40,100,5]) {
        // The actuating handle lever
        rotate([90,90,0]) {
            import("/home/rmackie/Desktop/toggle_clamp/files/HANDLE_rev00-02.stl");
        }
    }
    
    translate([-10, 150,0]) {
        // the press down lever
        rotate([90,90,0]) {
            import("/home/rmackie/Desktop/toggle_clamp/files/ARM_rev00-02.stl");
        }
    }
    
    translate([50,150, 6]) {
        // base unit
        rotate([90,90,0]) {
            import("/home/rmackie/Desktop/toggle_clamp/files/BASE_rev00-02.stl");
        }
    }
    
    translate([30,50,0]) {
        // little thing w/ 2 holes
        rotate([90,90,0]) {
            import("/home/rmackie/Desktop/toggle_clamp/files/LINK_rev00-02.stl");
        }
    }
    
    translate([0,-120,0]) {
        rotate([0,0,0]) {
            import("/home/rmackie/Desktop/toggle_clamp/files/BEARING_rev00-02.stl");
        }
    }
    
    translate([0, -100,0]) {
        rotate([0,0,0]) {
            import("/home/rmackie/Desktop/toggle_clamp/files/RUBBER_STAND_rev00.stl");
        }
    }
}
module profiles() {
    difference() {
        parts();
        translate([0,0,-40]) {
            cube([300,300,40]);
        }
    }
}

$flat_for_svg = 1;
if ($flat_for_svg) {
    projection(cut=true) {
        translate([0,0,-0.5]) rotate([0,0,0]) {
            profiles();
        }
    }
} else {
    profiles();
}

difference() {
    parts();
    translate([0,0,-40]) {
        cube([300,300,40]);
    }
}
