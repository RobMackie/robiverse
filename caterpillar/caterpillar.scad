
module get_cat() {
    scale([2,2,2]) {
        translate([13,14,0]) {
            import("./caterpillar.stl", convexity=3);
        }    
    }    
}

translate([0,0,-4]) {
    difference() {
        get_cat();
        cube([60, 40, 4]);
        translate([39,13.5,22]) {
            rotate([0,90,0]) {
                cylinder(r=1.5, h=8, $fn=32);
            }
        }
    }
}