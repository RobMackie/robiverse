// test
$fn=64;

$z_max=30;
$arm_max=50;
$arm_wide=3;

$center_r=5;
$center_hole=3;

module make_flat() {
    translate([0,-($arm_wide/2),0]) {
        cube([$arm_max,$arm_wide,$z_max]);
    }
}

module make_tripod() {
   union () {
        make_flat();
        translate([$arm_max,0,0]) {
            rotate([0,0,60]) {
                make_flat();
            }
        }
        translate([$arm_max,0,0]) {
            rotate([0,0,-60]) {
                make_flat();
            }
        }
        translate([$arm_max, 0, 0]) {
            cylinder(r=$center_r, h=$z_max);
        }
    }  
}

module unit() {
    difference () {
        make_tripod();
        translate([$arm_max, 0, -1]) {
            cylinder(r=$center_hole, h=$z_max+2);
        }
    }
}

unit();