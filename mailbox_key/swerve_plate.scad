$inch = 25.4;

$x_dim = 6.5 * $inch;
$y_dim = 5.5 * $inch;

$corner_radius = 0.25 * $inch;
$x_separation = $x_dim - (2*$corner_radius);
$y_separation = $y_dim - (2*$corner_radius);
    
$hole_rad = 5.22/2;

$fn=16;

module make_plate() {
    hull() {
        translate([$corner_radius,$corner_radius,0]) {
            cylinder(r=$corner_radius, h=1);
        }
        translate([$corner_radius+$x_separation, $corner_radius, 0]) {
            cylinder(r=$corner_radius, h=1);
        }
        translate([$corner_radius, $corner_radius+$y_separation, 0]) {
            cylinder(r=$corner_radius, h=1);
        }
        translate([$corner_radius+$x_separation, $corner_radius+$y_separation, 0]) {
            cylinder(r=$corner_radius, h=1);
        }
    }    
}

module make_parts() {
    difference() {
        make_plate($x_dim, $y_dim, $corner_radius);
        // low y row in x direction
        translate([$corner_radius, $corner_radius, -1]) {
            for(hole_count = [0 : 1 : 6]) {
                translate([hole_count*$inch, 0,0]) {
                    cylinder(r=$hole_rad, h=3);
                }
            }
        }
        // high y row in x direction
        translate([$corner_radius, $corner_radius+$y_separation, -1]) {
            for(hole_count = [0 : 1 : 6]) {
                translate([hole_count*$inch, 0,0]) {
                    cylinder(r=$hole_rad, h=3);
                }
            }
        }  
        // low x in y direction
        translate([$corner_radius, $corner_radius, -1]) {
            for(hole_count = [0 : 1 : 10]) {
                translate([0, hole_count*$inch/2,0]) {
                    cylinder(r=$hole_rad, h=3);
                }
            }
        }  
        // high x in y direction
        translate([$corner_radius+$x_separation, $corner_radius, -1]) {
            for(hole_count = [0 : 1 : 10]) {
                translate([0, hole_count*$inch/2,0]) {
                    cylinder(r=$hole_rad, h=3);
                }
            }
        }         
    }
}

$2d = 0;
if ($2d) {
    projection(cut=true) {
       translate([0,0,0]) rotate([0,0,0]) {
         make_parts();
       }
    }
} else {
    translate([0,0,0]) rotate([0,0,0]) {
        make_parts();
    }
}
