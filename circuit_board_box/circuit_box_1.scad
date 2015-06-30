$inch = 25.4;
$half = $inch/2;
$quarter = $inch/4;
$eigth = $inch/8;
$sixteenth = $inch/16;
$thirtysecondth = $inch/32;

$fn=128;

$cut_away = 0;

$box_x = 100;
$box_y = 100;
$box_z = 15;
$wall = 4;
$inset = 2;
$tab_x=10;
$tab_y=10;
$screw_d=3;
$screw_r=1;

module make_hollow_box() {
      
    difference() {
        // raw box block
        cube([$box_x, $box_y, $box_z]);
        // inner hollow
        translate([$wall, $wall, $wall]) {
            cube([$box_x-(2*$wall), $box_y-(2*$wall), $box_z]);
        }
        translate([$wall-$inset, $wall-$inset, $box_z -($wall/2)]) {
            cube([$box_x-(2*($wall-$inset)), $box_y-(2*($wall-$inset)), $wall]);
        }
        // tabs
        translate([$box_x/2 - $tab_x/2, -0.2, $box_z-$wall/2]) {
            cube([$tab_x,$box_y+0.4,$wall/2+0.1]);
        } 
        translate([-0.1, $box_y/2-$tab_y/2,$box_z-$wall/2]) {
            cube([$box_x+0.2,$tab_y + 0.2,$wall]);
        }
        //tab screw holes
        translate([$wall/2,$box_y/2,$box_z - ($wall/2+$screw_d-0.1)]) {
            cylinder(r=$screw_r, h=$screw_d + 0.1);
        }
        translate([$box_x-($wall/2),$box_y/2,$box_z - ($wall/2+$screw_d-0.1)]) {
            cylinder(r=$screw_r, h=$screw_d + 0.1);
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

$so_inset_x=10;
$so_inset_y=25;
module make_standoffs() {
    translate([$wall+$so_inset_x, 
               $wall+$so_inset_y, 
               $wall-1]) {
        make_standoff();
    }
    translate([$box_x-($wall+$so_inset_x), 
               $wall+$so_inset_y, 
               $wall-1]) {
        make_standoff();
    }
    translate([$wall+$so_inset_x, 
               $box_y-($wall+$so_inset_y), 
               $wall-1]) {
        make_standoff();
    }
    translate([$box_x-($wall+$so_inset_x), 
               $box_y-($wall+$so_inset_y), 
               $wall-1]) {
        make_standoff();
    }
}

module make_lid() {
    difference() {
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
       //tab screw holes
       translate([$wall/2,$box_y/2,0]) {
           cylinder(r=$screw_r + 0.25, h=2*$screw_d + 0.1);
       }
       translate([$box_x-($wall/2),$box_y/2,0]) {
           cylinder(r=$screw_r + 0.25, h=2*$screw_d + 0.1);
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

