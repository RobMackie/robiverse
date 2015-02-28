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

module make_servo_pattern(hole_radius, hole_w, hole_l) {
   $body_h = hole_w + 6;
   $body_l = hole_l - 8;
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
      translate([4,-1,-2]) {
         cube([$body_l,7, $body_h]);
      }
   }
}

module make_one_arm(length, width, height) {
   translate([0,5,0]) {
	   difference() {
	      cube([length, width, height]);
	      translate([-1,5,5]) {
	         cube([length + 2, width - 4, height  - 4]);
	      }
         translate([145,0,7]) {
            make_servo_pattern(1.5,20,50);
         }
	   }
   }    
}

module make_parts() {
   difference() {
	   union() {
		   rotate([0,0,0]) {
		      make_one_arm(200, 20, 40);
		   }
		   rotate([0,0,120]) {
		      make_one_arm(200, 20, 40);
		   }
		   rotate([0,0,240]) {
		      make_one_arm(200, 20, 40);
		   }
         cylinder(r=150, h=5);
	   }
      translate([0,0,5]) {
         cylinder(r=20, h=420);
      }
      rotate([0,0,60]) {
         translate([90,0,-1]) {
            cylinder(r=1.5, h=6);
         }
      }
      rotate([0,0,180]) {
         translate([90,0,-1]) {
            cylinder(r=1.5, h=6);
         }
      }      rotate([0,0,300]) {
         translate([90,0,-1]) {
            cylinder(r=1.5, h=6);
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
