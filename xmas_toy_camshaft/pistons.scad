$bit_diam = 3.175;
$valve_r = 20;
$arm_len = 130;

module piston() {
    union() {
        translate([20,10,0]) {
            rotate([0,0,-30]) {
                cylinder(r=$valve_r, h=6, $fn=3);
            }
            translate([-7/2,0,0]) {
                cube([7,$arm_len,6]);
            }
        }
    }
}

for (iter = [0:6]) {
    translate([iter*($valve_r*2+$bit_diam),0,0]) {
        piston();
    }
}


for (iter = [1:6]) {
    translate([iter*($valve_r*2+$bit_diam)+$valve_r,$arm_len + $valve_r-5,0]) {
        rotate([0,0,180]) {
            piston();
        }
    }
}

translate([0, $valve_r+$arm_len + $bit_diam-3, 0]) {
    for (iter = [0:6]) {
        translate([iter*($valve_r*2+$bit_diam),0,0]) {
            piston();
        }
    }

    for (iter = [1:6]) {
        translate([iter*($valve_r*2+$bit_diam)+$valve_r,$arm_len + $valve_r-5,0]) {
            rotate([0,0,180]) {
                piston();
            }
        }
    }
}