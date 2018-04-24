translate([0,16.4,10]) {
rotate([180,0,0]) {
translate([8.1, 8.1, 0]) {
    difference() {
        union() {
            cylinder(r=4, h=10, $fn=64);
            cylinder(r=8, h=3, $fn=64);
        }
        translate([0,0,4]) {
            cylinder(r=3, h=6, $fn=64);
        }
        translate([0,0,-23.8]) {
            sphere(r=25, $fn=64);
        }
    }
    
    translate([18,0,1]) {
        difference() {
            union() {
                cylinder(r=2.99, h=8.9, $fn=64);
                cylinder(r=8, h=3, $fn=64);
            }
            translate([0,0,-23.8]) {
                sphere(r=25, $fn=64);
            }
        }
    }
}
}
}




