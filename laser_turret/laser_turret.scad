// a laser turrent using 2 servos

$fn = 32;
  // serv - servo
    $serv_h = 43;
    $serv_l = 41.2;
    $serv_w = 20.8;
    $tab_drop = 4;
    $tab_l = 7;
    $tab_hole_d = 4;
    $tab_h = 3;
    $tab_offset = 1.5;
    $spline_d = 6;
    $spline_h = 3;
    $horn_d = 21;
    $horn_h = 3;
    
  // bs - base stand
    $bs_l = 110;
    $bs_w = 110;
    $bs_h = 4;
    $bs_wall = 3;
    $bs_out_l = $serv_l+$bs_wall*2;
    $bs_out_w = $serv_w+$bs_wall*2;
    $bs_wall_h = 10;
    $bs_floor = 1;
    $bs_leg_l = 40;
    
  // ul - upper landing
    $ul_d = $bs_w*1.2;
    $ul_h = 6;

module servo_model() {
    union() {
        // this difference it the tab plate
        difference() {
            translate([0,0,$serv_h-$tab_h-$tab_drop]) {
                cube([$serv_l+2*$tab_l, $serv_w, $tab_h]);
            }
            // close plate holes
            translate([$tab_offset,$serv_w/4,$serv_h - ($tab_h + 1)-$tab_drop]) {
                cylinder(d=$tab_hole_d, h=$tab_h+2);
            }
            translate([$tab_offset,$serv_w*3/4,$serv_h - ($tab_h + 1)-$tab_drop]) {
                cylinder(d=$tab_hole_d, h=$tab_h+2);
            } 
           // far plate holes
            translate([$serv_l+2*$tab_l-$tab_offset,$serv_w/4,$serv_h - ($tab_h + 1)-$tab_drop]) {
                cylinder(d=$tab_hole_d, h=$tab_h+2);
            }
            translate([$serv_l+2*$tab_l-$tab_offset,$serv_w*3/4,$serv_h - ($tab_h + 1)-$tab_drop]) {
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
        // wire channel
        translate([$serv_l + 6.9,$serv_w/2-7/2,0]) {
            rotate([0,0,0]) {
                cube([10,7,40]);
            }
        }
    }
    
}

$leg_w = 20;
module leg() {
    difference() {
        cube([$leg_w,$leg_w,$bs_leg_l]);
        translate([$leg_w/2,$leg_w/2,-$bs_leg_l+2]) {
            cylinder(d=2.9, h=$bs_leg_l*3);
        }
    }
}

module base_stand() {
    difference() {
        union() {
            cube([$bs_l,$bs_w,$bs_h]);
            /*
            translate([0,0,-40]) {
                cube([$bs_l,$bs_w,$bs_h]);
            }
            */
            translate([($bs_l-$bs_out_l)/2,($bs_w-$bs_out_w)/2,-$bs_h*4]) {
                    cube([$bs_out_l, $bs_out_w, $bs_wall_h*2]);
                }
            // leg 1
            translate([0,0,-$bs_leg_l]) {
                leg();
                translate([$leg_w/2,$leg_w/2,-$bs_leg_l+2]) {
                    cylinder(d=2.9, h=$bs_leg_l*3);
                }
            }
            // leg 2
            translate([0,$bs_w-$leg_w,-$bs_leg_l]) {
                leg();
            }
            // leg 3
            translate([$bs_w-$leg_w,$bs_w-$leg_w,-$bs_leg_l]) {
                leg();
            }
            // leg 4
            translate([$bs_w-$leg_w,0,-$bs_leg_l]) {
                leg();
            }            
        }
        // leg 1 hole
        translate([0,0,-$bs_leg_l]) {
            translate([$leg_w/2,$leg_w/2,-$bs_leg_l+2]) {
                cylinder(d=2.9, h=$bs_leg_l*3);
            }
        }   
        // leg 2 hole
        translate([0,$bs_w-$leg_w,-$bs_leg_l]) {
            translate([$leg_w/2,$leg_w/2,-$bs_leg_l+2]) {
                cylinder(d=2.9, h=$bs_leg_l*3);
            }
        }  
        // leg 3 hole 
        translate([$bs_w-$leg_w,$bs_w-$leg_w,-$bs_leg_l]) {
            translate([$leg_w/2,$leg_w/2,-$bs_leg_l+2]) {
                cylinder(d=2.9, h=$bs_leg_l*3);
            }
        }
        // leg 4
        translate([$bs_w-$leg_w,0,-$bs_leg_l]) {
            translate([$leg_w/2,$leg_w/2,-$bs_leg_l+2]) {
                cylinder(d=2.9, h=$bs_leg_l*3);
            }
        }         
        translate([($bs_l-$bs_out_l)/2-$bs_wall-1.5,($bs_w-$bs_out_w)/2+$bs_wall,-$bs_h-13]) {
            rotate([0,0,0]) {
                servo_model();
            }
           // cube([$serv_l,$serv_w,$bs_wall_h*2+2+5]);
        }
    }
}

$ul_low_w = 60;
$ul_wall_thick=10;
$ul_wall_h = 80;
module upper_landing() {
    union() {
        // disk with hollow for horn
        difference() {
            translate([-$serv_w,-$bs_l/3,0]) {
                cube([$serv_w*2, $ul_low_w, $ul_h]);
            }
            translate([0,0,0]) {
                cylinder(d=$horn_d, h=$horn_h);
            }
        }
        // wall to mount servo
        difference() {
            translate([-($serv_w),-39,0]) {
                cube([$serv_w*2,$ul_wall_thick,$ul_wall_h]);
            }
            translate([10,-65,72]) {
                rotate([-90,90,0]) {
                    servo_model();
                }
            }
        }
    }
}

module laser_mount() { 
    difference() {
        union() {
            difference() {
                cube([70,15,20]);
                translate([-1,17,10]) {
                    rotate([0,90,0]) {
                        cylinder(d=15, h=80);
                    }
                }
            }
            translate([70/2,$horn_h,$horn_d/2]) {
                rotate([90,0,0]) {
                    cylinder(d=$horn_d*1.5, h=$horn_h*2);
                }
            }
        }
        translate([70/2,0,$horn_d/2]) {
            rotate([90,0,0]) {
                cylinder(d=$horn_d, h=$horn_h+1);
            }
        }
    }
}

module laser_mount_alt() { 
    difference() {
        
        union() {
            difference() {
                // main body with disk
                translate([20,0,0.5]) {
                    cube([30,15,20]);
                } 
                translate([-1,9,10.5]) {
                    rotate([0,90,0]) {
                        cylinder(d=6.1, h=80, $fn=64);
                    }
                }
            }
            // socket subtracted
            translate([70/2,$horn_h,$horn_d/2]) {
                rotate([90,0,0]) {
                    cylinder(d=$horn_d*1.5, h=$horn_h*2, $fn=64);
                }
            }
        }
        // socket
        translate([70/2,0,$horn_d/2]) {
            rotate([90,0,0]) {
                cylinder(d=$horn_d, h=$horn_h+1, $fn=64);
            }
        }
        translate([20,4,-2.5]) {
            cube([24,15,25]);
               /* y , z, x */
        }
    }
}

module laser() {
    rotate([0,90,0]) {
        color("blue") cylinder(d=15, h=120);
        translate([0,0,-500]) {
            color("violet") cylinder(d=1, h=500);
        }
    }
}


module assembled_unit() {
    translate([50,40,40]) {
       // color("blue") cube([10,10,51]);
    }
    translate([0,0,40]) {
        rotate([0,0,0]) {
            base_stand();
        }
    }
    translate([($bs_l-$bs_out_l)/2+$bs_wall-$tab_l,($bs_w-$bs_out_w)/2+$bs_wall,8]) {
        rotate([0,0,0]) {
            color("red") servo_model();
        }
    }
    translate([$bs_l/2,$bs_w/2,55]) { //51
        rotate([0,0,0]) {
            upper_landing();
        }
    }
    translate([65,-10,127]) {
        rotate([-90,90,0]) {
          color("red") servo_model();
        }
    }    
    translate([20,40,89]) {
        rotate([0,0,0]) {
            laser_mount();
        }
    }
    translate([0,55,99]) {
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

    translate([0,0,0]) {
        rotate([0,0,0]) {
        }
    }
    if (1) {
        translate([$bs_l,0,$bs_h]) {
            rotate([0,180,0]) {
                base_stand();
            }
        }
    }
    if (0) {
        translate([30,$ul_wall_h+$ul_d,$ul_low_w/2+$ul_wall_thick]) {
            rotate([90,0,0]) {
                upper_landing();
            }
        }  
    }
    if (0) {
        translate([90,$bs_l*1.2,15]) {
            rotate([-90,0,90]) {
                laser_mount_alt();
            }
        } 
    }    
}

$flat_for_svg=0;
$flat_pack=1;
if ($flat_pack) {
    translate([0,0,0]) {
        if ($flat_for_svg) {
            projection(cut=true) {
                translate([0,0,-1]) rotate([0,0,0]) {
                     flat_pack_parts();
                }
            }
        }else {
            flat_pack_parts();
        }
    }
} else {
    translate([0,0,0]) {
        assembled_unit();
    }
}