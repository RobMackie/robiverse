
function mm(inch) = (inch * 25.4);

$length = mm(12.625);
$width = mm(3.75);
$height = 60;
$thick = mm(1/8);

$fn=16;

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

// Assembly functions
module assembly_built() {
   pc_left_long();
   pc_front_short();
   pc_front_fill();
   pc_right_long();
   pc_back_short();
   pc_back_fill(); 
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
    
    //translate([3*$height+2*$space,0,$thick]) {
    translate([2*$height+$space,0,$thick]) {    
        rotate([-90,0,0]) {
            pc_front_short();
        }
    }    
    
    translate([2*$height+$space,$height+$space,2*$thick]) {
        rotate([-90,0,0]) {
            translate([0,-$length,0]) {
                pc_back_short();
            }
        }
    }
    
    translate([2*$height+3.5*$space,3*$height+2*$space,0]) {
        rotate([90,0,0]) {
            translate([-$thick-$thick/2,-$thick,0]) {
                pc_front_fill();
            }            
        }
    }

    translate([2*$height+$space+2.5*$space,4*$height+3*$space,0]) {
        rotate([90,0,0]) {
            translate([-$thick-$thick/2,-$length,0]) {
                pc_back_fill();
            }
        }
    }

    translate([0,0,0]) {
        rotate([0,0,0]) {
            
        }
    }    
    
    
}


//$built = 1;
$built = 0;

if ($built) {
    assembly_built();
} else {
    assembly_flat();
}