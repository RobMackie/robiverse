$inch = 25.4;
$half = $inch/2;
$quarter = $inch/4;
$eigth = $inch/8;
$sixteenth = $inch/16;
$thirtysecondth = $inch/32;

$fn=128;

$cut_away = 0;

$make_lid=1;
$make_box=1;


// Wall thickness for box (walls, top, bottom)
$wall = 4;
// clearance from center of standoff to inside of wall
$so_inset_x=25;
$so_inset_y=30;

// distance between centers on the standoffs (so)
$so_x_delta=95.5;
$so_y_delta=53.5;

// dimensions of box, given circuit board
$box_x = $so_x_delta+(2*$so_inset_x)+(2*$wall);
$box_y = $so_y_delta+(2*$so_inset_y)+(2*$wall);
// exterior total height of box subtracr wall twice for interior
$box_z = 30;

// stuff for lid
$inset = 2;
$tab_x=10;
$tab_y=10;
$screw_d=3;
$screw_r=1;

$standoff_h=6;
$standoff_r=4;
$bolt_r=1.5;
$bolt_h=3;

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

module make_standoff() {
    difference() {
        cylinder(r=$standoff_r, h=$standoff_h);
        translate([0,0,$standoff_h-$bolt_h]) {
             cylinder(r=$bolt_r, h=$bolt_h + 0.1);
        }
    }
}

module make_standoffs() {
    translate([0, 0, 0]) {
        make_standoff();
    }
    translate([$so_x_delta, 0, 0]) {
        make_standoff();
    }
    translate([0, $so_y_delta, 0]) {
        make_standoff();
    }
    translate([$so_x_delta, $so_y_delta, 0]) {
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
   difference() {
	   union() {
	        make_hollow_box();
	        translate([$so_inset_x+$wall, $so_inset_y+$wall, $wall-0.1]) {
	            make_standoffs();
	        }
	   }
      translate([$box_x/3, -1, 15]) {
			rotate([0,90,90]) {
				cylinder(r=10, h=6);
			}
      }
      translate([2*$box_x/3, $box_y-$wall-1, 15]) {
			rotate([0,90,90]) {
				cylinder(r=6, h=6);
			}
      }
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
	if ($make_box){ 
	   make_parts();
	}
   if ($make_lid && $make_box) {
		translate([0,$box_y + 5,0]) {
	       make_lid();
	   }
	} else {
		make_lid();
   }
//  for measuring and calibrating
//    translate([60,40,0]) {
//      cube([20,5,1]);
//    }
}

