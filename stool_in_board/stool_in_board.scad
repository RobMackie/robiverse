// stool in a board
// This thing fits on a 33" by 28" board

// constants
$inch = 25.4;


// All of this board stuff is now just artifacts
// However, many of the formulas below still depend 
// on these numbers.
// These numbers no long correspond to anything in the 
// real world.

$board_z = 18.65; // This is board thickness

$board_x = 25 * 25.4;
$board_y  = 30 * 25.4;

$board_z_tmp = 1 / 40;
$disk_d = 14 * 25.4;

$slotted = 1;
$not_slotted = 1;

// stool outer
module stool_leg_outer() {
    $bottom_leg_r = 40;
    $top_leg_r = 10;
    
    $bottom_leg_width = 24 * $inch;
    $bottom_leg_offset = ($board_y - $bottom_leg_width)/2;

    $top_leg_width = 12 * $inch;
    $top_leg_offset = ($board_y - $top_leg_width)/2;
    
    $top_leg_lift = 650 + $bottom_leg_r;
    $leg_offset_ll = $bottom_leg_r + $bottom_leg_offset;
    $leg_offset_lr = $board_x -($bottom_leg_r + $bottom_leg_offset);
    $leg_offset_tl = $top_leg_r + $top_leg_offset;
    $leg_offset_tr = $board_x -($top_leg_r + $top_leg_offset);
    hull() {
        translate([$leg_offset_ll, $bottom_leg_r, 0]) {
            cylinder(r=$bottom_leg_r, h=$board_z);
        }
        translate([$leg_offset_lr, $bottom_leg_r, 0]) {
            cylinder(r=$bottom_leg_r, h=$board_z);
        }
        translate([$leg_offset_tl, $top_leg_lift, 0]) {
            cylinder(r=$top_leg_r, h=$board_z);
        }
        translate([$leg_offset_tr, $top_leg_lift, 0]) {
            cylinder(r=$top_leg_r, h=$board_z);
        }      
    }
}

// stool leg inner
module stool_leg_inner() {
    $m_inner = 2;
    
    $bottom_leg_r = 40;
    
    $top_leg_width = 9 * $inch;
    $top_leg_offset = ($board_y - $top_leg_width)/2;
    
    $bottom_leg_width = 16 * $inch;
    $bottom_leg_offset = ($board_y - $bottom_leg_width)/2;
    
    $top_leg_lift = 450 + $bottom_leg_r;
    $leg_offset_ll = $bottom_leg_r + $bottom_leg_offset;
    $leg_offset_lr = $board_x -($bottom_leg_r + $bottom_leg_offset);
    $leg_offset_tl = $bottom_leg_r + $top_leg_offset;
    $leg_offset_tr = $board_x -($bottom_leg_r + $top_leg_offset);
    hull() {
        translate([$leg_offset_ll, $bottom_leg_r-$inch*2, 0]) {
            cylinder(r=40, h=$board_z*$m_inner);
        }
        translate([$leg_offset_lr, $bottom_leg_r-$inch*2, 0]) {
            cylinder(r=40, h=$board_z*$m_inner);
        }
        translate([$leg_offset_tl, $top_leg_lift, 0]) {
            cylinder(r=10, h=$board_z*$m_inner);
        }
        translate([$leg_offset_tr, $top_leg_lift, 0]) {
            cylinder(r=10, h=$board_z*$m_inner);
        }      
    }    
    
}

// stool leg top half
module stool_leg_top() {
    difference() {
        stool_leg_outer();
        translate([0,0,-0.1]) {
            color("green") stool_leg_inner();
        }
        
        translate([12.5*$inch, 6.5*$inch,-0.1]) {
            color("red") cylinder(d=12*$inch, h=40);
        }
        translate([($board_x/2)-$board_z/2,19.66*$inch,-.1]) {
            color("red") cube([$board_z,7.9/2*$inch,50]);
        }
    }
}    

   
// stool leg bottom half
module stool_leg_bottom() {
    difference() {
        stool_leg_outer();
        translate([0,0,-0.1]) {
            color("green") stool_leg_inner();
        }
        translate([12.5*$inch, 6.5*$inch,-0.1]) {
            color("red") cylinder(d=12*$inch, h=40);
        }
        translate([($board_x/2)-$board_z/2,(19.66+7.9/2)*$inch,-.1]) {
            color("red") cube([$board_z,7.9/2*$inch,50]);
        }
    }  
}


// fit in a board
module board() {
    color("orange")cube([$board_x, $board_y, $board_z_tmp]);
}

module slotted_top () {
    $top_d = 10.8*$inch;
    $slot_dado = $board_z;
    $slot_len = 7 * $inch;
    difference() {
        color("red") cylinder(d=$top_d, h=40, $fn=64);
        
        translate([-$slot_dado/2,-$slot_len/2,-0.1]) {
            cube([$slot_dado, $slot_len, 2*$inch]);
        }
        
        translate([-$slot_len/2, -$slot_dado/2,-0.1]) {
            cube([$slot_len, $slot_dado, 2*$inch]);
        }        
       
    }
}

module buildit() {
    union() {
        if ($slotted) {
            translate([-70,0,0]) {
                stool_leg_top();
            }
        }
        if ($not_slotted) {
            translate([910,700,0]) {
                rotate([0,0,180]) {
                    stool_leg_bottom();
                }
            }
        }
        if ($slotted) {
            translate([75,165,0]) {
                cube([60,5,50]);
            }
        }
        if ($slotted) {
            translate([370,165,0]) {
                cube([60,5,50]);
            }
        }
        if ($not_slotted) {
            translate([415,530,0]) {
                cube([350,5,50]);
            }
        }
        if ($slotted) {
            translate([9.80*$inch, 6.5*$inch,-0.1]) {
                slotted_top();
            }
        }
        if ($not_slotted) {
            translate([(9.9+13.4)*$inch, 21*$inch,-0.1]) {
                color("red") cylinder(d=10.8*$inch, h=40, $fn=64);
            }
        }

    }
}

$flat_for_svg = 1;

/*
translate([160,700,0]) {
    cube([6.9*$inch,board_z,50]);
}
*/
/* // fits on 33" x 28" board
translate([0,700,0]) {
    cube([33*$inch,3*$inch/4,50]);
}
translate([33*$inch,0,0]) {
    cube([$board_z, 28*$inch,50]);
}
*/

if ($flat_for_svg) {
    projection(cut=true) {
        translate([0,0,-1]) rotate([0,0,0]) {
            buildit();
        }
    }
} else {
    buildit();
}
