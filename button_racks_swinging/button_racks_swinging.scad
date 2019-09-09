
$inch = 25.4;
$foot = 12 * $inch;

$v_d = 1.25 * $inch; // Pole OD
$v_h = 9 * $foot;    // Pole length

$ot_inner_d=1.65 * $inch; //outter tube - ID
$ot_outer_d=1.8 * $inch; //outter tube - OD

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
        color("white") bushing(0);
        
        translate([0,0,height+1/2*$inch]) {
           color("white") bushing(1);        
        }
        
        translate([0,0,1/4*$inch]) {
           color("black") cuff(height);
        }    
        translate([0,0,height/2 + 1/4*$inch]) {
            rotate([90,0,0]) {
               color("silver") cylinder(d=$inch, h=1000);
            }
        }
    }
}

module build_it(){
    translate([0,0,0]) {
        color("silver") vertical_tube();
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
    

}

build_it();