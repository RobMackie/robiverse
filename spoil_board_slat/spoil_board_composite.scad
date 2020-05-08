$inch = 25.4;

$slat_x = 89.2;
$slat_y = 711.4;
$slat_z = 19.05;

$half_slat_x = 3.5 * $inch;
$half_slat_y = $slat_y;
$half_slat_z = $slat_z;

$slat_y_tot = ($slat_x + (3*$inch/4));

$hide = 0;

module track() {
    translate([0, 0, 0]) {
        color("aqua") cube([3*$inch/4, $slat_y , 10]);
    }    
}

module faux_slat() {
    for($position_x = [80, 355.7, 631.4]) {
        translate([$slat_x/2, $position_x, -5]) {
            color("red") cylinder(r=3.175, h=30);
        }
    }    
}
module slat() {
    if ($hide) {
        for($position_x = [80, 355.7, 631.4]) {
            translate([$slat_x/2, $position_x, -5]) {
                color("red") cylinder(r=3.175, h=30);
            }
        }
    } else {
        difference() {
            color("gray") cube([$slat_x, $slat_y, $slat_z]);
            for($position_x = [80, 355.7, 631.4]) {
                translate([$slat_x/2, $position_x, -5]) {
                    color("red") cylinder(r=3.175, h=30);
                }
                translate([$slat_x/2, $position_x, $inch/4]) {
                    color("blue") cylinder(r=12, h=15);
                }
            }
        }
    }
}

module half_slat() {
    difference() {
        color("purple") cube([$half_slat_x, $half_slat_y, $half_slat_z]);
        for($position_x = [80, 355.7, 631.4]) {
            translate([$half_slat_x/2, $position_x, -5]) {
                color("red") cylinder(r=3.175, h=30);
            }
            translate([$half_slat_x/2, $position_x, $inch/4]) {
                if (!$hide) color("blue") cylinder(r=12, h=15);
            }
        }
    }
}

module spoil_board() {
    if (!$hide) half_slat();
    translate([$half_slat_x, 0, 0 ]) {
        for (slat_id = [0:8]) {
            translate([slat_id*$slat_y_tot+3*$inch/4, 0, 0]) {
                if (!$hide) {
                    slat();
                } else {
                    faux_slat();
                }
            }
        }
        for (track_id = [0:9]) {
            translate([track_id*$slat_y_tot, 0, 0]) {
                if(!$hide) track();
            }
        }
        translate([9*$slat_y_tot+(3*$inch/4), 0, 0]) {
            if (!$hide) half_slat();
        }
    }
}


if ($2d) {
    projection(cut=true) {
       translate([0,0,0]) rotate([0,0,0]) {
          base_plate($plate_long, $plate_wide);
       }
    }
}

if (!$hide) cube([3*$inch/4, 28*$inch, $inch/2]);
if (!$hide) {
    translate([0.9 * $inch, 0, 0]) spoil_board();
} else {
    projection(cut=true) {
        translate([0.9 * $inch, 0, 0]) spoil_board();
    }
}

if (!$hide) translate([48*$inch-3*$inch/4, 0, 0]) cube([3*$inch/4, 28*$inch, $inch/2]);

translate([0, -10, 0]) {
    if (!$hide) cube([48*$inch, 10, 10]);
}
