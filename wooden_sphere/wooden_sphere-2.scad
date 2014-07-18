use <../libs/bearing_mount_lib.scad>

$inch = 25.4;
$half = $inch/2;
$quarter = $inch/4;
$eigth = $inch/8;
$sixteenth = $inch/16;
$thirtysecondth = $inch/32;

$slot_width = 3;

$rotating_slots = 2;

$fn=128;

module make_parts() {
   translate([10,2.5,0]){
      make_full_circle_with_slots(30, 18, 14);
   }
   translate([85,15,0]) {
      exterior_half_circle_y(40,10,14);
   } 
   translate([0,65,0]) {
      for (v = [0:3]) {
         for (h = [0:1]) {
            translate([85 * h,45*v,0]) {
               exterior_half_circle_y(40,10,14);
            } 
         }
      }
   }
}

module exterior_half_circle_y(radius, center, slot) {
    difference() {
       translate([0, 0, 0]) {
          half_circle_y(radius);
       }
       translate([radius-(radius/3),center,-1]) {
          cube([$slot_width,center,$eigth+2]);
       }
       translate([radius+(radius/3)-$slot_width,center,-1]) {
          cube([$slot_width,center,$eigth+2]);
       }
       translate([2*radius/3, -1, -1]) {
          cube([2*radius/3,center+1.1,$eigth+2]);
       }
       translate([0,-1,-1]) {
          cube([2*radius,2+1,$eigth+2]);
       }
   }
}

module make_full_circle_with_slots(radius, slots, slot_len) {
   $slot_c = slots;
   $degrees = 360/slots;
   translate([radius, radius, 0]) {
      difference() {
         cylinder(r=radius, h=$eigth);
         for (i = [0 : $slot_c - 1])  {
            rotate(a=(i * $degrees), v = [0,0,1]) {
               translate([radius - slot_len,-1.5,-1]) {
                  cube([slot_len,3,$eigth+2]);
               }
           }
         }
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

