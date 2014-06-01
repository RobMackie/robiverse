$rail_w = 14.76;
$bearing_r = 11;
$bearing_hole_r = 7.9/2;
$flat_thick = 25.4/8;
$slot_w = 3.5;
$slot_l = 10;
$slot_inset = $bearing_hole_r;

module bearing_mount_body () {
   union () {
      translate([0,$bearing_hole_r*2, 0]) {
		      cube([$bearing_hole_r*4, 
                $rail_w + $bearing_r * 2 + $bearing_hole_r*4,
                $flat_thick]);
      }
      translate([$bearing_hole_r*2,$bearing_hole_r*2,0]) {
            cylinder(r=$bearing_hole_r*2, h=$flat_thick);
      }
      translate([$bearing_hole_r*2,
                 $bearing_hole_r*2+$rail_w + 
                      $bearing_r * 2 + $bearing_hole_r*4,
                 0]) {
            cylinder(r=$bearing_hole_r*2, h=$flat_thick);
      }
   }
}

module bearing_mount () {
      difference () {
          bearing_mount_body();
          translate([$bearing_hole_r*2,
                    $bearing_hole_r*2 + ($rail_w + $bearing_r * 2 + $bearing_hole_r*4)/2 - $bearing_r,
                    -1]) {
            cylinder(r=$bearing_hole_r, h=$flat_thick+2);
          }
          translate([$bearing_hole_r*2,
                     $bearing_hole_r*2 + ($rail_w + $bearing_r * 2 + $bearing_hole_r*4)/2 + $bearing_r,
                     -1]) {
            cylinder(r=$bearing_hole_r, h=$flat_thick+2);
          }
			translate([$bearing_hole_r*2 - $slot_w/2,
                    $slot_inset,
                    -1]) {
             cube([$slot_w, $slot_l, $flat_thick+2]); 
          }
			translate([$bearing_hole_r*2 - $slot_w/2,
($bearing_hole_r*4 + $rail_w + $bearing_r * 2 + $bearing_hole_r*4) - ($slot_l + $slot_inset),
                    -1]) {
             cube([$slot_w, $slot_l, $flat_thick+2]); 
          }


      }
}

$margin_space = 5;

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
