
$shell_hex=30;
$shell_height=2;
$wall=4;
$wall_gap=0.25;
$base_hex_hole=20;

$end_block=0.6;

$receiver=3.3;
$peg=3.0;


module hex_cylinder(r_in, h_in) {
    r_in = r_in*1.155;
    cylinder(r=r_in, h_in, $fn=6);
}

module interlock_shell() {
    union() {
        difference() {
            hex_cylinder($shell_hex+6, $shell_height);
            hex_cylinder($shell_hex, $shell_height);
            for ($edge = [0:2]) {
                rotate([0,0,30+$edge*120]) {
                    translate([33.6,0,0]) {
                        cylinder(r=$receiver, h=90);
                    }
                    translate([33.6,-10,0]) {
                        cylinder(r=$receiver, h=90);
                    }
                     translate([33.6,10,0]) {
                        cylinder(r=$receiver, h=90);
                    }
                }
            }
        }
        for ($edge = [0:2]) {
            rotate([0,0,90+$edge*120]) {
                translate([38.5,0,0]) {
                    cylinder(r=$peg, h=$shell_height);
                }
                translate([38.5,-10,0]) {
                    cylinder(r=$peg, h=$shell_height);
                }
                 translate([38.5,10,0]) {
                    cylinder(r=$peg, h=$shell_height);
                }
            }
        }
    }
}

module shell() {
    difference() {
        hex_cylinder($shell_hex, $shell_height);
        translate([0,0,$end_block]) {
            hex_cylinder($shell_hex-$wall, $shell_height);
        }
        translate([0,0,-1]) {
            hex_cylinder($base_hex_hole, 3);
        }
    }
}


module drawer() {
    union() {
        difference() {
            hex_cylinder($shell_hex-$wall-$wall_gap, $shell_height);
            translate([0,0, $wall +0.1]) {
                hex_cylinder($shell_hex-(2*$wall)-$wall_gap, $shell_height-$wall*2);
            }
            translate([-19,-46,$wall]) {
                rotate([0,0,30]) {
                    cube([$shell_hex*1.3, 2*$shell_hex+1.3, $shell_height-2*$wall]);
                }
            }
       }
    }
    translate([5,4, $shell_height-$wall-2]) {
        rotate([0,0,-60]) {
            union () {
                hull() {
                    translate([-10,0,3]) {
                        cylinder(r=4, h=13);
                    }
                    translate([10,0,3]) {
                        cylinder(r=4, h=13);
                    }
                    translate([8,10,12]) {
                        cylinder(r=4, h=5);           
                    }
                    translate([-8,10,12]) {
                        cylinder(r=4, h=5);           
                    }
                   
                }
                hull() {
                    translate([8,10,12]) {
                        cylinder(r=4, h=5);           
                    }
                    translate([-8,10,12]) {
                        cylinder(r=4, h=5);           
                    }
                    translate([8,14,11.5]) {
                        cylinder(r=4, h=5.5);           
                    }
                    translate([-8,14,11.5]) {
                        cylinder(r=4, h=5.5);           
                    }                 
                }
            }
        }
    }
}




$shell = 1;

if ($shell) {
    shell();
    interlock_shell();
} else {
    translate([0,0,$shell_hex-$wall]) {
        rotate([-30,0,0]) {
            rotate([0,90,0]) {
                drawer();
            }
        }
    }
}

/*
rotate([0,0,30]) {
    translate([-50,0,-2]) {
        cube([100,10,5]);
    }
}
*/