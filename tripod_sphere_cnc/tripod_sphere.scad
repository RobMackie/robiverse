$inch = 25.4;
$half = $inch/2;
$quarter = $inch/4;
$eigth = $inch/8;
$sixteenth = $inch/16;
$thirtysecondth = $inch/32;

$slot_width = 2.5; // was 2.2 (too small)
$height = 2;


$fn=128;

module make_parts() {
   // make_exterior_bounds(152.4,152.4);

   translate([0,2,0]) {
	   translate([5,2.5,0]){
	      make_full_circle_with_slots(11, 6, 4);
	   }
	   translate([41,2.5,0]){
	      make_full_circle_with_slots(11, 6, 4);
	   } 

      /*
	   translate([45,15,0]) {
	      exterior_half_circle_y(15,3,4);
	   } 
      */
	   translate([5,35,0]) {
	      for (v = [0:2]) {
	         for (h = [0:1]) {
	            translate([35 * h,17*v,0]) {
	               exterior_half_circle_y(15,3,4);
	            } 
	         }
	      }
	   }
/*
      translate([42,35,0]) {
         make_leg();
      }
      translate([42,52,0]) {
         make_leg();
      }
      translate([42,68,0]) {
         make_leg();
      }
*/
   }
}

module make_leg() {
   exterior_half_circle_y(15,3,4);
   hull() {
      // top inset of foot
      translate([24,12,0]) {
         cylinder(r=1, h=$height);
      }
      //bottom inset of foot
      translate([30,1,0]) {
         cylinder(r=1, h=$height);
      }
      //bottom foot
      translate([50,15,0]) {
         cylinder(r=2, h=$height);
      }
  }   
}

module make_exterior_bounds(x, y) {
    difference () {
       cube([x,y,1]);
       translate([3, 3,-1]) {
           cube([x-2*3, y-2*3, 3]);
       }
    }
}

module exterior_half_circle_y(radius, center, slot) {
    difference() {
       translate([0, 0, 0]) {
          half_circle_y(radius);
       }
       // Left slot
       translate([radius-(radius/3),center-1.1,-1]) {
          cube([$slot_width,slot,$height+2]);
       }
       // right slot
       translate([radius+(radius/3)-$slot_width,center-1.1,-1]) {
          cube([$slot_width,slot,$height+2]);
       }
       // center inset rect (gift space)
       translate([2*radius/3, -1, -1]) {
          cube([2*radius/3,center,$height+2]);
       }
       // cut from bottom so that it's not a full half-circle
       translate([0,-1,-1]) {
          cube([2*radius,1,$height+2]);
       }
   }
}

module make_full_circle_with_slots(radius, slots, slot_len) {
   $slot_c = slots;
   $degrees = 360/slots;
   translate([radius, radius, 0]) {
      difference() {
         cylinder(r=radius, h=$height);
         for (i = [0 : $slot_c - 1])  {
            rotate(a=(i * $degrees), v = [0,0,1]) {
               translate([radius - slot_len,-1.5,-1]) {
                  cube([slot_len,$slot_width,$height+2]);
               }
           }
         }
      }
   }
}

module half_circle_y(radius) {
   translate([radius,0,0]) {
      difference() {
	      cylinder(r=radius, h=$height);
		   translate([-radius,-radius,-1]) {
		      cube([2*radius,radius,$height+2]);
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

