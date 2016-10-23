$fn=64;

$base_v = 15;
$base_h = 50;



module base_shape(base_width, base_height) {
    union() {
        cylinder(r=base_width/2, h=base_height);
        translate([-base_width/2,0,0]) {
            cube([base_width, base_width/2, base_height]);
        }
    }
}

module sensor_holes(altitude, offset) {
    translate([0,offset,altitude-2]) {
        rotate([90,0,0]) {
            cylinder(r=1, h=50);
        }
    }
    translate([0,offset,altitude+2]) {
        rotate([90,0,0]) {
            cylinder(r=1, h=50);
        }
    }  
}

module servo_slot(height) {
       difference() {
           cube([33,16,height]);
           translate([4,2,-1]) {
               cube([25,13,height+2]);
           }
       } 
}

module wire_ports() {
        // wire ports
        translate([-12,0,0]) {
            cube([3,9,8]);
        }
        translate([-20,0,0]) {
             cube([3,9,8]);           
        }
    
}

module main_build() {
    difference() {
        union() {
            difference() {
               base_shape($base_h, $base_v);
               translate([0,0,5]) {
                    scale(0.90) {
                        base_shape($base_h, $base_v);
                    }
                }
               translate([0,0,-1]) {
                    scale(0.90) {
                        base_shape($base_h, $base_v);
                    }
               }
               sensor_holes($base_v/2+2,-15);
               rotate([0,0,60]) {
                   sensor_holes($base_v/2+2,-15);
               }
                rotate([0,0,-60]) {
                   sensor_holes($base_v/2+2,-15);
               }      
            }
            translate([-16.5,8,0]) {
                servo_slot($base_v);
            }
        }
        translate([0,18,-1]) {
            wire_ports();
        } 
    }
}


main_build();