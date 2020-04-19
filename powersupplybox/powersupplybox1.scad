
$fn=32;

$box_z = 214;
$hole_1_z = $box_z -32;
$hole_3_z = $hole_1_z - 150;
$hole_1_y = 11.5;
$hole_2_y = $hole_1_y + 24.5;

$box_x = 114;
$box_y = 49.5;

$floor_y = 50;

$inch = 25.4;

$hh = 1000;
$hole_r = 2;

module power_box() {
    // power supply itself
    difference() {
        cube([$box_x,$box_y,214]);
        translate([110,$hole_1_y,$hole_1_z]){
            rotate([0,90,0]){
                cylinder(r=$hole_r, h=5);
            }
        }
        translate([110,$hole_2_y,$hole_1_z]){
            rotate([0,90,0]){
                cylinder(r=$hole_r, h=$hh);
            }
        }   
        translate([110,$hole_1_y,$hole_3_z]){
            rotate([0,90,0]){
                cylinder(r=$hole_r, h=$hh);
            }
        }
        translate([110,$hole_2_y,$hole_3_z]){
            rotate([0,90,0]){
                cylinder(r=$hole_r, h=$hh);
            }
        }  
        translate([-1,$hole_1_y,$hole_1_z]){
            rotate([0,90,0]){
                cylinder(r=$hole_r, h=$hh);
            }
        }
        translate([-1,$hole_1_y,$hole_3_z]){
            rotate([-1,90,0]){
                cylinder(r=$hole_r, h=$hh);
            }
        }
    }
}

module base() {
    // floor
    translate([0,$box_y, 0]) {
        cube([$box_x, $floor_y, $inch/8]);
    }
}

module left_wall() {
// left wall
    rotate([0,90,0]) {
        difference() {
            translate([-$inch/8,0,0]) {
                cube([$inch/8,$floor_y+$box_y,$box_z]);
            }
            translate([40,$hole_2_y,$hole_1_z]){
                rotate([0,90,0]){
                    cylinder(r=$hole_r, h=$hh);
                }
            }   
            translate([40,$hole_1_y,$hole_3_z]){
                rotate([0,90,0]){
                    cylinder(r=$hole_r, h=$hh);
                }
            }
            translate([40,$hole_2_y,$hole_3_z]){
                rotate([0,90,0]){
                    cylinder(r=$hole_r, h=$hh);
                }
            }  
            translate([-40,$hole_1_y,$hole_1_z]){
                rotate([0,90,0]){
                    cylinder(r=$hole_r, h=$hh);
                }
            }
            translate([-40,$hole_1_y,$hole_3_z]){
                rotate([-1,90,0]){
                    cylinder(r=$hole_r, h=$hh);
                }
            }
        }
    }
}
 
module right_wall() {
   translate([0,0,$box_x+$inch/16]) {
   rotate([0,90,0]) {
    // right wall 5.23
        difference() { 
            translate([$box_x,0,0]) {
                cube([$inch/8,$floor_y+$box_y,$box_z]);
            }
            translate([40,$hole_2_y,$hole_1_z]){
                rotate([0,90,0]){
                    cylinder(r=$hole_r, h=$hh);
                }
            }   
            translate([40,$hole_1_y,$hole_3_z]){
                rotate([0,90,0]){
                    cylinder(r=$hole_r, h=$hh);
                }
            }
            
            translate([40,$hole_2_y,$hole_3_z]){
                rotate([0,90,0]){
                    cylinder(r=$hole_r, h=$hh);
                }
            }  
            
            translate([-40,$hole_1_y,$hole_1_z]){
                rotate([0,90,0]){
                    cylinder(r=$hole_r, h=$hh);
                }
            }
            $vswitch = 47.22;
            $switch_y = 27;
            $switch_hole_fix_w = 1.6;
            $switch_hole_fix_v = -1.1;
            translate([$box_x-1,$box_y+12,60.25]) {
                    //box for body
                    cube([15,$switch_y, $vswitch]);
                    // left hole
                    translate([0,-5.23-$switch_hole_fix_w,$vswitch/2+$switch_hole_fix_v]) {
                        rotate([0,90,0]) {
                            cylinder(r=1.5, h=5);
                        }
                    }
                    // right hole
                    translate([0,$switch_y + 5.23+$switch_hole_fix_w,$vswitch/2+$switch_hole_fix_v]) {
                        rotate([0,90,0]) {
                            cylinder(r=1.5, h=5);
                        }
                    }            
            }
        }
    }
}
}

module make_parts() {
//   power_box(); 
//   base();
   left_wall();
//   right_wall();
}

$2d = 1;
if ($2d) {
    projection(cut=true) {
       translate([0,0,-1]) rotate([0,0,0]) {
         make_parts();
       }
   }
} else {
    make_parts();
}


