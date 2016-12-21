$fn=100;

module openbeam () {
    union() {
        difference() {
            cylinder(r=12.5, h=12);
            translate([-7.505,-7.505, -1]) {
                cube([15.1,15.1,14]);
            }
        }
    }
}


translate([20,20,0]) {
    openbeam();
}

