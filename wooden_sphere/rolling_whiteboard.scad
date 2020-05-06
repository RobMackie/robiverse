$inch = 25.4;

// Constants
$mat_thick = 0.75*$inch;

module vertical_side() {
    $r_base = 2*$inch;
    
    $l_foot_c2c = (21.5*$inch - (2*$r_base));
    $t_foot_c2c_factor = 0.4;
    $foot_vertical = 8 * $inch;
    
    $r_riser = 1.5*$inch;
    $riser_vertical = ($inch * 50);
    
    $riser_center_ll_x = $l_foot_c2c*$t_foot_c2c_factor;
    $riser_center_ll_y = $foot_vertical; 
    
    $riser_center_lr_x = $l_foot_c2c-($l_foot_c2c*$t_foot_c2c_factor);
    $riser_center_lr_y = $riser_center_ll_y;
    
    $riser_center_ul_x = $riser_center_ll_x;
    $riser_center_ul_y = $riser_vertical - 2.4*$r_riser;
    
    $riser_center_ur_x = $riser_center_lr_x;
    $riser_center_ur_y = $riser_center_ul_y;
    translate([$r_base, $r_base, 0]) {
        difference() {
            union() {
                hull() {
                    // left bottom corner
                    translate([0,0,0]) {
                        cylinder(r=$r_base, h=$mat_thick);
                    }
                    // right bottom corner
                    translate([$l_foot_c2c,0,0]) {
                        cylinder(r=$r_base, h=$mat_thick);
                    }
                    // left shoulder of base
                    translate([$l_foot_c2c*$t_foot_c2c_factor, $foot_vertical,0]) {
                        cylinder(r=$r_base, h=$mat_thick);
                    }
                    // right shoulder of base
                    translate([$l_foot_c2c-($l_foot_c2c*$t_foot_c2c_factor),$foot_vertical,0]) {
                        cylinder(r=$r_base, h=$mat_thick);
                    }
                }
                hull() {
                    // bottom left corner of upright
                    translate([$riser_center_ll_x,$riser_center_ll_y,0]) {
                        cylinder(r=$r_riser, h=$mat_thick);
                    }
                    // bottom right corner of upright
                    translate([$riser_center_lr_x,$riser_center_lr_y,0]) {
                        cylinder(r=$r_riser, h=$mat_thick);
                    }
                    // top left corner of upright
                    translate([$riser_center_ul_x,$riser_center_ul_y,0]) {
                        cylinder(r=$r_riser, h=$mat_thick);
                    }
                    
                    // top right corner of upright
                    translate([$riser_center_ur_x,$riser_center_ur_y,0]) {
                        cylinder(r=$r_riser, h=$mat_thick);
                    }            
                }
            }
    
            // start subtracting
            $r_pivot = 0.5*$inch;
            $center = (($riser_center_ur_x-$riser_center_ul_x)/2);
            translate([$riser_center_ul_x+$center,
                       $riser_center_ul_y-(2*$inch),
                        -0.1]) {
                cylinder(r=$r_pivot, h=$inch);
            }
            $slot_len = 15 * $inch;
            $center_slot = ($l_foot_c2c/2 - $slot_len/2);
            translate([$center_slot,0,$inch*3/8]) {
                cube([$inch*15,$inch*0.75,$inch*3/8+10]);
            }
            
            $slot2_len = $inch * 5;
            $slot2_center_start = $riser_center_ul_x +
                                  $center - $slot2_len/2;
            translate([$slot2_center_start,
                       $riser_center_ul_y-(26*$inch),
                       $inch*3/8]) {
                cube([$slot2_len,$inch*0.75,$inch*3/8+10]);
            }
            // still subtracting
        }
    }
}

module top_brace() {
    
}

module lower_brace() {
    
}

module wheel_mount() {
    
}

module make_structure() {
    vertical_side();

    //cube([100, 74.5 * $inch, 10]);
    // cube([30*$inch, 50*$inch, 1]);
}

module make_cut_layout() {
}

$2d = 0;
$flat = 0;
if ($2d) {
    projection(cut=true) {
       translate([0,0,0]) rotate([0,0,0]) {
         make_cut_layout();
       }
}
} else {
    if($flat) {
        make_cut_layout();
    } else {
        make_structure();
    }
//  for measuring and calibrating
//    translate([60,40,0]) {
//      cube([20,5,1]);
//    }
}