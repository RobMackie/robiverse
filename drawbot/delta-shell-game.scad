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

$arm_len = 250;
$hole_h = 25;
$hole_w = 30;

$top_disk = 150;


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

module make_one_arm(length, width, height) {
   translate([0,11.68+(3.05*2),0]) {
	   difference() {
	      cube([length, width, height]);
	      translate([-1,5,5]) {
	         cube([length + 2, width - 4, height  - 4]);
	      }
         translate([length-55,0,7]) {
            make_servo_pattern(2,10.17,47.26);
         }
	   }
   }    
}

module make_parts(len, h, w) {
   difference() {
	   union() {
		   rotate([0,0,0]) {
		      make_one_arm($arm_len, $hole_h, $hole_w);
		   }
		   rotate([0,0,120]) {
		      make_one_arm($arm_len, $hole_h, $hole_w);
		   }
		   rotate([0,0,240]) {
		      make_one_arm($arm_len, $hole_h, $hole_w);
		   }
         cylinder(r=$top_disk, h=5);
	   }
      translate([0,0,5]) {
         cylinder(r1=20, r2=200, h=$hole_h*1.2);
      }
      rotate([0,0,60]) {
         translate([$top_disk-15,0,-1]) {
            cylinder(r=1.5, h=7);
         }
      }
      rotate([0,0,180]) {
         translate([$top_disk-15,0,-1]) {
            cylinder(r=1.5, h=7);
         }
      }      rotate([0,0,300]) {
         translate([$top_disk-15,0,-1]) {
            cylinder(r=1.5, h=7);
         }
      }
   }
}

if ($2d) {
    projection(cut=true) {
       translate([0,0,0]) rotate([0,0,0]) {
         make_parts(200, 20, 40);
       }
    }
} else {
    make_parts();
//  for measuring and calibrating
//    translate([60,40,0]) {
//      cube([20,5,1]);
//    }
}
