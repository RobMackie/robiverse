$mirror_side = 40;
$mirror_clearance = 2;
$mount_r = 1;

$rail_dim = 2;

$mirror_thick = 2;



module mirror_mount (hollow_side, rail_size, clearance) {
    
    $outer_size = hollow_side+clearance + 2*rail_size;
    $inner_size = hollow_side + clearance;    

    difference() {
        translate([0,0,0]) {
            cube([$outer_size,$outer_size,rail_size]);
        }
        translate([rail_size,rail_size,-1]) {
            cube([$inner_size,$inner_size,rail_size+2]);
        }
        rotate([-90,0,0]) {
            translate([(hollow_side+rail_size-1)/2+$mount_r*2,-rail_size/2,-1]) {
                cylinder(r=$mount_r, h=$outer_size+2, $fn=64);
            }
        }
    }
}

module rotateable_cube(x,y,z, xd, yd, zd) {
    translate([x/2,y/2,z/2]) {
        rotate([xd, yd, zd]) {
            cube([x, y, z], center=true);
        }
    }
}

module simulated_mirror (side, thick, rr, rail, clearance, rot) {
    union() {
        
        translate([0,0,-thick/2]) {
            rotateable_cube(side,side,thick, 0,rot,0);
        }
        
        rotate([-90,0,0]) {
            translate([(side-1)/2,0,-6]) {
                cylinder(r=$mount_r/1.5, h=side+2*rail+clearance, $fn=64); 
            }
            difference() {
                translate([(side-1)/2,0,-1]) {
                    cylinder(r=$mount_r*2, h=clearance/2, $fn=32); 
                }
                // remove a ring to make threadway in pulley
                // by creating a bigger annulus that we can remove
                // creating the annulus that will be removed:
                difference() {
                    // base of annulus
                    translate([(side-1)/2,0,-0.65]) {
                        cylinder(r=($mount_r*2)+1, h=clearance/6, $fn=32); 
                    }
                    // removed center of annulus
                    translate([(side-1)/2,0,-0.65]) {
                        cylinder(r=($mount_r*2)-0.5, h=clearance/6, $fn=32); 
                    }
                }
            }
        }
    }    
}

module mirror_and_mount(degrees) {
    translate([0,0,0]) {
        mirror_mount($mirror_side, $rail_dim, $mirror_clearance);
    }
    
    $mirror_offset = $rail_dim+$mirror_clearance/2;
    translate([$mirror_offset,$mirror_offset,$rail_dim/2]) {
        simulated_mirror($mirror_side, $mirror_thick, $mount_r/1.5, $rail_dim, $mirror_clearance, degrees);
    }
}

mirror_and_mount(20);
translate([0,45,0]) {
    mirror_and_mount(60);    
}
translate([0,90,0]) {
    mirror_and_mount(-20);    
}
translate([0,135,0]) {
    mirror_and_mount(-75);    
}

    
