$inch = 25.4;
$half = $inch/2;
$quarter = $inch/4;
$eigth = $inch/8;
$sixteenth = $inch/16;
$thirtysecondth = $inch/32;

$slot_width = 3;

$fan_x = 40;
$fan_y = 40;
$fan_z = 2;
$bolt_inset = 4;
$bolt_radius = 2;
$fan_cav_radius = 18;

$cone_height = 65;

$fn=128;

$angle=5;
$cut_away = 1;
module make_parts() {
   union() {
		translate([0,0,0]) {
         difference() {
            hull() {
	            cube([$fan_x, 10, 2]);
			      translate([0,0,0]) {
			          rotate([$angle,0,0]) {
			              cube([$fan_x, 10, 4]);
			          }
			      }
            }
            translate([0,0,-2]) {
	            rotate([$angle,0,0]) {
		            translate([$bolt_inset,5,-1]) {
		               cylinder(r=$bolt_radius, h=10);
		            }
		            translate([$fan_x - $bolt_inset,5,-1]) {
		               cylinder(r=$bolt_radius, h=10);
		            }
		            translate([$bolt_inset,5,-1]) {
		               cylinder(r=$bolt_radius+2, h=3);
		            }
		            translate([$fan_x - $bolt_inset,5,-1]) {
		               cylinder(r=$bolt_radius+2, h=3);
		            }
	            }
            }
         }
      }
      translate([0,10,0]) {
		   difference() {
			   union() {
				   make_fan_face();
				   translate([$fan_x/2, $fan_y/2, 0]) {
				   	make_cone();
				   }
			   }
			   if ($cut_away) {
					translate([0,0,45]) {
				       cube([50,50,70]);
				   }
				}
		   }
      }
   }
}

module make_fan_face() {
   difference() {
		cube([$fan_x,$fan_y,$fan_z]);

		// main cavity for air flow
      translate([$fan_x/2,$fan_y/2+.5,-1]) {
      	cylinder(r=$fan_cav_radius-1+2, h=$fan_z+2);
      }
		//  x-min, y-min
      translate([$bolt_inset,$bolt_inset,-1]) {
      	cylinder(r=$bolt_radius, h=$fan_z+2);
      }
      translate([$fan_x-$bolt_inset,
                 $bolt_inset,
                 -1]) {
      	cylinder(r=$bolt_radius, h=$fan_z+2);
      }
      translate([$bolt_inset,
                 $fan_y-$bolt_inset,
                 -1]) {
      	cylinder(r=$bolt_radius, h=$fan_z+2);
      }
      translate([$fan_x-$bolt_inset,
                 $fan_y-$bolt_inset,
                 -1]) {
      	cylinder(r=$bolt_radius, h=$fan_z+2);
      }
   }
}

module make_cone() {
   difference() {
		hull() {
      	cylinder(r=$fan_cav_radius+2.5, h=1);
			translate([0, 
                   $fan_x/4+15, 
                   $cone_height]) {
				cylinder(r=5, h=1);
			} 
      }
      translate([0,-2,-6]) {
		hull() {
	      	cylinder(r=$fan_cav_radius+2.5, h=1);
				translate([0,
                      $fan_x/4+17,  
	                   $cone_height+7]) {
					cylinder(r=3, h=1);
				} 
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
    make_parts();
//  for measuring and calibrating
//    translate([60,40,0]) {
//      cube([20,5,1]);
//    }
}

