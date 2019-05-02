$inch = 25.4;

$top = 0;

module bolt_chassis(height) {
    difference() {
        //cylinder(d=2*$inch, h=height, $fn=64);
        hull() {
            for (nub = [0:2]) {
                rotate(nub*120, [0,0,1]) {
                    translate([2*$inch / 2, 0,0]) {
                        cylinder(d=0.5*$inch, h=height, $fn=64);
                    }
                }
            }            
        }
        cylinder(d=1.35*$inch, h=height, $fn=64);
        for (bolthole = [0:2]) {
            rotate(bolthole*120, [0,0,1]) {
                translate([2*$inch / 2, 0,-1]) {
                    cylinder(d=1/4*$inch, h=height+2, $fn=64);
                }
            }
        }
    }
}

module top_body() {
    difference() {
        translate([0,0,0]) {
            cylinder(d=1.35*$inch, h=23, $fn=64);
        }
        translate([0,0,15]) {
            cylinder(d=1.125*$inch, h=8, $fn=64);
        }
        // hex head
        translate([0,0,8]) {
            cylinder(d=(7/16*$inch)+0.5, h=8, $fn=6);
        }
        // ease the edges of the hex hole
        translate([0,0,11.5]) {
            cylinder(d1=0.3*$inch, d2=0.6*$inch, h=5, $fn=6);
        }
        // bolt thru hole
        translate([0,0,-1]) {
            cylinder(d=(1/4*$inch), h=31, $fn=64);
        }
    }
}

module bottom_body() {
    difference() {
        translate([0,0,0]) {
            cylinder(d=1.35*$inch, h=11, $fn=64);
        }
        translate([0,0,3]) {
            cylinder(d=1.125*$inch, h=8, $fn=64);
        }
        // bottom thru hole for knife mount
        translate([0,0,-1]) {
            cylinder(d=22, h=13, $fn=64);
        }
    }
}

if ($top) {
    translate([25,0,0]) {
        union() {
            top_body();
            bolt_chassis(23);
        }
    }
} else {
    translate([25,0,0]) {
        union() {
            bottom_body();
            bolt_chassis(11);
        }
    }
}