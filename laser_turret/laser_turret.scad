// a laser turrent using 2 servos
    $serv_h = 43;
    $serv_l = 40;
    $serv_w = 19;
    $tab_drop = 4;
    $tab_l = 8;
    $tab_hole_d = 8;
    $tab_h = 3;
    $tab_offset = 3.5;
    $spline_d = 4;
    $spline_h = 3;
    $horn_d = 30;
    $horn_h = 3;

module servo_model() {
    union() {
        // this difference it the tab plate
        difference() {
            translate([0,0,$serv_h-$tab_h-$tab_drop]) {
                cube([$serv_l+2*$tab_l, $serv_w, $tab_h]);
            }
            translate([$tab_offset,$serv_w/2,$serv_h - ($tab_h + 1)-$tab_drop]) {
                cylinder(d=$tab_hole_d, h=$tab_h+2);
            }
            translate([$serv_l+2*$tab_l-$tab_offset,$serv_w/2,$serv_h - ($tab_h + 1)-$tab_drop]) {
                cylinder(d=$tab_hole_d, h=$tab_h+2);
            }
        }
        // this is the body of the servo
        translate([$tab_l,0,0]) {
            cube([$serv_l, $serv_w, $serv_h]);
        }
        // This is the spline shaft
        translate([$tab_l+$serv_l/2,$serv_w/2,$serv_h]) {
            cylinder(d=$spline_d, h=$spline_h, $fn=32);
        }
        // this is the servo horn (round)
        translate([$tab_l+$serv_l/2,$serv_w/2,$serv_h+$spline_h]) {
            cylinder(d=$horn_d, h=$horn_h, $fn=32);
        }        
    }
    
}

module base_stand() {
    $bs_l = 100;
    $bs_w = 90;
    $bs_h = 4;
    $bs_wall = 3;
    $bs_out_l = $serv_l+$bs_wall*2;
    $bs_out_w = $serv_w+$bs_wall*2;
    $bs_wall_h = 9;
    $bs_floor = 1;
    union() {
        cube([$bs_l,$bs_w,$bs_h]);
        translate([($bs_l-$bs_out_l)/2+0.1*$bs_l,($bs_w-$bs_out_w)/2,$bs_h]) {
            difference() {
                cube([$bs_out_l, $bs_out_w, 9]);
                translate([$bs_wall,$bs_wall,1]) {
                    cube([$serv_l,$serv_w,$bs_wall_h+1]);
                }
            }
        }
    }
}

module upper_landing() {
    
}

module laser_mount() {
    
}

module laser() {
}


module assembled_unit() {
    translate([0,0,0]) {
        rotate([0,0,0]) {
            base_stand();
        }
    }
    translate([0,0,0]) {
        rotate([0,0,0]) {
            // servo_model();
        }
    }
    translate([0,0,0]) {
        rotate([0,0,0]) {
            upper_landing();
        }
    }
    translate([0,0,0]) {
        rotate([0,0,0]) {
            //servo_model();
        }
    }    
    translate([0,0,0]) {
        rotate([0,0,0]) {
            laser_mount();
        }
    }
    translate([0,0,0]) {
        rotate([0,0,0]) {
            laser();
        }
    }
/*
    translate([0,0,0]) {
        rotate([0,0,0]) {
        }
    }
*/ 
}

module flat_pack_parts() {
    
    
}


if ($flat_pack) {
    translate([0,0,0]) {
        flat_pack_parts();
    }
} else {
    translate([0,0,0]) {
        assembled_unit();
    }
}