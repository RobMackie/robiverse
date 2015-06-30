$inch = 25.4;
$half = $inch/2;
$quarter = $inch/4;
$eigth = $inch/8;
$sixteenth = $inch/16;
$thirtysecondth = $inch/32;

$fn=128;

$cut_away = 0;

$box_x = 75;
$box_y = 60;
$box_z = 15;
$wall = 4;
$inset = 2;
$tab_x=10;
$tab_y=10;

module make_hollow_box() {
      
    difference() {
        cube([$box_x, $box_y, $box_z]);
        translate([$wall, $wall, $wall]) {
            cube([$box_x-(2*$wall), $box_y-(2*$wall), $box_z]);
        }
        translate([$wall-$inset, $wall-$inset, $box_z -($wall/2)]) {
            cube([$box_x-(2*($wall-$inset)), $box_y-(2*($wall-$inset)), $wall]);
        }
        translate([$box_x/2 - $tab_x/2, -0.2, $box_z-$wall/2]) {
            cube([$tab_x,$box_y+0.4,$wall/2+0.1]);
        } 
        translate([-0.1, $box_y/2-$tab_y/2,$box_z-$wall/2]) {
            cube([$box_x+0.2,$tab_y + 0.2,$wall]);
        }
    }
}

$standoff_h=6;
$standoff_r=4;
$bolt_r=1.5;
$bolt_h=3;
module make_standoff() {
    difference() {
        cylinder(r=$standoff_r, h=$standoff_h);
        translate([0,0,$standoff_h-$bolt_h]) {
             cylinder(r=$bolt_r, h=$bolt_h + 0.1);
        }
    }
}

$so_inset=10;
module make_standoffs() {
    translate([$wall+$so_inset, 
               $wall+$so_inset, 
               $wall-1]) {
        make_standoff();
    }
    translate([$box_x-($wall+$so_inset), 
               $wall+$so_inset, 
               $wall-1]) {
        make_standoff();
    }
    translate([$wall+$so_inset, 
               $box_y-($wall+$so_inset), 
               $wall-1]) {
        make_standoff();
    }
    translate([$box_x-($wall+$so_inset), 
               $box_y-($wall+$so_inset), 
               $wall-1]) {
        make_standoff();
    }
}

module make_lid() {
    union() {
        cube([$box_x, $box_y, $wall/2]);
        translate([$wall-$inset,$wall-$inset,$wall/2]) {
	        cube([$box_x-(2*$inset), 
	              $box_y-(2*$inset),
	              $wall/2]);
        }
        translate([$box_x/2-$tab_x/2,0,$wall/2]) {
            cube([$tab_x,$box_y,$wall/2]);
        }
        translate([0, $box_y/2-$tab_y/2,$wall/2]) {
            cube([$box_x, $tab_y, $wall/2]);
        }
    }
}

module make_parts() {
   union() {
        make_hollow_box();
        make_standoffs();
   }
   translate([0,$box_y + 5,0]) {
       make_lid();
   }
}


$2d = 0;
if ($2d) {
    projection(cut=true) {
       translate([0,0,0]) rotate([0,0,0]) {
         make_parts();
       }
}
} else {
    make_parts();
//  for measuring and calibrating
//    translate([60,40,0]) {
//      cube([20,5,1]);
//    }
}

