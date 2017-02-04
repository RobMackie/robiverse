
$inch = 25.4;
$total_height = 110;
$back_height = 70;
$h_rail_1 = $total_height - 6;
$h_rail_2 = $h_rail_1 - 56;
$wide = 45;


module car () {
    difference() {
        union() {
            cube([$inch/4,$wide,110]);
            translate([18,0,$total_height-$back_height]) {
                cube([$inch/4,$wide,$back_height]);
            }
        }
        translate([12,46,$h_rail_1]) { // translation to position
            rotate([90,0,0]) {
                cylinder(r=7.5, h=47, $fn=64);
                
            }
        }
        translate([12,46,$h_rail_2]) { // translation to position
            rotate([90,0,0]) {
                cylinder(r=7.5, h=47, $fn=64);
                
            }
        }  
        translate([0, $wide/3, $total_height - $back_height/2]) {
            rotate([0,90,0]) {
               cylinder(r=2, h=50, $fn=16);
            }
        } 
        translate([0, $wide/3 * 2, $total_height - $back_height/2]) {
            rotate([0,90,0]) {
               cylinder(r=2, h=50, $fn=16);
            }
        }  
    }
}



module assembly() {
    union() {
        car();
        /*
        translate([-41.41, 0, 0]) {
            cube([43.41, 43.41, 43.41]);
        }
        */
    }
}

  
module final() {
    difference() {
        assembly();
        translate([-50,5, 41.41-5]) {
            rotate([0,90,0]) {
                cylinder(r=1.5, h=60, $fn=16);
            }
        }
        translate([-50,5, 5]) {
            rotate([0,90,0]) {
                cylinder(r=1.5, h=60, $fn=16);
            }
        }
        translate([-50,41.41-5, 41.41-5]) {
            rotate([0,90,0]) {
                cylinder(r=1.5, h=60, $fn=16);
            }
        }
        translate([-50, 41.41-5, 5]) {
            rotate([0,90,0]) {
                cylinder(r=1.5, h=60, $fn=16);
            }
        }        
    }
}

final();