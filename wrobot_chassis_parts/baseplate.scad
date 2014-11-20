use <../libs/bearing_mount_lib.scad>

$inch = 25.4;
$half = $inch/2;
$quarter = $inch/4;
$eigth = $inch/8;
$sixteenth = $inch/16;
$thirtysecondth = $inch/32;

$slab_width = 80;
$slab_length = 135;
$hole_space = 48;
$hole_length = 8;
$hole_diam = 4;
$left_bolt = $slab_width/2 - $hole_space/2 - $hole_length/2; 
$rite_bolt = $slab_width/2 + $hole_space/2 - $hole_length/2;
$rear_wheel_slot = 18;
$rear_wheel_diam = 40;

module end_plate(width, length) {
   union() {
      translate([0,3,0]) {
         cube([$slab_width,25, $eigth]);
      }
	   translate([($slab_width/3)-length/2,0,0]) {
	      cube([length,width,$eigth]);
	   }
	   translate([(2*$slab_width/3)-length/2,0,0]) {
	      cube([length,width,$eigth]);
	   }
	   translate([($slab_width/3)-length/2,28,0]) {
	      cube([length,width,$eigth]);
	   }
	   translate([(2*$slab_width/3)-length/2, 28,0]) {
	      cube([length, width,$eigth]);
	   }
   }
}

module slots(width, length) {
   translate ([0,$slab_length/4 - length/2,-1]) {
      cube([width,length, $eigth+2]);
   }
   translate ([0,2*($slab_length/4)-length/2,-1]) {
      cube([width,length, $eigth+2]);
   }
   translate ([0,3*($slab_length/4)-length/2,-1]) {
      cube([width,length, $eigth+2]);
   }
}
module end_slots(width, length) {
   translate([($slab_width/3)-length/2,0,-1]) {
      cube([length,width,$eigth+2]);
   }
   translate([(2/3*$slab_width)-length/2,0,-1]) {
      cube([length,width,$eigth+2]);
   }
}

module tabs(width, length) {
   translate ([0,$slab_length/4 - length/2,0]) {
      cube([width,length, $eigth]);
   }
   translate ([0,2*($slab_length/4)-length/2,0]) {
      cube([width,length, $eigth]);
   }
   translate ([0,3*($slab_length/4)-length/2,0]) {
      cube([width,length, $eigth]);
   }
}

module side_plate() {
   difference () {
	   union() {
	      translate([3,6,0]) {
	         cube([25,$slab_length-6,$eigth]);
	      }
	      translate([0,0,0]) {
	         tabs(3,10);
	      }
	      translate([28,0,0]) {
	         tabs(3,10);
	      }
	   }
      translate([12.5+3,$slab_length-15,-1]) {
         cylinder(r=$eigth,h=$eigth+2);
      }
      translate([12.5+3,24,-1]) {
         cylinder(r=3,h=$eigth+2);
      }
   }
}

module main_plate() {
	difference () {
	   cube([$slab_width,$slab_length,$eigth]);
	   // bolt holes:
	   translate([$left_bolt,30,-1]) {
	      mitered_box_x($hole_diam,$hole_length,$eigth+2);
	   }
	   translate([$rite_bolt,30,-1]) {
	      mitered_box_x($hole_diam,$hole_length,$eigth+2);
	   }
	   // rear wheel well
	   translate([$slab_width/2 - $rear_wheel_slot/2, 
	              $slab_length-$rear_wheel_diam,
	              -1]) {
	      cube([$rear_wheel_slot, $rear_wheel_diam,$eigth+2]);
	   }
	   // mounts for vertical spacers
      translate([3,0,0]) {
	      slots(3,10);
      }
      translate([$slab_width-6,0,0]) {
	      slots(3,10);
      }
      translate([0,3,0]) {
         end_slots(3,10);
      }
   }
}

module top_plate() {
	difference () {
	   cube([$slab_width,$slab_length,$eigth]);
	   // mounts for vertical spacers
      translate([3,0,0]) {
	      slots(3,10);
      }
      translate([$slab_width-6,0,0]) {
	      slots(3,10);
      }
      translate([20,20,-1]) {
          duemilanove_hole_pattern_y($eigth+2);
      }
      translate([0,3,0]) {
         end_slots(3,10);
      }
	   // rear wheel well
	   translate([$slab_width/2 - $rear_wheel_slot/2, 
	              $slab_length-$rear_wheel_diam,
	              -1]) {
	      cube([$rear_wheel_slot, $rear_wheel_diam,$eigth+2]);
	   }
   }
}

module make_parts() {
	main_plate();
	translate([$slab_width+4,0,0]) {
	   side_plate();
	}
	translate([$slab_width+4 + 35 ,0,0]) {
	   side_plate();
	}
	translate([$slab_width+4 + 35+35 ,0,0]) {
	   top_plate();
	}

	translate([0,$slab_length+5,0]) {
	   end_plate(3,10);
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
}

