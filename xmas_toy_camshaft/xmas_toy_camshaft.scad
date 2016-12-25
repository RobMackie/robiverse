$thickness=6;
$detail=64;
$bit_diam=3.175;

$inch=25.4;

$stick_diam=$inch/4;

module ring(radius, rim) {
    difference() {
        cylinder(r=radius, h=$thickness, $fn=$detail);
        translate([0,0,-1]) {
            cylinder(r=radius-rim, h=$thickness+2, $fn=$detail);
        }
    }
}

module notched_ring(radius, rim) {
    difference() {
        ring(radius, rim);
        translate([radius - rim -1,-0.25,-1]) {
            cube([rim+2,0.5,$thickness+2]);
        }
        translate([-(radius + rim-1),-0.25,-1]) {
            cube([rim+2,0.5,$thickness+2]);
        }
    }
}

translate([5*$inch, 5*$inch, 0]) {
    difference() {
        cylinder(r=5*$inch, h=$thickness/2, $fn=$detail);
        translate([0,0,-1]) {
            cylinder(r=0.25*$inch,h=$thickness);
        notched_ring(1*$inch, $bit_diam);
        notched_ring(2*$inch, $bit_diam);
        notched_ring(3*$inch, $bit_diam);
        notched_ring(4*$inch, $bit_diam);
        }
        /* place stick mounting holes on each ring */
    }
}