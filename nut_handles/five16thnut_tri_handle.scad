/*
 * 5/16" bolt or nut handle
 */

// this puts the disk in the top
$snapfit = 1;

$inch = 25.4;

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
        translate([0,0,16.2]) {
            cylinder(d=1.125*$inch, h=10, $fn=64);
        }
        // hex head
        translate([0,0,8]) {
            cylinder(d=14.67, h=9, $fn=6);
        }
        // ease the edges of the hex hole
        translate([0,0,12.7]) {
            cylinder(d1=12, d2=19, h=5, $fn=6);
        }
        // bolt thru hole
        translate([0,0,-1]) {
            cylinder(d=(5/16*$inch+0.1), h=31, $fn=64);
        }
    }
}

translate([25,0,0]) {
    union() {
        top_body();
        bolt_chassis(23);
    }
}
if ($snapfit) {
    translate([25,0,18.2]) {
        color([1,1,0]) cylinder(r=14,h=5,$fn=128);   
    }
}