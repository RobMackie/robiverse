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

module curve1() {
    rotate([0,0,-80]) {    
        difference() {
            cylinder(r=55, h=3);
            translate([14,14,-1]) {
                cylinder(r=65, h=5);
            }
        }
    }
}
module curve2() {
    rotate([0,0,-80]) {
        difference() {
            translate([2,0,0]) {
                cylinder(r=80, h=3);
            }
            translate([10,10,-1]) {
                cylinder(r=90, h=5);
            }
        }   
    }
}

module basic_fin_1() {
    difference() {
        hull() {
            translate([65,83,0]) {
                cube([10,14,3]);
            }
            translate([80,22,0]) {
                curve2();
            }
            translate([5,5,0]) {
                cylinder(r=5, h=3);
            }
        }
        translate([90,4,-1]) {
            cylinder(r=80, h=5, $fn=64);
        }
    }
}

module make_model() {
    difference() {

        basic_fin_1();
        translate([68.5,89,-2]) {
            cylinder(r=3, h=25);
        }
        //basic_fin();
    }
    translate([0,85,0]) {
        //cube([75, 5,5]);
    }
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