$inch = 25.4;

module make_it() { 
union() {
    difference() {
        cube([4*$inch, 8*$inch, $inch/8]);
        for ($yy = [0:6]) {
            for ($xx = [0:2]) {
                translate([($xx * $inch)+$inch, ($yy * $inch) + $inch, -1]) {
                    cylinder(r=$inch/16, h=$inch+2, $fn=16);
                }
            }
        }
    }
    
    translate([3.9*$inch, 2.5*$inch, 0]) {
        cube([0.7*$inch,$inch/16,$inch/8]);
    }
    translate([3.9*$inch, 5.5*$inch, 0]) {
        cube([0.7*$inch,$inch/16,$inch/8]);
    }
    
    translate([4.125*$inch, 0, 0]) {
        difference() {
            cube([3*$inch, 8*$inch, $inch/8]);
            for ($yy = [0:6]) {
                for ($xx = [0:1]) {
                    translate([($xx * $inch)+$inch, ($yy * $inch) + $inch, -1]) {
                        cylinder(r=$inch/16, h=$inch+2, $fn=16);
                    }
                }
            }
        }
    }
/*    
    translate([7.25*$inch, 0, 0]) {
        difference() {
            cube([4*$inch, 8*$inch, $inch/8]);
            for ($yy = [0:6]) {
                for ($xx = [0:2]) {
                    translate([($xx * $inch)+$inch, ($yy * $inch) + $inch, -1]) {
                        cylinder(r=$inch/16, h=$inch+2, $fn=16);
                    }
                }
            }
        }
    }
    
    translate([7*$inch, 2.5*$inch, 0]) {
        cube([0.3*$inch,$inch/16,$inch/8]);
    }
    translate([7*$inch, 5.5*$inch, 0]) {
        cube([0.3*$inch,$inch/16,$inch/8]);
    }
*/    
    translate([0, 8.125*$inch, 0]) {
        difference() {
            cube([8*$inch, 3*$inch, $inch/8]);
            for ($yy = [0:6]) {
                for ($xx = [0:1]) {
                    translate([($yy * $inch)+$inch, ($xx * $inch) + $inch, -1]) {
                        cylinder(r=$inch/16, h=$inch+2, $fn=16);
                    }
                }
            }
        }
    }

    translate([2.5*$inch, 8*$inch, 0]) {
        cube([$inch/16,0.3*$inch,$inch/8]);
    }
    translate([5.5*$inch, 8*$inch, 0]) {
        cube([$inch/16,0.3*$inch,$inch/8]);
    }    
}
}

$2d = 0;
if ($2d) {
    projection(cut=true) {
       translate([0,0,0]) rotate([0,0,0]) {
         make_it();
       }
    }
} else {
    make_it();
//  for measuring and calibrating
//    translate([60,40,0]) {
//      cube([20,5,1]);
//    }
}