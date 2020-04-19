
//4.15
/*
translate([-2.5,0,0]) {
    cube([4.15,5,$drive_shaft_length]);
}
*/

$fn=64;

/* The shaft of the nema17 motor as best I can guess */
// nema17 shaft
$drive_shaft_length=15;
$drive_shaft_d = 5;
$drive_shaft_flat_offset = 0.66 * ($drive_shaft_d/2);

module nema17_drive_shaft() {
    difference() {
        cylinder(d=$drive_shaft_d, 
                 h=$drive_shaft_length);
        translate([$drive_shaft_flat_offset,-$drive_shaft_d/2,-1]) {
            cube([$drive_shaft_d,
                  $drive_shaft_d,
                  $drive_shaft_length+2]);
        }
    }
}


/* The small suction cup as best I can guess */
$suction_base_d = 6.6;
$suction_scale_f = 20/$suction_base_d;
$suction_neck_d = 3.25;
module suction_cup() {
    union() {
        cylinder(d=$suction_base_d, h=2);
        translate([0,0,2]) {
            cylinder(d=$suction_neck_d, h=1.5);
        }
        translate([0,0,3]) {
            cylinder(d=$suction_base_d, h=1);
        }        
    }
    difference() {
        translate([0,0,4]) {
            linear_extrude(height = 4, 
                           twist = 0, 
                           slices = 2, 
                           scale=[$suction_scale_f, $suction_scale_f]) {
               circle(r=$suction_base_d/2);
            }
        }
        translate([0,0,4.2]) {
            linear_extrude(height = 4, 
                           twist = 0, 
                           slices = 2, 
                           scale=[$suction_scale_f, $suction_scale_f]) {
               circle(r=$suction_base_d/2);
            }
        }
    }    
}

/* 4-40 threaded rod sans threads  */
$threaded_rod_d = 2.7;
$threaded_rod_len = 40;
module threaded_rod_four_forty () {
    cylinder(d=$threaded_rod_d, h=$threaded_rod_len);
}


threaded_rod_four_forty();

translate([20,20,0]) {
    nema17_drive_shaft();
}

translate([20,0,0]) {
    suction_cup();
}




