
// test

$fn=64;

function inch(length) = 25.4 * length;

$wheel_r = inch(1);
$hood_r = inch(.75);
$hood_y = inch(2.25);

$roof_x = inch(5.625);
$roof_y = inch(3);
$roof_r = inch(1.5);

$rear_roof_r = inch(1.5);
$rear_roof_x = inch(1.5);
$rear_roof_y = inch(3);

$wheel_rear_x = inch(2.3125);
$wheel_front_x = inch(8);

$front_bump_x = inch(10);


module positive_body() {
    union() {
        translate([$wheel_rear_x,$wheel_r,0]) {
            cylinder(r=$wheel_r, h=1);
        }
        
        translate([$wheel_front_x,$wheel_r,0]) {
            cylinder(r=$wheel_r, h=1);
        }
        
        hull() {
            translate([0,$wheel_r,0]) {
                cylinder(r=0.1, h=1);
            }
            translate([$front_bump_x,$wheel_r,0]) {
                cylinder(r=0.1, h=1);
            }
            translate([$front_bump_x - $hood_r - 2,$hood_y,0]) {
                cylinder(r=$hood_r, h=1);
            }
        
            
            translate([$roof_x, $roof_y,0]) {
                cylinder(r=$roof_r, h=1);
            }
            translate([$rear_roof_x,$rear_roof_y,0]) {
                cylinder(r=$rear_roof_r, h=1);
            }  

        
        }
    }
}

module final_body() {
    difference() {
        positive_body();
        translate([inch(9.5),inch(7),0]) {
            cylinder(r=inch(4), h=5);
        }
        translate([inch(9),inch(3.05),0]) {
            rotate([0,0,-15]) {
                cube([inch(1),inch(1),5]);
            }
        }
        translate([inch(6.15),inch(4.5),0]) {
            rotate([0,0,-35]) {
                cube([inch(1),inch(1),5]);
            }
        }            
    }
}

final_body();