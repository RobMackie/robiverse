$fn=6;

$base_v = 15;
$base_h = 50;



module base_shape(base_width, base_height) {
    union() {
        cylinder(r=base_width/2, h=base_height);
        translate([-base_width/2,0,0]) {
            cube([base_width, base_width/2.3, base_height]);
        }
    }
}

base_shape($base_h, $base_v);