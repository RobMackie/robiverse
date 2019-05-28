
function mm(inch) = (inch * 25.4);

$length = mm(12.625);
$width = mm(3.75);
$height = 60;
$thick = mm(1/8);

$fn=16;
$filet=5;

// Utility functions
module longside() {
    // Long side

    difference() {
        cube([$thick, $length + $thick*2, $height]);
        translate([-3,0.512*$length, (3.742 * $length) * -0.9933]) {
            rotate([0,90,0]) {
                cylinder(r=3.742 * $length, h=10, $fn=256);
            }
        }
        $hole_count = 5;
        $hole_dist = $length/$hole_count;
        for ( i = [0 : $hole_count-1] ){ 
            translate([-5,(0.5*$hole_dist) + i*$hole_dist,40]) {
                rotate([0,90,0]) {
                    cylinder(r=1.55, h=10);
                }
            }
        }

        if (0) { // measuring stick
            translate([0,0,$height-10]) {
                cube([1,150.74+14.45,5]);
            } 
        }
        // clearance holes starting from front
        translate([-5,14.45,$height-3]) {
            rotate([0,90,0]) {
                cylinder(r=4, h=10);
            }
        }  
        translate([-5,150.74+14.45,$height-3]) {
            rotate([0,90,0]) {
                cylinder(r=4, h=10);
            }
        }       
        translate([-5,58.29,$height-9.45]) {
            rotate([0,90,0]) {
                cylinder(r=4, h=10);
            }
        }
        translate([-5,116.49,$height-9.45]) {
            rotate([0,90,0]) {
                cylinder(r=4, h=10);
            }
        }
        translate([-5,$length-135.59,$height-22.02]) {
            rotate([0,90,0]) {
                cylinder(r=4, h=10);
            }
        }
        translate([-5,$length-4.41,$height-27.44]) {
            rotate([0,90,0]) {
                cylinder(r=4, h=10);
            }
        }      
    }
}

module shortside() {
    difference() {
        cube([$width, $thick, $height]);
        $hole_count = 3;
        $hole_dist = $width/$hole_count;
        for ( i = [0 : $hole_count-1] ){ 
            translate([(0.5*$hole_dist) + i*$hole_dist, 5, 40]) {
                rotate([90,0,0]) {
                    cylinder(r=1.55, h=10);
                }
            }
        }  
    }      
}
module vertical_disk_x(rv,hv) {
    translate([rv,hv,rv]) {
        rotate([90,0,0]) {
            cylinder(r=rv, h=hv, $fn=64);
        }
    }
}

module wing() {
    union() {
        translate([0,0,0]) {
            cube([$width/3, $thick, $height]);
        }
        hull() {
            translate([$width,0,0]) {
                vertical_disk_x(rv=$filet, hv=$thick);
            }
            translate([1/3*$width-$filet,0,$height-2*$filet]) {
                vertical_disk_x(rv=$filet, hv=$thick);
            }
            translate([1/3*$width-$filet,0,0]) {
                vertical_disk_x(rv=$filet, hv=$thick);
            }            
        }
    }
}

// Part functions
module pc_left_long() {
    translate([0, 0, 0]) {
        difference() {
            longside();
            translate([-5,$length*0.82,25]) {
                rotate([0,90,0]) {
                    cylinder(r=2.5, h=10);
                }
            }
        }
    }
}


module pc_front_short() {
    //front side
    translate([$thick, 0, 0]) {
        $portwidth = mm(0.7);
        $portheight = mm(0.5);
        difference() {
            shortside();
            translate([$width/2-$portwidth/2,-2, 10]) {
                cube([$portwidth,10, $portheight]);
            }
        }
    }
}

module pc_front_fill() {
    //front side backing fill
    translate([$thick, $thick, 0]) {
        $portwidth = mm(0.7);
        $portheight = mm(0.5);
        difference() {
            shortside();
            translate([$width/2-$portwidth/2,-2, 10]) {
                cube([$portwidth,10, $portheight]);
            }
            cube([$thick/2,$thick,$height+5]);
            translate([$width-$thick/2, 0, 0]) {
                cube([$thick/2,$thick,$height+5]);
            }        
        }
    }
}

module pc_right_long() {
    translate([$width+$thick, 0, 0]) {
        longside();
    }
}

module pc_back_short() {
    // backside
    translate([$thick, $thick + $length, 0]) {
        shortside();
    }
}

module pc_back_fill() {
    // backside backing filler
    translate([$thick, $length, 0]) {
        difference() {
            shortside();
            cube([$thick/2, $thick, $height+5]);
            translate([$width-$thick/2,0,0]) {
                cube([$thick/2, $thick, $height+5]);
            }
            
        }
    }
}


module pc_front_wings() {
    translate([0,-$thick,0]) {
        //front side wings
        union() {
            translate([$width,0,0]) {        
                wing();
            }
            pc_front_short();
            translate([$thick,$thick,0]) {
                rotate([0,0,180]) {
                    wing();
                }
            }
        }
    }
}

module pc_back_wings() {
   union() {
        translate([$width,2*$thick + $length,0]) {        
            wing();
        }
        translate([$thick, 2*$thick + $length, 0]) {
            shortside();
        }
        translate([$thick,3*$thick + $length,0]) {
            rotate([0,0,180]) {
                wing();
            }
        }
    }    
}
// Assembly functions
module assembly_built() {
   pc_left_long();
   pc_front_short();
   pc_front_fill();
   pc_right_long();
   pc_back_short();
   // not needed pc_back_fill(); 
   pc_front_wings();
   pc_back_wings();
}

module assembly_flat() {
    $space = 2;
    translate([$height,0,0]) {
        rotate([0,-90,0]) {
            pc_left_long();
        }
    }
    
    translate([2*$height+$space,0,-$width-($thick)]) {
        rotate([0,-90,0]) {
               pc_right_long();
        }
    }
    /*
    translate([-$thick,$length+5*$space,$thick]) {    
        rotate([-90,0,0]) {
            pc_front_short();
        }
    }    
    
    translate([$width+$space,$length+5*$space,2*$thick]) {
        rotate([-90,0,0]) {
            translate([0,-$length,0]) {
                pc_back_short();
            }
        }
    }
    
    translate([0,$length+2*$height+6*$space,0]) {
        rotate([90,0,0]) {
            translate([-$thick-$thick/2,-$thick,0]) {
                pc_front_fill();
            }            
        }
    }
    if(0) { // piece not needed
        translate([$width+2*$space,$length+2*$height+6*$space,0]) {
            rotate([90,0,0]) {
                translate([-$thick-$thick/2,-$length,0]) {
                    pc_back_fill();
                }
            }
        }
    }
    translate([2*$height+$filet+$space, $width+2*$filet, $thick]) {
        rotate([90,0,90]) {
            pc_front_wings();
        }
    }
   
    translate([3*$height+2*$filet+ 2*$space, 0,0]) {
        rotate([90,0,90]) {
            translate([$width+2*$filet,-$length+-2*$thick,0]) {
                pc_back_wings();
            }
        }
    }
    */
}

$built = 1;
$2d = 0;

if ($built) {
    assembly_built();
} else {
    if ($2d) {
        projection(cut=true) {
            translate([0,0,-1]) rotate([0,0,0]) {
                assembly_flat();
            }
        }
    } else {
        assembly_flat();
    }
}