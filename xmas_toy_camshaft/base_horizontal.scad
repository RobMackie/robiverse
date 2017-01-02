$thickness=3.175;
$detail=64;
$bit_diam=3.5;

$inch=25.4;

$stick_diam=$inch/2;
$tab_width=3.175;
$tab_length=7;
$major_r = 5*$inch;
$ring_size = $inch/1.9;

$side_t = 4 * $inch;
$side_w = 3 * $inch;
$tab_l = $thickness;
$tab_sep = 2 * $inch;
$tab_i = $inch/4-$thickness/2;


function left_tab(center, sep, size) = (center - sep/2);
function right_tab(center, sep, size) = (center + sep/2 - size);

module make_side_slots() {
    translate([$tab_i, left_tab($major_r/2, $tab_sep, $tab_length), -1]) {
        cube([$thickness, 7, $thickness+2]);
    }
    translate([$tab_i, right_tab($major_r/2, $tab_sep, $tab_length), -1]) {
        cube([$thickness, 7, $thickness+2]);
    }
    
    translate([$major_r*2-$tab_i-$thickness, left_tab($major_r/2, $tab_sep, $tab_length), -1]) {
        cube([$thickness, 7, $thickness+2]);
    }
    translate([$major_r*2-$tab_i-$thickness, right_tab($major_r/2, $tab_sep, $tab_length), -1]) {
        cube([$thickness, 7, $thickness+2]);
    }     
}
module make_stauntion_holes(rad, offs) {
    translate([offs, offs, -1]) {
        cylinder(r=rad, h=$thickness+2, $fn=$detail);
    }
    translate([offs, $major_r - offs, -1]) {
        cylinder(r=rad, h=$thickness+2, $fn=$detail);
    }
    translate([$major_r*2 - offs, offs, -1]) {
        cylinder(r=rad, h=$thickness+2, $fn=$detail);
    }
    translate([$major_r*2 - offs, $major_r - offs, -1]) {
        cylinder(r=rad, h=$thickness+2, $fn=$detail);
    }
}

module make_plate() {
    difference() {
        cube([$major_r*2, $major_r,$thickness/2]);
        make_stauntion_holes($stick_diam/2, $inch/2);
        make_side_slots(); 
    }
}


module make_side() {
    difference() {
        union() {
            translate([0, $thickness, 0]) {
                cube([$side_w, $side_t, $thickness]);
            }
            // bottom side left
            translate([left_tab($side_w/2, $tab_sep, $tab_length),0,0]) {
                cube([7,$thickness, $thickness]);
            }
            // bottom right
            translate([right_tab($side_w/2, $tab_sep, $tab_length),0,0]) {
                cube([7,$thickness, $thickness]);
            }
            //top left
            translate([left_tab($side_w/2, $tab_sep, $tab_length), $side_t+$thickness, 0]) {
                cube([7,$thickness, $thickness]);
            }
            //top right
            translate([right_tab($side_w/2, $tab_sep, $tab_length), $side_t+$thickness, 0]) {
                cube([7,$thickness, $thickness]);
            }        
        }
        translate([$side_w/2,$side_t/2,-1]) {
            cylinder(r=$inch/4 + 0.5 , h=$thickness+2);
        }
    }
}

// lay out
module layout() {
    make_plate();
    
    translate([0, $major_r + $bit_diam, 0]) {
        make_side();
        translate([$side_w + $bit_diam,0,0]) {
            make_side();
        }
    }
}

$2d = 0;
if ($2d) {
    projection(cut=true) {
       translate([0,0,0]) rotate([0,0,0]) {
           layout();
       }
    }
} else {
    layout();
}
