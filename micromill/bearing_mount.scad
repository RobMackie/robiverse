$rail_w = 13; // how far apart do the inner periphery
              // of the bearings need to be - the thickness 
              // of an open beam profile?

$inch = 25.4;
$bearing_r = 11;
$nominal_bolt_r = ($inch * 5/16 * 0.5) + 0.2;
//          5/16 inch bolt size *radius+ slop
$bearing_hole_r =  $nominal_bolt_r;
$flat_thick = $inch/8;
$slot_w = 3;
$slot_l = 20;
$slot_inset = $bearing_hole_r;
$block_l = $rail_w + $bearing_r * 2 + $bearing_hole_r*4 + 40;

$vert = 120;

module bearing_mount_body () {
   union () {
      translate([0,$bearing_hole_r*2, 0]) {
		      cube([$bearing_hole_r*4, 
                $block_l,
                $flat_thick]);
      }
      translate([$bearing_hole_r*2,$bearing_hole_r*2,0]) {
            cylinder(r=$bearing_hole_r*2, h=$flat_thick);
      }
      translate([$bearing_hole_r*2,
                 $bearing_hole_r*2 + $block_l,0]) {
            cylinder(r=$bearing_hole_r*2, h=$flat_thick);
      }
   }
}

module bearing_mount () {
      difference () {
          bearing_mount_body();
          // lower bolt hole
          translate([$bearing_hole_r*2,
                    $bearing_hole_r*2 + ($block_l)/2 - 
                          ($rail_w/2 + $bearing_r),
                    -1]) {
              cylinder(r=$bearing_hole_r, h=$flat_thick+2);
          }
          // upper bolt hole
          translate([$bearing_hole_r*2,
                     $bearing_hole_r*2 + ($block_l)/2 + 
                         ($rail_w/2 + $bearing_r),
                     -1]) {
            cylinder(r=$bearing_hole_r, h=$flat_thick+2);
          }
          // lower slot
			translate([$bearing_hole_r*2 - $slot_w/2,
                    $slot_inset,
                    -1]) {
             cube([$slot_w, $slot_l, $flat_thick+2]); 
          }
          // upper slot
			translate([$bearing_hole_r*2 - $slot_w/2, 
                     $bearing_hole_r*2 + ($block_l) + 
                         $bearing_hole_r*2 - ($slot_l + 
                         $slot_inset),
                    -1]) {
             cube([$slot_w, $slot_l, $flat_thick+2]); 
          }


      }
}

$margin_space = 5;

module make_mounts () {
	translate([0,0,0]) {
		bearing_mount();
	}
	translate([$bearing_hole_r*4 + $margin_space,0,0]) {
		bearing_mount();
	}
	translate([2* ($bearing_hole_r*4 + $margin_space),0,0]) {
		bearing_mount();
	}
	translate([3* ($bearing_hole_r*4 + $margin_space),0,0]) {
		bearing_mount();
	}	
	translate([4* ($bearing_hole_r*4 + $margin_space),0,0]) {
		bearing_mount();
	}	
	translate([5* ($bearing_hole_r*4 + $margin_space),0,0]) {
		bearing_mount();
	}	
	translate([6* ($bearing_hole_r*4 + $margin_space),0,0]) {
		bearing_mount();
	}
	translate([7* ($bearing_hole_r*4 + $margin_space),0,0]) {
		bearing_mount();
	}	
	translate([8* ($bearing_hole_r*4 + $margin_space),0,0]) {
		bearing_mount();
	}	
	translate([9* ($bearing_hole_r*4 + $margin_space),0,0]) {
		bearing_mount();
	}	
	translate([10* ($bearing_hole_r*4 + $margin_space),0,0]) {
		bearing_mount();
	}	
	translate([11* ($bearing_hole_r*4 + $margin_space),0,0]) {
		bearing_mount();
	}	
	translate([12* ($bearing_hole_r*4 + $margin_space),0,0]) {
		bearing_mount();
	}	

	translate([0,$vert,0]) {
		bearing_mount();
	}
	translate([$bearing_hole_r*4 + $margin_space,$vert,0]) {
		bearing_mount();
	}
	translate([2* ($bearing_hole_r*4 + $margin_space),$vert,0]) {
		bearing_mount();
	}
	translate([3* ($bearing_hole_r*4 + $margin_space),$vert,0]) {
		bearing_mount();
	}	
	translate([4* ($bearing_hole_r*4 + $margin_space),$vert,0]) {
		bearing_mount();
	}	
	translate([5* ($bearing_hole_r*4 + $margin_space),$vert,0]) {
		bearing_mount();
	}	
	translate([6* ($bearing_hole_r*4 + $margin_space),$vert,0]) {
		bearing_mount();
	}
	translate([7* ($bearing_hole_r*4 + $margin_space),$vert,0]) {
		bearing_mount();
	}	
	translate([8* ($bearing_hole_r*4 + $margin_space),$vert,0]) {
		bearing_mount();
	}	
	translate([9* ($bearing_hole_r*4 + $margin_space),$vert,0]) {
		bearing_mount();
	}	
	translate([10* ($bearing_hole_r*4 + $margin_space),$vert,0]) {
		bearing_mount();
	}	
	translate([11* ($bearing_hole_r*4 + $margin_space),$vert,0]) {
		bearing_mount();
	}	
	translate([12* ($bearing_hole_r*4 + $margin_space),$vert,0]) {
		bearing_mount();
	}	
}

$2d = 0;
if ($2d) {
    projection(cut=true)
       translate([0,0,0]) rotate([0,0,0])
         make_mounts();
} else {
    make_mounts();
}