// hub is radius of 27, centered on 0,0,xy plane
// get license and attribute or replace with self
// design

$fn=64;
module basic_fin() {
    translate([75,0,0]) {
        rotate([0,180,0]) {
            import("fin2.stl", convexity=3);
        }
    }
}

module basic_fin2() {
    union() {
        difference() {
            hull() {
                union() {  
                    translate([100,140,0]) {
                        cube([10,12,3]);
                    }
                    difference() {
                        translate([215,-35,0]) {
                            cylinder(r=218, h=3);
                        } 
                        translate([110, -500, -1]) {
                            cube([400, 1500, 5]);
                        }
                        translate([-40, -300, -1]) {
                            cube([200, 310, 5]);
                        }
                    }
                    translate([10,10,0]) {
                        cylinder(r=10, h=3);
                    }
                }
            }
            translate([95,152,-1]) {
                cube([20,20,5]);
            } 
            translate([104,143,-2]) {
                cylinder(r=3, h=25);
            } 
            
            translate([215,-35,-1]) {
                cylinder(r=200, h=5);
            }    
        }
        translate([15,0,0]) {
            rotate([0,0,60.5]) {
                cube([130,10,3]);
            }
        }
    }
    
}



module make_model() {
//    translate([29,57,0]) {
//        basic_fin();
//    }
    basic_fin2();
}


$flat_for_svg = 0;

if ($flat_for_svg) {
    projection(cut=true) {
        translate([0,0,0]) rotate([0,0,0]) {
            make_model();
        }
    }
} else {
    make_model();
}