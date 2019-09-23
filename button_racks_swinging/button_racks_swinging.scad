// A stab at visualizing the button holder

$inch = 25.4;
$foot = 12 * $inch;

$v_d = 1.25 * $inch; // Pole OD
$v_h = 9 * $foot;    // Pole length

$ot_inner_d=1.5 * $inch; //outer tube - ID
$ot_outer_d=1.75 * $inch; //outer tube - OD

$fn=128;

module vertical_tube() {
    difference() {
        cylinder(d=$v_d, h=$v_h);
        // places for bolt holes
        // places for bolts
        // places for fixed bushings
    }
}

module cuff(height) {
    difference() {
        cylinder(d=$ot_outer_d, h=height);
        translate([0,0,-1]) {
            cylinder(d=$ot_inner_d, h=height+2);
        }
    }
}

module vertical_tube_size(height) {
    cylinder(d=$v_d, h=height);
}

module bushing(flipover) {

    $bushing_floor_d = $ot_outer_d + 1/8*$inch;
    $flip = flipover ? 180 : 0;

    rotate([0,$flip,0]) {
        difference() {
            union() {
                translate([0,0,1/4*$inch]) {
                    cylinder(d=$ot_inner_d, h=1/4*$inch);
                }
                cylinder(d=$bushing_floor_d, h=1/4*$inch);
            }
            translate([0,0,-1]) {
                cylinder(d=$v_d, h=30);
            }
        }
    } 
}


module rotating_cuff(height) {
    height = height - (1/2 * $inch);
    union() {
        // 2 bushings
        color("white") bushing(0);
        translate([0,0,height+1/2*$inch]) {
           color("white") bushing(1);        
        }
        
        // the central metal part that the bushings hold in place
        translate([0,0,1/4*$inch]) {
           color("black") cuff(height);
        }    
        // to make the long arm
        translate([0,-$ot_outer_d/4,height/2 + 1/4*$inch]) {
            difference() {
                rotate([90,0,0]) {
                    color("silver") cylinder(d=$inch, h=1000);
                }
                // to scallop it so it fits the outer shell
                translate([0,$ot_outer_d/4,-$inch/2-1]) {
                    cylinder(d=$ot_outer_d, h=$inch+2);
                }
            }
        }
    }
}

$thrust_bushing_d = $ot_outer_d*1.1;
module thrust_bushing() {
    difference() {
        cylinder(d=$thrust_bushing_d, h=1/2*$inch);
        translate([0,0,-1]) {
            cylinder(d=$v_d, h=1/2*$inch+2);
        }
    }
}

module horizontal_bolt() {
    translate([0,0,0]) {
        rotate([0,90,0]) {
            cylinder(d=1/4*$inch, h=$thrust_bushing_d/2);
        }
        translate([$thrust_bushing_d/2,0,0]) {
            rotate([0,90,0]) {
                cylinder(d=1/2*$inch, h=1/8*$inch, $fn=6);
            }
        }
    }
}



module bolt_ring() {
    rotate([0,0,0]) {
        horizontal_bolt();
    }
    rotate([0,0,120]) {
        horizontal_bolt();
    }
    rotate([0,0,240]) {
        horizontal_bolt();
    }
}


module build_it(){
    translate([0,0,0]) {
       // color("silver") 
        vertical_tube();
    }
    /* // a sample stick
    translate([50,50,10]) {
        vertical_tube_size(40);
    } 
    */ 
    rotate([0,0,20]) {
        translate([0,0,39*$inch]) {  
            rotating_cuff(50);
        }
    }
    rotate([0,0,40]) {
        translate([0,0,39*$inch+50]) {  
            rotating_cuff(50);
        }
    }
    rotate([0,0,20]) {
        translate([0,0,78*$inch]) {  
            rotating_cuff(50);
        } 
    }
    rotate([0,0,40]) {
        translate([0,0,78*$inch+50]) {  
            rotating_cuff(50);
        } 
    }   
   

    translate([0,0,(39-0.6)*$inch]) {
        color("silver") bolt_ring();
    }    
    translate([0,0,(39-0.5)*$inch]) {
       color("white") thrust_bushing(); 
    }
    

    translate([0,0,(78-0.6)*$inch]) {
        color("silver") bolt_ring();
    }    
    translate([0,0,(78-0.5)*$inch]) {
       color("white") thrust_bushing(); 
    }
}

module layout_parts() {
    translate([20,0,0]) {
        color("yellow") thrust_bushing();
    }
    translate([110,0,0]) {
        rotating_cuff(50);
    }
    translate([200,0,0]) {
        color("yellow") bushing();
    }
    translate([300,0,0]) {
       color("yellow")  cuff(40);
    }
  
    translate([0,0,0]) {
        // blank
    }   
}

$assemble = 1;
translate([0,0,0]) {
    if ($assemble) {
        build_it();
    } else {
        layout_parts();
    }
}



