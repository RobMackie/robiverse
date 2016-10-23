

$fa=1;
$fs=1;

module cup_on_pegs() {
    translate([0,0,0]) {
        difference() {
            union() {
                cylinder(r=40, h=50);
                translate([0,70,40]) {
                    rotate([90,0,0]){
                        cylinder(r=5, h=140);
                    }
                }
            }
            translate([-35,-35,5]) {
                cube([70, 70, 48]);
            }
        }
    }
}

module big_cup_on_pegs() {
    translate([0, 0, -20]) {
        rotate([0,0,90]) {
           scale(1.5) {
              cup_on_pegs();
           } 
        }
    }
}

module build_it() {
    difference() {
        big_cup_on_pegs();
        translate([0,70,40]) {
            rotate([90,0,0]){
                cylinder(r=7, h=140);
            }
        }
    }
    cup_on_pegs();
}

build_it();