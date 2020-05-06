$layer_h = 0.1;
$layer_x = 10;
$layer_zy = 1;
$layer_count = 12;

$fn=16;

module layer(nodes, scaling, angle) {
    union() {
        for (level = [0 : 200]) {
            translate([0,0,level/5]) {
                rotate([0,0,-level/5]) {
                        for (i = [0 : 1 : 360]) {
                        rotate([0,0,i]) {
                            make_surface_elem((0.75+abs((sin(i*4)*0.25)))*(1+level/200));
                        }
                    }
               }
            }
        }
    }    
}

module make_surface_elem(scaling) {
    translate([$layer_x * scaling, 0, 0]) {
        cylinder(r=1, h=1/5);
    }
}

//render() {
    difference() {
        layer(0,0,0);
/*
        scale(0.99) {
            layer(0,0,0);
        }
*/
    }

//}
