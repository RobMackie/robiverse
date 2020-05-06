
$inch = 25.4;
$total_height = 110;
$back_height = 70;
$h_rail_1 = $total_height - 6;
$h_rail_2 = $h_rail_1 - 56;
$wide = 45;
$main_plate = 1;
$back_plate = 1;
module car () {
    difference() {
        union() {
            if ($main_plate) {
                cube([$inch/4,$wide,110]);
            }
            if ($back_plate) {
                translate([18,0,$total_height-$back_height]) {
                    cube([$inch/4,$wide,$back_height]);
                }
            }
        }
        // bearing recesses (top)
        translate([12,46,$h_rail_1]) { // translation to position
            rotate([90,0,0]) {
                cylinder(r=7.5, h=47, $fn=64);
                
            }
        }
        // bearing recesses (bottom)
        translate([12,46,$h_rail_2]) { // translation to position
            rotate([90,0,0]) {
                cylinder(r=7.5, h=47, $fn=64);
                
            }
        }  
        // bolts to hold the two plates together
        translate([-1, $wide/3, $total_height - $back_height/2]) {
            rotate([0,90,0]) {
               cylinder(r=2, h=60, $fn=16);
            }
        } 
        // bolts to hold the two plates together
        translate([-1, $wide/3 * 2, $total_height - $back_height/2]) {
            rotate([0,90,0]) {
               cylinder(r=2, h=60, $fn=16);
            }
        }  
    }
}



module assembly() {
    union() {
        car();
    }
}

$left_nema=6;
$up_nema=5;
$nema17_offset=31;
  
module final() {
    difference() {
        assembly();
        translate([-50,$left_nema, $nema17_offset+$up_nema]) {
            rotate([0,90,0]) {
                cylinder(r=1.5, h=60, $fn=16);
            }
        }
        // nema holes
        translate([-50,$left_nema, $up_nema]) {
            rotate([0,90,0]) {
                cylinder(r=1.5, h=60, $fn=16);
            }
        }
        translate([-50,$nema17_offset+$left_nema, $nema17_offset+$up_nema]) {
            rotate([0,90,0]) {
                cylinder(r=1.5, h=60, $fn=16);
            }
        }
        translate([-50, $nema17_offset+$left_nema, $up_nema]) {
            rotate([0,90,0]) {
                cylinder(r=1.5, h=60, $fn=16);
            }
        }       
    }
}

final();