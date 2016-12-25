$thickness=3.175;
$detail=64;
$bit_diam=3.175;

$inch=25.4;

$stick_diam=$inch/4;
$tab_width=3.175;
$tab_length=7;
$major_r = 5*$inch;
$ring_size = $inch/1.9;

$side = 4 * $inch;
$tab_l = $thickness;

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
        translate([$major_r, $major_r/2, -1]) { 
            for (ring = [1:$major_r/$ring_size-1]) {
                notched_ring(ring*$ring_size, $bit_diam);
            }
        }
        make_stauntion_holes($stick_diam/2, $inch/2);
        make_side_slots(); 
    }
}

module make_side_slots() {
    translate([10, $inch/2+10, -1]) {
        cube([$thickness, 7, $thickness+2]);
    }
    translate([10, $major_r-($inch/2+10)-$tab_length, -1]) {
        cube([$thickness, 7, $thickness+2]);
    }
    
    translate([$major_r*2-10-$thickness, $inch/2+10 , -1]) {
        cube([$thickness, 7, $thickness+2]);
    }
    translate([$major_r*2-10-$thickness, $major_r-($inch/2+10)- $tab_length, -1]) {
        cube([$thickness, 7, $thickness+2]);
    }     
}

module make_side() {
    difference() {
        union() {
            translate([0, $thickness, 0]) {
                cube([$side, $side, 2]);
            }
            // bottom side
            translate([10,0,0]) {
                cube([7,$thickness, $thickness]);
            }
            translate([$side - 10 - $thickness,0,0]) {
                cube([7,$thickness, $thickness]);
            }
            //top side
            translate([10, $side+$thickness, 0]) {
                cube([7,$thickness, $thickness]);
            }
            translate([$side - 10 - $thickness, $side+$thickness, 0]) {
                cube([7,$thickness, $thickness]);
            }        
        }
        translate([$side/2,$side/2,-1]) {
            cylinder(r=$inch/8+ 0.5 , h=100 /*$thickness+2*/);
        }
    }
}

// lay out

make_plate();

translate([0, $major_r + $bit_diam, 0]) {
    make_side();
    translate([$major_r + $bit_diam,0,0]) {
        make_side();
    }
}
