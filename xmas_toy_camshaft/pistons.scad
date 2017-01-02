$bit_diam = 3.5;
$valve_r = 20;
$arm_len = 130;

module piston() {
    union() {
        translate([20,10,0]) {
            /*
            rotate([0,0,-30]) {
                cylinder(r=$valve_r, h=6, $fn=3);
            }*/
            translate([-15, 0,0]) {
                cube([30,10,6]);
            }
            translate([-7/2,0,0]) {
                cube([7,$arm_len,6]);
            }
        }
    }
}

module layout() {
    for (iter = [0:5]) {
        translate([iter*($valve_r*2+$bit_diam+1),0,0]) {
            piston();
        }
    }   
    
    for (iter = [1:5]) {
        translate([iter*($valve_r*2+$bit_diam)+$valve_r,$arm_len + $valve_r,0]) {
            rotate([0,0,180]) {
                piston();
            }
        }
    }
    
    translate([0, $valve_r+$arm_len + $bit_diam-3, 0]) {
        for (iter = [0:5]) {
            translate([iter*($valve_r*2+$bit_diam+1),0,0]) {
                piston();
            }
        }
    
        for (iter = [1:5]) {
            translate([iter*($valve_r*2+$bit_diam)+$valve_r,$arm_len + $valve_r,0]) {
                rotate([0,0,180]) {
                    piston();
                }
            }
        }
    }
}

$2d = 0;
if ($2d) {
    projection(cut=true) {
       translate([0,0,0]) rotate([0,0,0]) {
           layout();
       }
    }
} else {
    layout();
}


