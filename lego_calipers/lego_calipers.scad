
// LEGO constants
$stud_interval = 8; //mm
$P = $stud_interval;
$short_brick_h = 3.2; //mm
$tall_brick_h = 9.6; //mm

function brick_dimension(studs) = ($P * studs) - 0.2;

// Instrument Shape Constants
$wood_h = 3.125;

module inside_stop_shape () {
    $width = 2;
    $reach = 8;

    $trans_w = $width * 1.25;
    $trans_reach = $reach / 1.45;
    
    difference() {
        cube([brick_dimension($width),
              brick_dimension($reach),
              2],
            false);
        translate([brick_dimension($trans_w),           
                   brick_dimension($trans_reach),-1]) {
            rotate([0,0,40]) {
                cube([30, 30, 4]);
            }
        }
    }
}

module outside_stop_shape () {
    $width = 3;
    $reach = 12;

    $trans_w = $width * 1.05;
    $trans_reach = $reach / 1.3;
    
    difference() {
        cube([brick_dimension($width),
              brick_dimension($reach),
              2],
            false);
        translate([brick_dimension($trans_w),           
                   brick_dimension($trans_reach),-1]) {
            rotate([0,0,40]) {
                cube([30, 30, 4]);
            }
        }
    }
}


module inside_stop_bar() {
    difference() {
        inside_stop_shape();
        translate([-0.1,-0.1,-1]) {
            scale([0.2,0.2,2]) inside_stop_shape();    
        }
    }
}

module outside_stop_bar() {
    difference() {
        outside_stop_shape();
        translate([-0.1,-0.1,-1]) {
            scale([0.2,0.2,2]) outside_stop_shape();    
        }
    }
}

inside_stop_bar();

translate([25, 0, 0]) {
    outside_stop_bar();
}
