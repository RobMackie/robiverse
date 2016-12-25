$thickness=6;
$detail=64;
$bit_diam=3.175;

$inch=25.4;

$stick_diam=$inch/4;
$tab_width=3.175;
$tab_length=7;
$major_r = 5*$inch;
$ring_size = $inch/1.9;

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

module make_slots(rings, x, y) {
    translate([-(rings*$ring_size+$ring_size/2+x/2), -y/2, -1]) {
        cube([x,y,$thickness+2]);
    }
    translate([+(rings*$ring_size+$ring_size/2-x/2), -y/2, -1]) {
        cube([x,y,$thickness+2]);
    }
}

module layout() {
    translate([$major_r, $major_r, 0]) {
        difference() {
            cylinder(r=$major_r, h=$thickness/2, $fn=$detail);
            translate([0,0,-1]) {
                cylinder(r=0.25*$inch,h=$thickness);
                for (ring = [1:$major_r/$ring_size-1]) {
                    notched_ring(ring*$ring_size, $bit_diam);
                    make_slots(ring, $tab_width, $tab_length);
                }
            }
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

