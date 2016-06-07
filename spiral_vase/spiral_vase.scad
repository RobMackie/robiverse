$layer_h = 0.1;
$layer_x = 10;
$layer_zy = 1;
$layer_count = 12;


module layer(nodes, scaling, angle) {

    for (i = [0 : 22.5 : 360]) {
        rotate([0,0,i]) {
            make_surface_elem(0.75+abs((sin(i*4)*0.25)));
        }
    }

    for (i = [5 : 22.5 : 360]) {
        rotate([0,0,i]) {
            make_surface_elem(0.75+abs((sin(i*4)*0.25)));
        }
    }

    for (i = [10 : 22.5 : 360]) {
        rotate([0,0,i]) {
            make_surface_elem(0.75+abs((sin(i*4)*0.25)));
        }
    }
    for (i = [15 : 22.5 : 360]) {
        rotate([0,0,i]) {
            make_surface_elem(0.75+abs((sin(i*4)*0.25)));
        }
    }
    for (i = [20 : 22.5 : 360]) {
        rotate([0,0,i]) {
            make_surface_elem(0.75+abs((sin(i*4)*0.25)));
        }
    }

}

module make_surface_elem(scaling) {
    difference() {
        cube([$layer_x * scaling, 1, 1]);
        cube([($layer_x * scaling) - 1, 1.1, 1.1]);
    }
}

module Spiral() {
	
	
	// spokes
	for (i = [0 : steps - 1]) {
		
	}
}

render() {
    layer(0,0,0);

}
