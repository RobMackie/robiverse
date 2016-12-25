$thickness=6;
$detail=64;
$bit_diam=3.175;

$inch=25.4;

$stick_diam=$inch/4;
$tab_width=3.175;
$tab_length=7;
$major_r = 5*$inch;
$ring_size = $inch/1.9;


module make_slots_pass(rings, x, y) {
    translate([-(rings*$ring_size+$ring_size/2+x/2+1), -y/2-1, -1]) {
        cube([x+2,y+2,$thickness+2]);
    }
    translate([+(rings*$ring_size+$ring_size/2-x/2-1), -y/2-1, -1]) {
        cube([x+2,y+2,$thickness+2]);
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
        translate([$major_r, $major_r/2, -1]) { 
            cylinder(r=0.25*$inch,h=$thickness);
            for (ring = [1:$major_r/$ring_size-1]) {
                notched_ring(ring*$ring_size, $bit_diam);
                make_slots_pass(ring, $tab_width, $tab_length);
            }
        }
        make_stauntion_holes($stick_diam, $inch/2);
    }
}

make_plate();
translate([0,$major_r+$bit_diam,0,]) {
    make_plate();
}
