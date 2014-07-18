use <../libs/bearing_mount_lib.scad>

$inch = 25.4;
$half = $inch/2;
$quarter = $inch/4;
$eigth = $inch/8;
$sixteenth = $inch/16;
$thirtysecondth = $inch/32;

$slot_width = 3;

$rotating_slots = 2;

module exterior_half_circle_y(radius) {
    difference() {
       translate([0, 0, 0]) {
          half_circle_y(radius);
       }
       translate([radius-(radius/2),0,-1]) {
          cube([$slot_width,radius/8,$eigth+2]);
       }
       translate([radius+(radius/2)-$slot_width,0,-1]) {
          cube([$slot_width,radius/8,$eigth+2]);
       }
   }
}

module half_circle_y(radius) {
   translate([radius,0,0]) {
      difference() {
	      cylinder(r=radius, h=$eigth);
		   translate([-radius,-radius,-1]) {
		      cube([2*radius,radius,$eigth+2]);
		   }
	   }
   }
}

module interior_slots(radius, counter) {
    $count = counter+1;
    for (i = [1 : $count-1])  {
       translate([0,0,0]) {
	      translate([radius,0 ,-1]) {
	         rotate([0,0,180/$count * i+1 + -90]) {
	            translate([-1.5,0,0]) {
	               cube([$slot_width, radius, $eigth+2]);
	            }
	         }
	      }
      }
    }
}

module interior_half_circle_y(radius, slots) {
   union() {
      difference() {
         half_circle_y(radius);
         interior_slots(radius,slots);
      }
      translate([radius/4,0,0]) {
         half_circle_y(3*radius/4);
      }
   }
}

module make_parts() {
	translate([10,0,0]) {
	   interior_half_circle_y(30, $rotating_slots);
	}
	translate([100,0,0]) {
	   interior_half_circle_y(30, $rotating_slots);
	}

	translate([0,50,0]) {
      exterior_half_circle_y(40);
   }
	translate([90,50,0]) {
      exterior_half_circle_y(40);
   }
}

$2d = 1;
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

