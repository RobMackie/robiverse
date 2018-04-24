
union() {
    translate([17,10,0]) {
        phone_holder();
    }
    rotate([0,0,-90]) {
        translate([-10, 0, 0]) {
            tripod_attachment();
        }
    }
}

module phone_holder() {
    difference() {
        cube([19.5, 85, 80]);
        translate([5,6,5]) {
            cube([12.75,75,80]);
        }
        // start button
        translate([10,30,10]) {
            cube([15,25,80]);
        }
        // screen
        translate([10,11,17]) {
            cube([15,65,80]);
        }
        
        // mic and micro usb
        translate([8,34,0]) {
            cube([6,31,10]);
        }

    }
    
    
}



module tripod_attachment() {
    translate([10,0,0]) {
        rotate([0,-90,0]) {
            difference() {
                body();
                /*
                translate([44/2, 51.44/2, -1]) {
                    cylinder(r=6.4/2, h=12, $fn=32);
                    cylinder(r=6.5/2, h=8, $fn=32);        
                    cylinder(r=12.9/2, h=5, $fn=6);
                }
                */
            }
        }
    }
}

/*
translate([9,51.44/2-5.5,20]) {
    color("red") cube([1,11,3]);
}

translate([12,0,0]) {
    cube([1,52.44,1]);
}
 
translate([0,53,0]) {
    cube([44,1,1]);
}
*/
   
module ramp() {
    difference() {
        cube([44,10,10]);
        translate([0,0,0]) {
            rotate([60,0,0]) {
                cube([55.44,15,10]);
            }
        }
     }
}

module body() {
    union() {    
        translate([0,10,0]) {
            cube([44, 32.44, 10]);
        }
        
        translate([0, 0, 0]) {  
           ramp();
        }
        translate([44,32.44+20,0]) {
            rotate([0,0,180]) {
                ramp();
            }
        }
    }
}