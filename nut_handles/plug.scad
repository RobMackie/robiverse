$inch = 25.4;

translate([0.75*$inch,0.75*$inch,0]) {
    difference() {
        cylinder(d=1.12*$inch, h=7, $fn=64);
        translate([00,0,-1]) {
            cylinder(d=5/16*$inch, h=9, $fn=64);
        }
    }
}