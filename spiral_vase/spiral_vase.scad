$layer_h = 0.1;
$layer_x = 10;
$layer_zy = 1;
$layer_count = 12;

$fn=16;

module layer(nodes, scaling, angle) {
    for (level = [0 : 40]) {
        translate([0,0,level]) {
            rotate([0,0,-level]) {
			    for (i = [0 : 2 : 360]) {
			        rotate([0,0,i]) {
			            make_surface_elem((0.75+abs((sin(i*4)*0.25)))*(1+level/20));
			        }
			    }
           }
        }
    }
}

module make_surface_elem(scaling) {
    translate([$layer_x * scaling, 0, 0]) {
        cylinder(r=1, h=1);
    }
}

//render() {
union() {
    cylinder(r=9.5,h=1);
    difference() {
        layer(0,0,0);
        /*
        scale(0.99) {
            layer(0,0,0);
        }
        */
    }
}

//}
