// openscad = http://www.openscad.org/downloads.html

$2d = 0;  // Openscad directions:
          // set this to "$2d = 1;" to get a profile for a dxf
          // then go to menu option "Design" and choose
          // "Compile and Render" then when you get the flat
          // drawing, go to "Design" and choose export as dxf
          // or set "$2d = 0"; and "Export as STL"

// Conveniences:
$inch = 25.4;
$half = $inch/2;
$quarter = $inch/4;
$eigth = $inch/8;
$sixteenth = $inch/16;
$thirtysecondth = $inch/32;

$height=5;
$main_radius=50;

$fn=128;

module make_parts() {
   difference() {
	   union () {
			translate([0,0,0]) {
		      union() {
			      cylinder(r=$main_radius, h=$height);
		//	      cylinder(r=78, h=1);
		      }
		   }
			translate([45,0,0]) {
		      rotate([0,0,0]) {
			      union([0,0,0]) {
						translate([0,-3,0]) {
		               union() {
		                  cube([30,20,5]);
		                  cube([30,4,30]);
		               }
		            }
		         }
		      }
		   }
		   translate([0,52,0]) {
		      rotate([0,0,120]) {
			      union([0,0,0]) {
						translate([0,22,0]) {
		               union() {
		                  cube([30,20,5]);
		                  cube([30,4,30]);
		               }
		            }
		         }
		      }
		   }
		   translate([0,-52,0]) {
		      rotate([0,0,-120]) {
			      union([0,0,0]) {
						translate([0,-30,0]) {
		               union() {
		                  cube([30,20,5]);
		                  cube([30,4,30]);
		               }
		            }
		         }
		      }
		   }
	   }
      // holes for 3 mounting posts in openbeam
      rotate([0,0,60]) {
	      translate([42,0,-1]) {
           cylinder(r=1.5, h=10);
	      }
      }
      rotate([0,0,180]) {
	      translate([42,0,-1]) {
	         cylinder(r=1.5, h=10);
	      }
      }
      rotate([0,0,300]) {
	      translate([42,0,-1]) {
	         cylinder(r=1.5, h=10);
	      }
      }
      // holes for mounting servos x
      rotate([0,0,0]) {
	      translate([50,6,10]) {
            rotate([90,0,0]) {
	            cylinder(r=3, h=10);
            }
	      }
	      translate([50,6,20]) {
            rotate([90,0,0]) {
	            cylinder(r=3, h=10);
            }
	      }
      }
      rotate([0,0,0]) {
	      translate([68,6,10]) {
            rotate([90,0,0]) {
	            cylinder(r=3, h=10);
            }
	      }
	      translate([68,6,20]) {
            rotate([90,0,0]) {
	            cylinder(r=3, h=10);
            }
	      }
      }
      // holes for mounting servos y
      rotate([0,0,119]) {
	      translate([50,6,10]) {
            rotate([90,0,0]) {
	            cylinder(r=3, h=10);
            }
	      }
	      translate([50,6,20]) {
            rotate([90,0,0]) {
	            cylinder(r=3, h=10);
            }
	      }
      }
      rotate([0,0,119]) {
	      translate([68,6,10]) {
            rotate([90,0,0]) {
	            cylinder(r=3, h=10);
            }
	      }
	      translate([68,6,20]) {
            rotate([90,0,0]) {
	            cylinder(r=3, h=10);
            }
	      }
      }
      // holes for mounting servos z
      rotate([0,0,239]) {
	      translate([50,6,10]) {
            rotate([90,0,0]) {
	            cylinder(r=3, h=10);
            }
	      }
	      translate([50,6,20]) {
            rotate([90,0,0]) {
	            cylinder(r=3, h=10);
            }
	      }
      }
      rotate([0,0,239]) {
	      translate([68,6,10]) {
            rotate([90,0,0]) {
	            cylinder(r=3, h=10);
            }
	      }
	      translate([68,6,20]) {
            rotate([90,0,0]) {
	            cylinder(r=3, h=10);
            }
	      }
      }
   }
}

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
