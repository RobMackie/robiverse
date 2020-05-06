$inch = 25.4;

$detail = 128;

module hollow_cone(rb, rt, h, hollow) {
    difference() {
        hull() {
            cylinder(r=rb, h=1, $fn=$detail);
            translate([0,0,h-1]) {
                cylinder(r=rt, h=1, $fn=$detail);
            }
        }
        if (hollow) {
            translate([0,0,1]) {
                hull() {
                    cylinder(r=rb-2, h=1, $fn=$detail);
                    translate([0,0,h-1]) {
                        cylinder(r=rt-2, h=1, $fn=$detail);
                    }
                }
            }
        }
    }
}


cylinder(r=3*$inch, h=$inch/4, $fn=$detail);
translate([0,0,$inch/4]) {
    cylinder(r=2*$inch, h=$inch/2, $fn=$detail);
}
translate([0,0,3/4*$inch]) {
    hollow_cone(2*$inch, 3*$inch, 15, 0); // change the 0 to a 1 to make it hollow
}


