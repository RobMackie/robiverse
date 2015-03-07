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

$arm_len = 110;
$arm_h = 30;
$arm_w = 22.25;

$top_disk_r = 40;
$top_disk_h = 5;

// servo mount parameters
// $vertical_hole_distance = 
// $horizontal_hole_distance =
// $body_horizontal =
// $body_vertical =
// $plate_horizontal =
// $plate_vertical =

module make_servo_pattern(hole_radius, hole_w, hole_l) {
   $body_h = hole_w + 6;
   $body_l = hole_l - 3.69 * 2;
   translate ([0,0,-2+4.825]) {
	   union() {
	      translate([0,7,0]) {
	         rotate([90,0,0]) {
	            translate([0,0,0]) {
	               cylinder(r=hole_radius, h=8);
	            }
	            translate([0,hole_w,0]) {
	               cylinder(r=hole_radius, h=8);
	            }
	            translate([hole_l,0,0]) {
	               cylinder(r=hole_radius, h=8);
	            }
	            translate([hole_l,hole_w,0]) {
	               cylinder(r=hole_radius, h=9);
	            }
	         }
	      }
	      translate([3.69,-1,-4.825]) {
	         cube([$body_l,7, $body_h+4.825]);
	      }
	   }
	}
}

$triangle=3;
module make_one_arm(length, height, width) {
   translate([0,11.68+(3.05*2),0]) {
      union() {
	      difference() {

	         cube([length, width, height-5]);
	         translate([-1,5,5]) {
	            cube([length + 2, width - 4, height  - 4]);
	         }
            translate([length-55,0,7]) {
               make_servo_pattern(2,10.17,47.26);
            }
// bolt hole for openbeam
            translate([length-8,12.5,-1]) {
               cylinder(r=1.5, h=7);
            }
// bolt hole for mounting to plate
            translate([length-70,12.5,-1]) {
               cylinder(r=1.5, h=7);
            }
// bolt hole for mounting to plate
            translate([length-100,12.5,-1]) {
               cylinder(r=1.5, h=7);
            }
	      }
// outer triangle
         translate([length-5,2,2]) {
            hull() {
               translate([2,2,2]) {
                  rotate([0,90,0]) {
                     cylinder(r=2, h=$triangle);
                  }
               }
               translate([2,width-4,2]) {
                  rotate([0,90,0]) {
                     cylinder(r=2, h=$triangle);
                  }
               }
               translate([2,2,height-10]) {
                  rotate([0,90,0]) {
                     cylinder(r=2, h=$triangle);
                  }
               }
            }
         }
         // inner triangle
         translate([length-65,2,2]) {
            hull() {
               translate([2,2,2]) {
                  rotate([0,90,0]) {
                     cylinder(r=2, h=$triangle);
                  }
               }
               translate([2,width-4,2]) {
                  rotate([0,90,0]) {
                     cylinder(r=2, h=$triangle);
                  }
               }
               translate([2,2,height-10]) {
                  rotate([0,90,0]) {
                     cylinder(r=2, h=$triangle);
                  }
               }
            }
         }
      
         // innermost triangle
         translate([length-112,2,2]) {
            hull() {
               translate([2,2,2]) {
                  rotate([0,90,0]) {
                     cylinder(r=2, h=$triangle);
                  }
               }
               translate([2,width-4,2]) {
                  rotate([0,90,0]) {
                     cylinder(r=2, h=$triangle);
                  }
               }
               translate([2,2,height-10]) {
                  rotate([0,90,0]) {
                     cylinder(r=2, h=$triangle);
                  }
               }
            }
         }
      }
   }    
}

module make_parts() {
   translate([-50,0,0]) {
      make_one_arm($arm_len, $arm_h, $arm_w);
   }
/*
   difference() {
	   union() {
		   rotate([0,0,0]) { // x arm
		      make_one_arm($arm_len, $arm_h, $arm_w);
		   }
		   rotate([0,0,120]) {
		      make_one_arm($arm_len, $arm_h, $arm_w);
		   }
		   rotate([0,0,240]) {
		      make_one_arm($arm_len, $arm_h, $arm_w);
		   }
         cylinder(r=$top_disk_r, h=$top_disk_h);
	   }
      translate([0,0,14]) {
         cylinder(r1=5, r2=$top_disk_r, h=$arm_h - $top_disk_h );
      }
*/
/*  no longer need post mout holes, because they are in the 
    arms now.

      rotate([0,0,60]) {
         translate([$top_disk_r-8,0,-1]) {
            cylinder(r=1.5, h=7);
         }
      }
      rotate([0,0,180]) {
         translate([$top_disk_r-8,0,-1]) {
            cylinder(r=1.5, h=7);
         }
      }      rotate([0,0,300]) {
         translate([$top_disk_r-8,0,-1]) {
            cylinder(r=1.5, h=7);
         }
      }

   }
*/
}

$bounding_box = 0; // show bounding box
if ($2d) {
    projection(cut=true) {
       translate([0,0,0]) rotate([0,0,0]) {
         make_parts();
       }
    }
} else {
   translate([-7,-12,0]) {
  	   make_parts();
   }
	if ($bounding_box) {
	   rotate([0,0,35]) {
		   translate([0,0,-1]) {
		      difference() {
			      translate([-77, -77, 0]) {
			         cube([154,154,1]);
			      }
			      translate([-76,-76,-1]) {
			         cube([152,152,3]);
			      }	
			   }
			}
	   }
	}
}
