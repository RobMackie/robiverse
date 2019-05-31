$fn=64;
$bevel=15;
$thick=3.125;
$size=150;
$offset=$size-(2*$bevel);

$body_style_norm = 0;
$body_style_wrobot = 1;
$body_style_min = 2;

$body_style = 0;

$flat_for_svg = 0;

module body() {
    hull() {
        translate([$bevel,$bevel,0]) {
            cylinder(r=$bevel, h=$thick);
        }
        
        translate([$bevel,$offset+$bevel,0]) {
            cylinder(r=$bevel, h=$thick);
        }
        
        translate([$offset+$bevel,$bevel,0]) {
            cylinder(r=$bevel, h=$thick);
        }
        
        translate([($offset+$bevel),($offset+$bevel),0]) {
            cylinder(r=$bevel, h=$thick);
        }
    }
} 

module body_min() {
    hull() {
        translate([$bevel,$bevel,0]) {
            cylinder(r=$bevel, h=$thick);
        }
        
        translate([$bevel,$offset/2+$bevel,0]) {
            cylinder(r=$bevel, h=$thick);
        }
        
        translate([$offset+$bevel,$bevel,0]) {
            cylinder(r=$bevel, h=$thick);
        }
        
        translate([($offset+$bevel),($offset/2+$bevel),0]) {
            cylinder(r=$bevel, h=$thick);
        }
    }
}

module body_alt() {
    difference() {
        hull() {
            translate([$bevel,$bevel,0]) {
                cylinder(r=$bevel, h=$thick);
            }
            
            translate([$bevel,$offset/2+$bevel,0]) {
                cylinder(r=$bevel, h=$thick);
            }
            
            translate([$offset+$bevel,$bevel,0]) {
                cylinder(r=$bevel, h=$thick);
            }
            
            translate([($offset+$bevel),($offset/2+$bevel),0]) {
                cylinder(r=$bevel, h=$thick);
            }
            
            translate([($offset+$bevel)/2,1.5*($offset+$bevel),0]) {
                cylinder(r=$bevel, h=$thick);
            }        
        }
        translate([($offset+$bevel)/2,1.4*($offset+$bevel),-1]) {
                cylinder(r=5, h=$thick+2);
            }  
    }
}    

module waveshare_mount_holes() {
    $mount_bolt_d = 3;
    translate([0,0,]) {
        cylinder(d=$mount_bolt_d, h=10);
    } 
    translate([0,28,0]) {
        cylinder(d=$mount_bolt_d, h=10);
    } 
    translate([57,0,0]) {
        cylinder(d=$mount_bolt_d, h=10);
    } 
    translate([57,28,0]) {
        cylinder(d=$mount_bolt_d, h=10);
    }    
}

module wheels_and_mounts() {
    // wheel well left
        translate([13.8,18.9,0]) {
            cube([14.2,66,10]);
        }
    // wheel well right
        translate([101,18.9,0]) {
            cube([14.2,66,10]);
        }   
    // zip tie bottom left
        translate([0,34.3,0]) {
            cylinder(d=6, h=5);
        } 
    // zip tie top left
        translate([0,73.6,0]) {
            cylinder(d=6, h=5);
        } 
    // zip tie bottom right
        translate([128.9,34.3,0]) {
            cylinder(d=6, h=5);
        } 
    // zip tie top right 
        translate([128.9,73.6,0]) {
            cylinder(d=6, h=5);
        }

    // waveshare bracket
        translate([36,24,0]) {
            waveshare_mount_holes();
        }
}
module finished() {
    /* // Calibration marks
    translate([0,34,0]) {
        cube([24.33,1,10]);
    }    
    translate([150-24.33,34,0]) {
        cube([24.33,1,10]);
    }
    */
    difference() {
        if ($body_style == 0) {
            body(); 
        } else if ($body_style == 1) {
            body_alt();
        } else if ($body_style == 2) {
            body_min();
        }
        translate([10.5, 0, -1]) {
           wheels_and_mounts(); 
        }
    }
}


if ($flat_for_svg) {
    projection(cut=true) {
        translate([0,0,-1]) rotate([0,0,0]) {
            finished();
        }
    }
} else {
    finished();
}